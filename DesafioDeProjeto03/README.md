# 📈 Analisando Dados de Redes Sociais com Base em Consultas de Grafos 📊

## 1. Introdução

Este projeto tem como objetivo aplicar a linguagem Cypher na modelagem de um banco de dados orientado a grafos utilizando o Neo4j, com foco na análise comportamental de usuários em redes sociais.

A proposta consiste em estruturar entidades como usuários, posts, hashtags e plataformas em um modelo relacional em grafo, permitindo explorar conexões, padrões de engajamento e interações de forma mais intuitiva e eficiente do que em modelos tradicionais relacionais.

A partir dessa modelagem, são realizadas análises voltadas ao comportamento dos usuários, incluindo métricas de engajamento, similaridade de interesses, padrões de consumo de conteúdo e segmentação comportamental.

## 2. Base de Dados

Foi utilizada a base de dados [Social Media Engagement Dataset](https://www.kaggle.com/datasets/subashmaster0411/social-media-engagement-dataset?resource=download), disponível no Kaggle, contendo o histórico de interações de usuários em redes sociais. O conjunto de dados reúne informações sobre publicações, métricas de engajamento (curtidas, comentários, compartilhamentos e impressões), sentimentos, emoções e nível de toxicidade do conteúdo, possibilitando análises comportamentais e estratégicas a partir da modelagem em grafos.

## 3 Modelagem Conceitual do Grafo

Com o objetivo de analisar o comportamento dos usuários na rede social, foi desenvolvida uma modelagem orientada a grafos estruturando entidades como usuários, publicações, plataformas e hashtags.

A estrutura prioriza as interações entre esses elementos, permitindo identificar padrões de engajamento, relações comportamentais e conexões relevantes entre os dados.

### 3.1 Nós (Nodes)

- **User**: Identificador do usuário de cada Plataforma.
*Propriedades: user_id, location e language.*

- **Post**: Conteúdo publicado.
*Propriedades: post_id, timestamp, day_of_week, topic_category, sentiment_score, sentiment_label, emotion_type e toxicity_score.*

- **Hashtag**: Hashtag utilizada no post.
*Propriedades: name.*

- **Plataform**: Rede social na qual o post foi publicado.
*Propriedade: name.*

### 3.2 Relacionamentos

- **(:User)-[:ENGAGED_WITH]->(:Post)**
*Relacionamento que representa ainteração do usuário com o post.*

- **(:Post)-[:PUBLISHED_ON]->(:Platform)**
*Indica onde o post foi pulicado.*

- **(:Post)-[:HAS_HASHTAG]->(:Hashtag)**
*Relaciona post com suas hashtas.*

## 4. Importação e Tratamento dos Dados

Os dados foram importados a partir de um arquivo CSV público utilizando a cláusula LOAD CSV WITH HEADERS. Durante o processo, foram criados nós para usuários, publicações, plataformas e hashtags, além dos relacionamentos que representam as interações entre eles.

Foram utilizados comandos MERGE para evitar duplicidades e garantir consistência dos dados. Campos compostos, como hashtags, foram tratados com split() e UNWIND, permitindo a criação adequada das conexões no grafo.

## 5. 🔎 Consultas Analíticas no Banco de Dados em Grafo

As consultas desenvolvidas neste projeto têm como objetivo explorar o potencial analítico de um banco de dados orientado a grafos para compreender padrões de comportamento dos usuários. Utilizando a estrutura de relacionamentos entre usuários e posts, foi possível calcular métricas de engajamento, identificar perfis comportamentais e analisar preferências por categorias de conteúdo.

Essas análises demonstram como a modelagem em grafo facilita a extração de insights estratégicos a partir das conexões entre os dados, permitindo segmentações mais inteligentes e suporte à tomada de decisão baseada em comportamento e interação.

### 5.1 Consulta 1 - Classificação de Engajamento de Usuários

Esta consulta tem como objetivo calcular o engajamento total de cada usuário com base nas interações realizadas nos posts, considerando curtidas, comentários e compartilhamentos. A partir dessas métricas, é criado um score ponderado de engajamento, atribuindo pesos diferentes para cada tipo de interação, de modo a refletir melhor o impacto de cada ação.

Com base nesse score, os usuários são classificados em perfis de engajamento (Baixo, Médio ou Alto), permitindo uma segmentação estratégica da base. Por fim, os resultados são apresentados em ordem decrescente de engajamento, facilitando a identificação dos usuários mais ativos e influentes na rede.

```cypher
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
```

### 5.2 Consulta 2 - Perfil Comportamental por Diversidade de Interesses

O objetivo desta consulta é identificar os diferentes temas (topic_category) com os quais cada usuário interagiu, calculando a diversidade de interesses de cada usuário. A partir disso, os usuários são classificados em perfis comportamentais com base nessa diversidade e ordenados do mais diverso para o menos diverso.

```cypher
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
```

### 5.3 Consulta 3  — Engajamento por Perfil e Categoria

Esta consulta tem como objetivo calcular o score total de engajamento de cada usuário, classificando-os em perfis de Baixo, Médio ou Alto engajamento. Além disso, agrupa o engajamento por categoria de conteúdo e exibe o total de interações por perfil e por categoria.

Essa análise permite identificar quais categorias geram mais engajamento dentro de cada tipo de usuário, auxiliando na segmentação e na definição de estratégias mais direcionadas.

```cypher
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
```

## ✅ Conclusão

Este projeto demonstrou como um banco de dados orientado a grafos pode ser utilizado de forma estratégica para análises comportamentais e geração de insights relevantes. A partir da modelagem das interações entre usuários e posts, foi possível calcular métricas de engajamento, identificar padrões de interesse e segmentar usuários com base em seus comportamentos.

As consultas desenvolvidas evidenciam o poder do modelo em grafo para explorar relacionamentos complexos de maneira intuitiva e eficiente, permitindo análises que vão além de simples agregações. Com isso, o projeto reforça como tecnologias como o Neo4j podem apoiar estratégias de marketing, personalização de conteúdo e tomada de decisão orientada a dados.

Além do aspecto técnico, a aplicação prática das consultas demonstra uma abordagem analítica voltada para negócios, unindo modelagem de dados, lógica de classificação e interpretação estratégica dos resultados.