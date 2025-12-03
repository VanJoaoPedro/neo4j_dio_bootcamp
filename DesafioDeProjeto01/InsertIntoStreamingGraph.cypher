// ======================
// CRIAÇÃO DOS USUÁRIOS
// ======================
CREATE
(u1:Person {userId:"U1", name:"Alice Santos", email:"alice@example.com", birthYear:1995, country:"Brasil", createdAt:"2023-01-10"}),
(u2:Person {userId:"U2", name:"Bruno Lima", email:"bruno@example.com", birthYear:1990, country:"Brasil", createdAt:"2023-02-14"}),
(u3:Person {userId:"U3", name:"Carla Mendes", email:"carla@example.com", birthYear:1998, country:"Portugal", createdAt:"2023-03-21"}),
(u4:Person {userId:"U4", name:"Daniel Souza", email:"daniel@example.com", birthYear:1988, country:"Brasil", createdAt:"2023-04-12"}),
(u5:Person {userId:"U5", name:"Eduardo Alves", email:"edu@example.com", birthYear:1997, country:"EUA", createdAt:"2023-05-02"}),
(u6:Person {userId:"U6", name:"Fernanda Costa", email:"fer@example.com", birthYear:1993, country:"México", createdAt:"2023-06-06"}),
(u7:Person {userId:"U7", name:"Gabriel Nunes", email:"gabe@example.com", birthYear:1999, country:"Brasil", createdAt:"2023-07-15"}),
(u8:Person {userId:"U8", name:"Helena Dias", email:"helena@example.com", birthYear:1992, country:"Espanha", createdAt:"2023-08-18"}),
(u9:Person {userId:"U9", name:"Igor Ramos", email:"igor@example.com", birthYear:1985, country:"Brasil", createdAt:"2023-09-03"}),
(u10:Person {userId:"U10", name:"Julia Rocha", email:"julia@example.com", birthYear:1996, country:"Argentina", createdAt:"2023-10-01"});

// ======================
// CRIAÇÃO DOS GÊNEROS
// ======================
CREATE
(g1:Category {genreId:"G1", name:"Ação"}),
(g2:Category {genreId:"G2", name:"Drama"}),
(g3:Category {genreId:"G3", name:"Comédia"}),
(g4:Category {genreId:"G4", name:"Terror"}),
(g5:Category {genreId:"G5", name:"Ficção Científica"}),
(g6:Category {genreId:"G6", name:"Romance"}),
(g7:Category {genreId:"G7", name:"Fantasia"}),
(g8:Category {genreId:"G8", name:"Suspense"}),
(g9:Category {genreId:"G9", name:"Crime"}),
(g10:Category {genreId:"G10", name:"Aventura"});

// ======================
// CRIAÇÃO DOS FILMES
// ======================
CREATE
(m1:Movies {movieId:"M1", title:"Vingança Final", releaseYear:2021, description:"Um ex-soldado busca justiça.", rating:8.1, ageRating:"16", language:"Inglês"}),
(m2:Movies {movieId:"M2", title:"O Último Suspiro", releaseYear:2020, description:"Drama intenso sobre superação.", rating:7.5, ageRating:"14", language:"Português"}),
(m3:Movies {movieId:"M3", title:"Risos em Família", releaseYear:2022, description:"Comédia leve e divertida.", rating:6.9, ageRating:"12", language:"Espanhol"}),
(m4:Movies {movieId:"M4", title:"A Casa Sombria", releaseYear:2019, description:"Terror psicológico.", rating:7.8, ageRating:"18", language:"Inglês"}),
(m5:Movies {movieId:"M5", title:"Galáxia Zero", releaseYear:2023, description:"Sci-fi espacial épico.", rating:8.7, ageRating:"14", language:"Inglês"}),
(m6:Movies {movieId:"M6", title:"Amor Inesperado", releaseYear:2021, description:"Romance emocionante.", rating:7.2, ageRating:"12", language:"Português"}),
(m7:Movies {movieId:"M7", title:"Reino dos Antigos", releaseYear:2018, description:"Fantasia heroica.", rating:8.4, ageRating:"14", language:"Inglês"}),
(m8:Movies {movieId:"M8", title:"Sombra da Verdade", releaseYear:2020, description:"Suspense investigativo.", rating:8.0, ageRating:"16", language:"Inglês"}),
(m9:Movies {movieId:"M9", title:"Cidade Corrompida", releaseYear:2022, description:"Crime organizado e corrupção.", rating:7.9, ageRating:"18", language:"Português"}),
(m10:Movies {movieId:"M10", title:"Mundo Perdido", releaseYear:2017, description:"Aventura em terras desconhecidas.", rating:7.3, ageRating:"10", language:"Inglês"});

