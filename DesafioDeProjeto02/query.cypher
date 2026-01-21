// ALGORITIMO 01
// Seleciona o usuário alvo pelo username
MATCH (u:User {username: $user})-[:LISTENED_TO]->(t:Track)
WITH u, t
LIMIT 30

// Encontra outros usuários que ouviram as mesmas músicas
MATCH (t)<-[:LISTENED_TO]-(v:User)
WHERE v <> u

// Calcula a similaridade com base no número de músicas em comum
WITH u, v, COUNT(*) AS similarity
ORDER BY similarity DESC
LIMIT 5

// Busca músicas ouvidas por usuários similares que o usuário alvo ainda não ouviu
MATCH (v)-[:LISTENED_TO]->(rec:Track)
WHERE NOT (u)-[:LISTENED_TO]->(rec)

// Recomenda as músicas mais populares entre os usuários similares
RETURN rec.name AS musica, COUNT(*) AS score
ORDER BY score DESC
LIMIT 10;

// ALGORITIMO 02
// Seleciona o usuário alvo pelo username e algumas de suas músicas ouvidas
MATCH (u:User {username: $user})-[:LISTENED_TO]->(t1:Track)
WITH u, t1
LIMIT 20

// Encontra outros usuários que ouviram as mesmas músicas
MATCH (t1)<-[:LISTENED_TO]-(other)-[:LISTENED_TO]->(t2:Track)

// Remove músicas já ouvidas pelo usuário alvo e evita recomendar a mesma música
WHERE t1 <> t2
  AND NOT (u)-[:LISTENED_TO]->(t2)

// Calcula a popularidade das músicas recomendadas e retorna as top 10
RETURN t2.name AS musica, COUNT(*) AS score
ORDER BY score DESC
LIMIT 10;

// ALGORITIMO 03

// Criação do timestamp
// Seleciona relacionamentos LISTENED_TO que possuem data e hora
MATCH (:User)-[l:LISTENED_TO]->(:Track)
WHERE l.date IS NOT NULL AND l.time IS NOT NULL

// Cria a propriedade timestamp combinando data e hora
SET l.timestamp = datetime(
  toString(l.date) + 'T' + toString(l.time)
);


// Seleciona o usuário alvo e limita o histórico de escuta
MATCH (u:User {username: $user})-[l1:LISTENED_TO]->(t:Track)
WITH u, t, l1
ORDER BY l1.timestamp DESC
LIMIT 30

// Encontra usuários que escutaram as mesmas músicas em um intervalo de até 1 hora
MATCH (other:User)-[l2:LISTENED_TO]->(t)
WHERE u <> other
  AND abs(duration.between(l1.timestamp, l2.timestamp).hours) <= 1
WITH u, other
LIMIT 20

// Busca músicas escutadas por usuários similares
MATCH (other)-[:LISTENED_TO]->(rec:Track)
WHERE NOT (u)-[:LISTENED_TO]->(rec)

// Retorna as recomendações finais
RETURN rec.name AS musica, COUNT(*) AS score
ORDER BY score DESC
LIMIT 10;

// Algoritmo 04
// Seleciona o usuário alvo e suas últimas 15 músicas ouvidas
MATCH (u:User {username: $user})-[l:LISTENED_TO]->(t1:Track)
WITH u, t1, l
ORDER BY l.timestamp DESC
LIMIT 15

// Encontra outros usuários que ouviram as mesmas músicas recentemente e também escutaram outras músicas
MATCH (t1)<-[:LISTENED_TO]-(v:User)-[:LISTENED_TO]->(t2:Track)
WHERE NOT (u)-[:LISTENED_TO]->(t2)

// Calcula o score combinando popularidade e recência

RETURN t2.name AS musica,
       COUNT(DISTINCT v) * 0.7 +
       SUM(1.0 / (duration.inDays(date(l.timestamp), date()).days + 1)) * 0.3
       AS score
ORDER BY score DESC
LIMIT 10;




