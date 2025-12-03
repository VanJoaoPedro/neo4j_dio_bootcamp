// -----------------------------------------------------------------------------
// CRIAÇÃO DE UM MINI-MODELO COMPLETO DE REDE DE ENTRETENIMENTO NO NEO4J
// O bloco abaixo cria nós de Pessoa (atores, usuários, diretores),
// séries, filmes e categorias, além dos relacionamentos entre eles.
// -----------------------------------------------------------------------------

CREATE
    
    // -------------------------------------------------------------------------
    // ATORES
    // Cria um nó Actor (tipo Person) com dados pessoais do ator
    // e cria um relacionamento ACTED_IN ligando o ator a uma Série,
    // incluindo o personagem interpretado e o papel desempenhado.
    // -------------------------------------------------------------------------
    (Actor:Person {
        actorId: "",
        name: "",
        birthYear: "",
        bio: "",
        nationality: ""
    })-[:ACTED_IN {
        character: "",
        role: ""
    }]->

    // -------------------------------------------------------------------------
    // SÉRIES
    // Cria um nó Serie (tipo Series) com dados da obra.
    // -------------------------------------------------------------------------
    (Serie:Series {
        serieId: "",
        title: "",
        releaseYear: "",
        description: "",
        seasons: "",
        episodes: "",
        rating: "",
        ageRating: ""
    })

    // -------------------------------------------------------------------------
    // RELACIONAMENTO WATCHED (User assistiu Serie)
    // Um usuário assistiu a série, registrando nota, data e favorito.
    // -------------------------------------------------------------------------
    <-[:WATCHED {
        rating: "",
        watchedOn: "",
        isFavorite: ""
    }]-

    // -------------------------------------------------------------------------
    // USUÁRIO
    // Cria o nó User (tipo Person), com informações do usuário.
    // -------------------------------------------------------------------------
    (User:Person {
        userId: "",
        name: "",
        email: "",
        birthYear: "",
        country: "",
        createdAt: ""
    })

    // -------------------------------------------------------------------------
    // RELACIONAMENTO WATCHED (User assistiu Movie)
    // O usuário assistiu o filme com sua nota, data e favorito.
    // -------------------------------------------------------------------------
    -[:WATCHED {
        rating: "",
        watchedOn: "",
        isFavorite: ""
    }]->

    // -------------------------------------------------------------------------
    // FILMES
    // Cria o nó Movie (tipo Movies) representando um filme.
    // -------------------------------------------------------------------------
    (Movie:Movies {
        movieId: "",
        title: "",
        releaseYear: "",
        description: "",
        rating: "",
        ageRating: "",
        language: ""
    })

    // -------------------------------------------------------------------------
    // CLASSIFICAÇÃO DE FILME POR GÊNERO
    // O filme pertence a uma categoria (gênero).
    // -------------------------------------------------------------------------
    -[:CLASSIFIES]->

    // -------------------------------------------------------------------------
    // GÊNEROS
    // Cria o nó Genre representando uma categoria cinematográfica.
    // -------------------------------------------------------------------------
    (Genre:Category {
        genreId: "",
        name: ""
    })

    // -------------------------------------------------------------------------
    // CLASSIFICAÇÃO DA SÉRIE PELO MESMO GÊNERO
    // Conecta a série ao mesmo gênero.
    // -------------------------------------------------------------------------
    <-[:CLASSIFIES]-(Serie)

    // -------------------------------------------------------------------------
    // DIRETOR
    // Um diretor dirigiu tanto a série quanto o filme.
    // -------------------------------------------------------------------------
    <-[:DIRECTED_BY]-(Director:Person {
        directorId: "",
        name: "",
        birthYear: "",
        nationality: "",
        bio: ""
    }),

    // -------------------------------------------------------------------------
    // PREFERÊNCIAS DO USUÁRIO
    // O usuário prefere determinado gênero.
    // -------------------------------------------------------------------------
    (User)-[:PREFERS]->(Genre),

    // -------------------------------------------------------------------------
    // ATOR TAMBÉM ATUOU NO FILME
    // Relacionamento para indicar que o ator atuou no filme.
    // -------------------------------------------------------------------------
    (Actor)-[:ACTED_IN]->(Movie)

    // -------------------------------------------------------------------------
    // DIRETOR TAMBÉM DIRIGIU O FILME
    // -------------------------------------------------------------------------
    <-[:DIRECTED_BY]-(Director);
