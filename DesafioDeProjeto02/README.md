# 🎶 Sistema de Recomendação Musical Baseado em Grafos com o Neo4j 🎶
## 1. Introdução

Este projeto tem como objetivo o desenvolvimento de uma modelagem e a criação de algoritmos de recomendação musical baseados em grafos, utilizando o banco de dados orientado a grafos Neo4j. A proposta explora as relações entre usuários, músicas, artistas e padrões temporais de escuta, com o intuito de gerar recomendações personalizadas.

A motivação principal reside na capacidade dos grafos de representar relações complexas de forma eficiente, superando limitações comuns dos bancos de dados relacionais em cenários de recomendação.

## 2. Base de Dados

Foi utilizada a base de dados [Last.fm Dataset](https://www.kaggle.com/datasets/harshal19t/lastfm-dataset), contendo o histórico de escuta de usuários.

### 2.1 Campos disponíveis

- Username: Identificador do usuário

- Artist: Nome do artista

- Track: Nome da música

- Album: Nome do álbum

- Date: Data em que a música foi escutada

- Time: Horário do dia em que o usuário ouviu a música

## 3. Modelagem Conceitual do Grafo

A modelagem do grafo foi definida a partir das principais entidades e relacionamentos presentes no domínio musical.

### 3.1 Nós (Nodes)

- User

- Track

- Artist

- Album

### 3.2 Relacionamentos

- (User)-[:LISTENED_TO]->(Track)

- (Track)-[:PERFORMED_BY]->(Artist)

- (Track)-[:IN_ALBUM]->(Album)

### 3.3 Propriedades do relacionamento LISTENED_TO

- date: data da escuta

- time: horário da escuta

Essa abordagem permite análises temporais e recomendações sensíveis à recência.

## 4. Importação e Tratamento dos Dados

Durante o processo de importação e tratamento dos dados, foram realizadas as seguintes alterações:

Remoção de aspas duplas em campos textuais do arquivo CSV, utilizando o editor de planilhas Google Sheets, a fim de evitar erros de interpretação e inconsistências na leitura dos dados pelo Neo4j.

Exclusão de registros com valores nulos diretamente no Neo4j, garantindo a integridade dos nós e relacionamentos criados.

Padronização das datas para o formato ISO 8601 no Neo4j, permitindo a correta conversão para os tipos temporais (date e datetime) e viabilizando análises baseadas em tempo.

## 5. Algoritmos de Recomendação

O objetivo principal do projeto é desenvolver algoritmos de recomendação de músicas semelhantes aos utilizados por plataformas de streaming musical. Para atingir essas expectativas, foram implementados quatro algoritmos de recomendação. Devido a restrições de custo computacional e ao grande volume de dados, algumas consultas foram limitadas com o intuito de evitar a explosão das consultas e garantir a viabilidade da execução.

### 5.1 Algoritmo 1 — Filtragem Colaborativa Baseada em Usuários (User-Based)

Recomenda músicas a partir de usuários que possuem histórico de escuta semelhante ao do usuário alvo. Os usuários são considerados similares quando escutam as mesmas músicas. As músicas escutadas por usuários similares, mas ainda não escutadas pelo usuário alvo, são recomendadas.

```cypher
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
```

### 5.2 Algoritmo 2 — Filtragem Colaborativa Baseada em Itens (Item-Based)

Recomenda músicas com base na coocorrência de escuta entre músicas, ou seja, músicas escutadas pelos mesmos usuários. As músicas são consideradas similares quando são frequentemente escutadas pelo mesmo usuário.

```cypher
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
```

### 5.3 Algoritmo 3 — Recomendação Temporal

Recomenda músicas priorizando aquelas relacionadas às escutas mais recentes do usuário. Escutas mais recentes recebem maior peso no cálculo da recomendação, tornando os resultados mais relevantes no contexto atual do usuário.

Para viabilizar essa análise, foi necessária a criação da propriedade timestamp, unificando a data e a hora da escuta em um único atributo temporal.

```cypher
// Criação do timestamp
MATCH (:User)-[l:LISTENED_TO]->(:Track)
WHERE l.date IS NOT NULL AND l.time IS NOT NULL

SET l.timestamp = datetime(
  toString(l.date) + 'T' + toString(l.time)
);

// Algoritmo 3
MATCH (u:User {username: $user})-[l1:LISTENED_TO]->(t:Track)
WITH u, t, l1
ORDER BY l1.timestamp DESC
LIMIT 30

MATCH (other:User)-[l2:LISTENED_TO]->(t)
WHERE u <> other
  AND abs(duration.between(l1.timestamp, l2.timestamp).hours) <= 1
WITH u, other
LIMIT 20

MATCH (other)-[:LISTENED_TO]->(rec:Track)
WHERE NOT (u)-[:LISTENED_TO]->(rec)

RETURN rec.name AS musica, COUNT(*) AS score
ORDER BY score DESC
LIMIT 10;
```

### 5.4 Algoritmo 4 — Recomendação Híbrida (User + Item + Tempo)

Combina similaridade entre usuários, coocorrência entre músicas e peso temporal para gerar recomendações mais precisas. O score final é calculado a partir de uma combinação ponderada das abordagens anteriores.

```cypher

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
```

## 6. Fluxo do Algoritmo de Recomendação

O algoritmo de recomendação segue o seguinte fluxo:

1. Seleção do usuário alvo

2. Identificação do histórico de escuta relevante

3. Expansão controlada no grafo para encontrar usuários ou músicas similares

4. Cálculo do score de relevância

5. Geração do ranking Top-N de músicas recomendadas

## 7. Considerações sobre Desempenho

Durante o desenvolvimento, foram observados desafios relacionados à explosão combinatória das consultas. Para mitigar esses problemas, foram adotadas as seguintes estratégias:

- Uso de LIMIT para controle de cardinalidade

- Utilização de DISTINCT em agregações

- Criação de índices para propriedades frequentemente consultadas

## Conclusão

O uso de grafos mostrou-se altamente eficaz para a implementação de sistemas de recomendação musical, permitindo a exploração de relações complexas entre usuários e itens. O projeto evidencia que abordagens baseadas em grafos oferecem flexibilidade, expressividade e potencial de escalabilidade, especialmente quando combinadas com estratégias híbridas de recomendação.