// ======================
// CRIAÇÃO DAS SÉRIES
// ======================
CREATE
(s1:Series {serieId:"S1", title:"Sombras do Passado", releaseYear:2019, description:"Mistérios sombrios.", seasons:3, episodes:28, rating:8.3, ageRating:"16"}),
(s2:Series {serieId:"S2", title:"Corações em Fogo", releaseYear:2021, description:"Romance dramático.", seasons:2, episodes:20, rating:7.4, ageRating:"14"}),
(s3:Series {serieId:"S3", title:"Rindo Alto", releaseYear:2020, description:"Comédia pastelão.", seasons:4, episodes:40, rating:6.8, ageRating:"12"}),
(s4:Series {serieId:"S4", title:"Noite Eterna", releaseYear:2022, description:"Terror sobrenatural.", seasons:1, episodes:10, rating:7.9, ageRating:"18"}),
(s5:Series {serieId:"S5", title:"Fronteira Estelar", releaseYear:2023, description:"Exploração espacial.", seasons:1, episodes:12, rating:8.6, ageRating:"14"}),
(s6:Series {serieId:"S6", title:"Destino Real", releaseYear:2018, description:"Drama histórico.", seasons:3, episodes:30, rating:8.1, ageRating:"12"}),
(s7:Series {serieId:"S7", title:"Magia Arcana", releaseYear:2017, description:"Fantasia mágica.", seasons:5, episodes:55, rating:8.4, ageRating:"12"}),
(s8:Series {serieId:"S8", title:"Linha do Medo", releaseYear:2019, description:"Suspense intenso.", seasons:2, episodes:18, rating:7.7, ageRating:"16"}),
(s9:Series {serieId:"S9", title:"Força Bruta", releaseYear:2020, description:"Ação militar.", seasons:3, episodes:36, rating:8.0, ageRating:"16"}),
(s10:Series {serieId:"S10", title:"Ilha Perdida", releaseYear:2022, description:"Aventura misteriosa.", seasons:1, episodes:8, rating:7.5, ageRating:"10"});

// ======================
// CRIAÇÃO DE ATORES
// ======================
CREATE
(a1:Person {actorId:"A1", name:"Marcos Ribeiro", birthYear:1980, bio:"Ator brasileiro.", nationality:"Brasil"}),
(a2:Person {actorId:"A2", name:"Laura Farias", birthYear:1990, bio:"Atriz premiada.", nationality:"Portugal"}),
(a3:Person {actorId:"A3", name:"Hugo Martinez", birthYear:1985, bio:"Ator espanhol.", nationality:"Espanha"}),
(a4:Person {actorId:"A4", name:"Sarah Collins", birthYear:1992, bio:"Atriz norte-americana.", nationality:"EUA"}),
(a5:Person {actorId:"A5", name:"Tom Garcia", birthYear:1988, bio:"Ator de ação.", nationality:"México"}),
(a6:Person {actorId:"A6", name:"Elisa Monteiro", birthYear:1995, bio:"Atriz jovem.", nationality:"Brasil"}),
(a7:Person {actorId:"A7", name:"Carlos Nuñez", birthYear:1983, bio:"Ator dramático.", nationality:"Argentina"}),
(a8:Person {actorId:"A8", name:"Sophie Turner", birthYear:1991, bio:"Atriz britânica.", nationality:"Reino Unido"}),
(a9:Person {actorId:"A9", name:"Rafael Costa", birthYear:1986, bio:"Ator versátil.", nationality:"Brasil"}),
(a10:Person {actorId:"A10", name:"Emily Clark", birthYear:1993, bio:"Atriz de fantasia.", nationality:"EUA"});

