// -------------------------------------------------------------
// QUESTÃO 01 – Filmes e séries mais bem avaliados
// Retorna os 20 títulos com as melhores avaliações (rating).
// Inclui filmes e séries assistidos, juntamente com o tipo.
// -------------------------------------------------------------


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

// ----------------------------------------------------------------------
// QUESTÃO 02 – Filmes e séries assistidos por mais de uma pessoa
// Conta quantos usuários assistiram cada título e ordena do mais visto
// para o menos visto.
// ----------------------------------------------------------------------

MATCH (p:Person)-[w:WATCHED]->(ms)
WHERE ms:Movies OR ms:Series
WITH ms, count(p) AS totalWatched
RETURN 
    ms.title AS Title,
    totalWatched
ORDER BY totalWatched DESC;

// ----------------------------------------------------------------------
// QUESTÃO 03 – Filmes e séries marcados como favoritos
// Lista quem marcou como favorito, o título e o tipo (filme/série).
// Apenas registros onde w.isFavorite = true.
// ----------------------------------------------------------------------

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

// ----------------------------------------------------------------------
// QUESTÃO 04 – Top 5 diretores mais bem avaliados
// Retorna os diretores com os títulos mais bem avaliados,
// ordenando pelos ratings mais altos.
// ----------------------------------------------------------------------

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

// ----------------------------------------------------------------------
// QUESTÃO 05 – Top 5 gêneros mais bem avaliados
// Lista os gêneros (categories) com avaliações mais altas,
// retornando o título, o gênero e o tipo (filme/série).
// ----------------------------------------------------------------------


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