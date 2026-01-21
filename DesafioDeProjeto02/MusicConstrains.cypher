// Garante que o username do usuário seja único
CREATE CONSTRAINT user_username IF NOT EXISTS
FOR (u:user)
REQUIRE u.usernamet IS UNIQUE;

// Garante que o nome do artista seja único
CREATE CONSTRAINT artist_name IF NOT EXISTS
FOR (a:Artist)
REQUIRE a.name IS UNIQUE;

// Garante que o nome da música seja único
CREATE CONSTRAINT track_name IF NOT EXISTS
FOR(t:Track)
REQUIRE t.name IS UNIQUE;

// Garante que o nome do álbum seja único
CREATE CONSTRAINT album_name IF NOT EXISTS
FOR(al:Album)
REQUIRE al.name IS UNIQUE;