// Carrega os dados do arquivo CSV com cabeçalhos
LOAD CSV WITH HEADERS FROM 'file:///Last.fm_data.csv' AS row

// Filtra linhas com dados completos
WITH row
WHERE row.Username IS NOT NULL AND trim(row.Username) <> ''
  AND row.Artist IS NOT NULL AND trim(row.Artist) <> ''
  AND row.Track IS NOT NULL AND trim(row.Track) <> ''
  AND row.Album IS NOT NULL AND trim(row.Album) <> ''
  AND row.Date IS NOT NULL AND trim(row.Date) <> ''
  AND row.Time IS NOT NULL AND trim(row.Time) <> ''

// Cria ou encontra os nós e relacionamentos no grafo
MERGE (u:User {username: row.Username})
MERGE (ar:Artist {name: row.Artist})
MERGE (al:Album {name: row.Album})
MERGE (t:Track {name: row.Track})

// Cria relacionamentos estruturais do dominío musical
MERGE (t)-[:PERFORMED_BY]->(ar)
MERGE (t)-[:IN_ALBUM]->(al)

// Cria o relacionamento de escuta com atributos temporais
MERGE (u)-[l:LISTENED_TO {
  date: row.Date,
  time: row.Time
}]->(t);
