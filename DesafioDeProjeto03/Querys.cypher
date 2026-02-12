// 01 Análise de Intensidade de Engajamento por Usuário

MATCH (u:User)-[e:ENGAGED_WITH]->(p:Post)

// Agregação das métricas
WITH u,
     SUM(e.likes_count) AS total_likes,
     SUM(e.comments_count) AS total_comments,
     SUM(e.shares_count) AS total_shares,
     SUM(e.likes_count + 2*e.comments_count + 3*e.shares_count) AS engagement_score

// Classificação do perfil do Usuario
WITH u,
     total_likes,
     total_comments,
     total_shares,
     engagement_score,
     CASE 
         WHEN engagement_score < 100 THEN "Baixo Engajamento"
         WHEN engagement_score < 500 THEN "Médio Engajamento"
         ELSE "Alto Engajamento"
     END AS user_profile

// Retorno dos resultado. 
RETURN u.user_id,
       total_likes,
       total_comments,
       total_shares,
       engagement_score,
       user_profile
ORDER BY engagement_score DESC;


// 02 Análise de Polarização Emocional do Usuário

MATCH (u:User)-[:ENGAGED_WITH]->(p:Post)

// Coleta das categorias distintas
WITH u, collect(DISTINCT p.topic_category) AS categorias

RETURN u.user_id,
       categorias,
       // Calculo da Diversidade de interesses
       size(categorias) AS diversidade_interesses,
       // Classificação do perfil comportamental.
       CASE
         WHEN size(categorias) = 1 THEN "Especialista"
         WHEN size(categorias) <= 3 THEN "Moderado"
         ELSE "Generalista"
       END AS perfil_comportamental
ORDER BY diversidade_interesses DESC;

// 03 Preferência de Conteúdo por Perfil de Usuário

MATCH (u:User)-[e:ENGAGED_WITH]->(p:Post)

// Calculo do Score e Engajamento por Categoria
WITH u,
     SUM(e.likes_count + 2*e.comments_count + 3*e.shares_count) AS score,
     p.topic_category AS categoria,
     SUM(e.likes_count + e.comments_count + e.shares_count) AS engagement_categoria

// Classificação do perfil do Usuário
WITH u, score, categoria, engagement_categoria,
     CASE 
         WHEN score < 100 THEN "Baixo"
         WHEN score < 500 THEN "Médio"
         ELSE "Alto"
     END AS perfil

RETURN perfil,
       categoria,
       SUM(engagement_categoria) AS total_engagement
ORDER BY perfil, total_engagement DESC;



