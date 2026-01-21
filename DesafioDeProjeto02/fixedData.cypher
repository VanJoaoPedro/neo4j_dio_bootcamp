// Seleciona todas as relações LISTENED_TO no grafo
MATCH () - [l:LISTENED_TO]->()

// Substitui os meses em português por seus equivalentes numéricos
WITH l,
    replace(l.date,' jan. ','-01-') as d1,
    replace(l.date,' fev. ','-02-') as d2,
    replace(l.date,' mar. ','-03-') as d3,
    replace(l.date,' abr. ','-04-') as d4,
    replace(l.date,' mai. ','-05-') as d5,
    replace(l.date,' jun. ','-06-') as d6,
    replace(l.date,' jul. ','-07-') as d7,
    replace(l.date,' ago. ','-08-') as d8,
    replace(l.date,' set. ','-09-') as d9,
    replace(l.date,' out. ','-10-') as d10,
    replace(l.date,' nov. ','-11-') as d11,
    replace(l.date,' dez. ','-12-') as d12

// Seleciona a data corrigida
WITH l,
    coalesce(d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12) AS fixedDate
SET l._fixedDate = fixedDate;

// Converte a data corrigida para o formato ISO (YYYY-MM-DD)
WHERE l._fixedDate IS NOT NULL
WITH l,
    substring(l._fixedDate, 6, 4) + '-' +
    substring(l._fixedDate, 3, 2) + '-' +
    substring(l._fixedDate, 0, 2) as isoDate
SET l.date_iso = date(isoDate)

// Limpa propriedades temporárias usadas na conversão
REMOVE l._fixedDate;
SET l.date = l.date_iso
REMOVE l.date_iso;