// ======================
// CRIAÇÃO DE DIRETORES
// ======================
CREATE
(d1:Person {directorId:"D1", name:"João Martins", birthYear:1970, nationality:"Brasil", bio:"Diretor de ação"}),
(d2:Person {directorId:"D2", name:"Ana Duarte", birthYear:1975, nationality:"Portugal", bio:"Especialista em drama"}),
(d3:Person {directorId:"D3", name:"Michael Roberts", birthYear:1965, nationality:"EUA", bio:"Diretor multipremiado"}),
(d4:Person {directorId:"D4", name:"Lucia Gomez", birthYear:1978, nationality:"Espanha", bio:"Diretora de terror"}),
(d5:Person {directorId:"D5", name:"Kenji Tanaka", birthYear:1980, nationality:"Japão", bio:"Diretor de sci-fi"}),
(d6:Person {directorId:"D6", name:"Carla Silva", birthYear:1982, nationality:"Brasil", bio:"Diretora de romance"}),
(d7:Person {directorId:"D7", name:"Peter Hall", birthYear:1969, nationality:"Reino Unido", bio:"Diretor de fantasia"}),
(d8:Person {directorId:"D8", name:"Amanda Reyes", birthYear:1976, nationality:"México", bio:"Diretora de suspense"}),
(d9:Person {directorId:"D9", name:"George Clark", birthYear:1973, nationality:"EUA", bio:"Diretor de crime"}),
(d10:Person {directorId:"D10", name:"Elena Ricci", birthYear:1977, nationality:"Itália", bio:"Diretora de aventura"});

// ======================
// RELACIONAMENTOS
// ======================

// Usuários preferem gêneros
MATCH (u1:Person {userId:"U1"}), (g1:Category {genreId:"G1"}) CREATE (u1)-[:PREFERS]->(g1);
MATCH (u2),(g2) WHERE u2.userId="U2" AND g2.genreId="G2" CREATE (u2)-[:PREFERS]->(g2);
MATCH (u3),(g3) WHERE u3.userId="U3" AND g3.genreId="G3" CREATE (u3)-[:PREFERS]->(g3);
MATCH (u4),(g4) WHERE u4.userId="U4" AND g4.genreId="G4" CREATE (u4)-[:PREFERS]->(g4);
MATCH (u5),(g5) WHERE u5.userId="U5" AND g5.genreId="G5" CREATE (u5)-[:PREFERS]->(g5);
MATCH (u6),(g6) WHERE u6.userId="U6" AND g6.genreId="G6" CREATE (u6)-[:PREFERS]->(g6);
MATCH (u7),(g7) WHERE u7.userId="U7" AND g7.genreId="G7" CREATE (u7)-[:PREFERS]->(g7);
MATCH (u8),(g8) WHERE u8.userId="U8" AND g8.genreId="G8" CREATE (u8)-[:PREFERS]->(g8);
MATCH (u9),(g9) WHERE u9.userId="U9" AND g9.genreId="G9" CREATE (u9)-[:PREFERS]->(g9);
MATCH (u10),(g10) WHERE u10.userId="U10" AND g10.genreId="G10" CREATE (u10)-[:PREFERS]->(g10);

// Filmes classificados em gêneros
UNWIND range(1,10) AS i
MATCH (m:Movies {movieId: "M"+i}), (g:Category {genreId: "G"+i})
CREATE (m)-[:CLASSIFIES]->(g);

// Séries classificadas em gêneros
UNWIND range(1,10) AS i
MATCH (s:Series {serieId: "S"+i}), (g:Category {genreId: "G"+i})
CREATE (s)-[:CLASSIFIES]->(g);

// Diretores dirigem filmes e séries
UNWIND range(1,10) AS i
MATCH (m:Movies {movieId:"M"+i}), (s:Series {serieId:"S"+i}), (d:Person {directorId:"D"+i})
CREATE (d)-[:DIRECTED_BY]->(m),
       (d)-[:DIRECTED_BY]->(s);

// Atores atuam nos filmes e séries
UNWIND range(1,10) AS i
MATCH (m:Movies {movieId:"M"+i}), (s:Series {serieId:"S"+i}), (a:Person {actorId:"A"+i})
CREATE (a)-[:ACTED_IN {character:"Personagem "+i, role:"Principal"}]->(m),
       (a)-[:ACTED_IN {character:"Personagem "+i, role:"Apoio"}]->(s);

// Usuários assistem filmes
UNWIND range(1,10) AS i
MATCH (u:Person {userId:"U"+i}), (m:Movies {movieId:"M"+i})
CREATE (u)-[:WATCHED {rating: 7 + rand(), watchedOn:"2024-01-"+i, isFavorite: i % 2 = 0}]->(m);

// Usuários assistem séries
UNWIND range(1,10) AS i
MATCH (u:Person {userId:"U"+i}), (s:Series {serieId:"S"+i})
CREATE (u)-[:WATCHED {rating: 8 + rand(), watchedOn:"2024-02-"+i, isFavorite: i % 2 = 1}]->(s);
