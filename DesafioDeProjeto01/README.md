## Sistema de Streaming

Neo4J - Análise de Dados com Grafos

## Descrição

Este projeto foi desenvolvido como parte do bootcamp da DIO, com foco na análise de dados utilizando grafos no Neo4J.&#x20;



## Estrutura do Banco de Dados

A modelagem do banco de dados foi realizada utilizando o site **arrows.app**, que permitiu a criação visual dos nós e relacionamentos. A partir desse modelo, o próprio site gerou o código Cypher usado para criar toda a estrutura no Neo4J.

O banco representa uma **rede de entretenimento**, conectando pessoas, obras audiovisuais e preferências de usuários. Abaixo está uma descrição detalhada da estrutura:

A inserção dos dados também foi realizada com o auxílio do ChatGPT, utilizando o código gerado pelo arrows.app como base para a criação e povoamento do banco.

### **1. Nós (Nodes)**

#### **Person (Actor, Director e User)**

O modelo utiliza o rótulo `Person` para representar atores, diretores e usuários, diferenciados pelos atributos:

- **Actor**: informações como nome, ano de nascimento, biografia e nacionalidade.
- **Director**: dados pessoais semelhantes, indicando quem dirigiu filmes e séries.
- **User**: usuários da plataforma, contendo e-mail, país, ano de nascimento e data de criação da conta.

#### **Series (Serie)**

Representa séries de TV, com atributos como:

- Título, ano de lançamento, número de temporadas e episódios, sinopse e classificação indicativa.

#### **Movies (Movie)**

Representa filmes, com informações como:

- Título, descrição, idioma, ano de lançamento e classificação etária.

#### **Category (Genre)**

Representa categorias ou gêneros (ex.: Ação, Comédia, Drama), associadas tanto a filmes quanto a séries.

---

### **2. Relacionamentos (Relationships)**

#### **ACTED\_IN**

Conecta um `Actor` a uma série ou filme, incluindo atributos como:

- Personagem interpretado
- Papel desempenhado

#### **WATCHED**

Relaciona um `User` a um filme ou série, registrando:

- Nota atribuída
- Data em que foi assistido
- Se marcou como favorito

#### **CLASSIFIES**

Conecta filmes e séries ao gênero correspondente (`Category`).

#### **DIRECTED\_BY**

Associa um diretor (`Person`) a filmes e séries que dirigiu.

#### **PREFERS**

Relacionamento que indica os gêneros preferidos de um usuário.

---

### **3. Estrutura Geral**

O banco de dados forma uma rede interligada onde:

- Usuários podem assistir e avaliar filmes/séries.
- Filmes e séries pertencem a gêneros.
- Atores e diretores se relacionam com suas produções.
- Preferências dos usuários ajudam a identificar recomendações.

Essa estrutura cria um ambiente ideal para análises baseadas em grafos, como:

- Identificação de padrões de consumo
- Recomendações personalizadas
- Relações entre atores, diretores e categorias

## Consultas Cypher Realizadas

Para validar o funcionamento da linguagem **Cypher** e testar a estrutura desenvolvida no banco de dados, foram executadas **5 consultas principais**, cada uma explorando aspectos diferentes do modelo.

### **1. Filmes e séries mais bem avaliados**

Retorna os 20 títulos com melhores avaliações feitas pelos usuários.

```cypher
MATCH (p:Person)-[w:WATCHED]->(ms)
WHERE ms:Movies OR ms:Series
RETURN 
    ms.title AS Title, 
    round(w.rating) AS Rating,
    CASE
        WHEN ms:Series THEN "Serie"
        WHEN ms:Movies THEN "Movie"
    END AS Type
ORDER BY w.rating DESC 
LIMIT 20;
```

### **2. Filmes e séries assistidos por mais de uma pessoa**

Conta quantos usuários assistiram cada obra.

```cypher
MATCH (p:Person)-[w:WATCHED]->(ms)
WHERE ms:Movies OR ms:Series
WITH ms, count(p) AS totalWatched
RETURN 
    ms.title AS Title,
    totalWatched
ORDER BY totalWatched DESC;
```

### **3. Filmes e séries favoritos**

Lista quem marcou como favorito, o título e o tipo.

```cypher
MATCH (p:Person)-[d:DIRECTED_BY]->(ms)
WHERE ms:Movies OR ms:Series
RETURN 
    p.name AS Director_name, 
    ms.title AS Title, 
    round(ms.rating) AS Rating,
    CASE
        WHEN ms:Series THEN "Serie"
        WHEN ms:Movies THEN "Movie"
    END AS Type
ORDER BY ms.rating DESC 
LIMIT 5;
```

### **4. Top 5 diretores mais bem avaliados**

Lista os diretores com as obras mais bem avaliadas.

```cypher
MATCH (p:Person)-[d:DIRECTED_BY]->(ms)
WHERE ms:Movies OR ms:Series
RETURN 
    p.name AS Director_name, 
    ms.title AS Title, 
    round(ms.rating) AS Rating,
    CASE
        WHEN ms:Series THEN "Serie"
        WHEN ms:Movies THEN "Movie"
    END AS Type
ORDER BY ms.rating DESC 
LIMIT 5;
```

### **5. Top 5 gêneros mais bem avaliados**

Mostra os gêneros com melhores avaliações.

```cypher
MATCH (ms)-[cl:CLASSIFIES]->(ca:Category)
WHERE ms:Movies OR ms:Series
RETURN 
    ms.title AS Title, 
    ca.name AS Genre, 
    round(ms.rating) AS Rating,
    CASE
        WHEN ms:Series THEN "Serie"
        WHEN ms:Movies THEN "Movie"
    END AS Type
ORDER BY ms.rating DESC 
LIMIT 5;
```

## Conclusão

O desenvolvimento deste projeto permitiu explorar de forma prática as principais características de um **banco de dados orientado a grafos**, destacando como esse tipo de tecnologia é especialmente eficiente para representar relações complexas entre entidades. Diferente de bancos relacionais tradicionais, o Neo4j se destaca pela:

- **Modelagem intuitiva por nós e relacionamentos**, facilitando a visualização e compreensão da estrutura dos dados.
- **Flexibilidade**, permitindo evoluir a estrutura sem necessidade de grandes reformulações.
- **Alta performance em consultas relacionais**, já que as conexões são armazenadas diretamente no grafo.
- **Linguagem Cypher**, que torna a manipulação e consulta extremamente fluida, próxima de uma descrição natural das relações.

A experiência de utilização do Neo4j foi bastante positiva. A modelagem realizada via *arrows.app* tornou o processo visual e eficiente, enquanto a execução das consultas Cypher demonstrou a força do grafo na análise de dados interconectados. Além disso, observar como os relacionamentos enriquecem o contexto das informações reforça o potencial desse tipo de banco de dados para aplicações como recomendações, redes sociais, sistemas de entretenimento e muito mais.

O projeto permitiu compreender com clareza o poder dos grafos e consolidou uma base sólida para futuros estudos e aplicações mais avançadas na área.
