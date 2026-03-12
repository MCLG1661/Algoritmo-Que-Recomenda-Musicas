// Criar constraints e índices
CREATE CONSTRAINT user_id IF NOT EXISTS FOR (u:User) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT music_id IF NOT EXISTS FOR (m:Music) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT artist_id IF NOT EXISTS FOR (a:Artist) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT genre_id IF NOT EXISTS FOR (g:Genre) REQUIRE g.name IS UNIQUE;

// Criar índices para performance
CREATE INDEX user_name IF NOT EXISTS FOR (u:User) ON (u.name);
CREATE INDEX music_title IF NOT EXISTS FOR (m:Music) ON (m.title);

// Criar gêneros musicais
CREATE (g1:Genre {name: 'Rock', description: 'Rock music'})
CREATE (g2:Genre {name: 'Pop', description: 'Pop music'})
CREATE (g3:Genre {name: 'Jazz', description: 'Jazz music'})
CREATE (g4:Genre {name: 'Hip Hop', description: 'Hip Hop music'})
CREATE (g5:Genre {name: 'Eletrônica', description: 'Electronic music'});

// Criar artistas
CREATE (a1:Artist {id: 1, name: 'The Beatles', country: 'UK', formed_year: 1960})
CREATE (a2:Artist {id: 2, name: 'Michael Jackson', country: 'USA', formed_year: 1964})
CREATE (a3:Artist {id: 3, name: 'Miles Davis', country: 'USA', formed_year: 1945})
CREATE (a4:Artist {id: 4, name: 'Dr. Dre', country: 'USA', formed_year: 1985})
CREATE (a5:Artist {id: 5, name: 'Daft Punk', country: 'France', formed_year: 1993});

// Conectar artistas a gêneros
MATCH (a:Artist {name: 'The Beatles'}), (g:Genre {name: 'Rock'})
CREATE (a)-[:PLAYS_GENRE]->(g);

MATCH (a:Artist {name: 'Michael Jackson'}), (g:Genre {name: 'Pop'})
CREATE (a)-[:PLAYS_GENRE]->(g);

MATCH (a:Artist {name: 'Miles Davis'}), (g:Genre {name: 'Jazz'})
CREATE (a)-[:PLAYS_GENRE]->(g);

MATCH (a:Artist {name: 'Dr. Dre'}), (g:Genre {name: 'Hip Hop'})
CREATE (a)-[:PLAYS_GENRE]->(g);

MATCH (a:Artist {name: 'Daft Punk'}), (g:Genre {name: 'Eletrônica'})
CREATE (a)-[:PLAYS_GENRE]->(g);

// Criar músicas
CREATE (m1:Music {id: 1, title: 'Hey Jude', duration: 431, release_year: 1968, popularity: 85})
CREATE (m2:Music {id: 2, title: 'Let It Be', duration: 243, release_year: 1970, popularity: 82})
CREATE (m3:Music {id: 3, title: 'Billie Jean', duration: 294, release_year: 1982, popularity: 95})
CREATE (m4:Music {id: 4, title: 'Thriller', duration: 357, release_year: 1982, popularity: 94})
CREATE (m5:Music {id: 5, title: 'So What', duration: 545, release_year: 1959, popularity: 78})
CREATE (m6:Music {id: 6, title: 'Kind of Blue', duration: 563, release_year: 1959, popularity: 82})
CREATE (m7:Music {id: 7, title: 'Still D.R.E.', duration: 268, release_year: 1999, popularity: 88})
CREATE (m8:Music {id: 8, title: 'The Next Episode', duration: 161, release_year: 1999, popularity: 86})
CREATE (m9:Music {id: 9, title: 'One More Time', duration: 320, release_year: 2000, popularity: 90})
CREATE (m10:Music {id: 10, title: 'Harder Better Faster', duration: 224, release_year: 2001, popularity: 89});

// Conectar músicas a artistas
MATCH (m:Music {title: 'Hey Jude'}), (a:Artist {name: 'The Beatles'}) CREATE (m)-[:PERFORMED_BY]->(a);
MATCH (m:Music {title: 'Let It Be'}), (a:Artist {name: 'The Beatles'}) CREATE (m)-[:PERFORMED_BY]->(a);
MATCH (m:Music {title: 'Billie Jean'}), (a:Artist {name: 'Michael Jackson'}) CREATE (m)-[:PERFORMED_BY]->(a);
MATCH (m:Music {title: 'Thriller'}), (a:Artist {name: 'Michael Jackson'}) CREATE (m)-[:PERFORMED_BY]->(a);
MATCH (m:Music {title: 'So What'}), (a:Artist {name: 'Miles Davis'}) CREATE (m)-[:PERFORMED_BY]->(a);
MATCH (m:Music {title: 'Kind of Blue'}), (a:Artist {name: 'Miles Davis'}) CREATE (m)-[:PERFORMED_BY]->(a);
MATCH (m:Music {title: 'Still D.R.E.'}), (a:Artist {name: 'Dr. Dre'}) CREATE (m)-[:PERFORMED_BY]->(a);
MATCH (m:Music {title: 'The Next Episode'}), (a:Artist {name: 'Dr. Dre'}) CREATE (m)-[:PERFORMED_BY]->(a);
MATCH (m:Music {title: 'One More Time'}), (a:Artist {name: 'Daft Punk'}) CREATE (m)-[:PERFORMED_BY]->(a);
MATCH (m:Music {title: 'Harder Better Faster'}), (a:Artist {name: 'Daft Punk'}) CREATE (m)-[:PERFORMED_BY]->(a);

// Criar usuários
CREATE (u1:User {id: 1, name: 'João', age: 25, location: 'São Paulo'})
CREATE (u2:User {id: 2, name: 'Maria', age: 30, location: 'Rio de Janeiro'})
CREATE (u3:User {id: 3, name: 'Pedro', age: 22, location: 'Belo Horizonte'})
CREATE (u4:User {id: 4, name: 'Ana', age: 28, location: 'Curitiba'})
CREATE (u5:User {id: 5, name: 'Carlos', age: 35, location: 'Porto Alegre'});

// Criar interações (escutar, curtir, seguir)
// João
MATCH (u:User {name: 'João'}), (m:Music {title: 'Hey Jude'}) 
CREATE (u)-[:LISTENED {timestamp: datetime(), count: 5, device: 'mobile'}]->(m);
MATCH (u:User {name: 'João'}), (m:Music {title: 'Billie Jean'}) 
CREATE (u)-[:LISTENED {timestamp: datetime(), count: 3, device: 'desktop'}]->(m);
MATCH (u:User {name: 'João'}), (m:Music {title: 'One More Time'}) 
CREATE (u)-[:LIKED {timestamp: datetime()}]->(m);
MATCH (u:User {name: 'João'}), (a:Artist {name: 'Daft Punk'}) 
CREATE (u)-[:FOLLOWS {timestamp: datetime()}]->(a);

// Maria
MATCH (u:User {name: 'Maria'}), (m:Music {title: 'Billie Jean'}) 
CREATE (u)-[:LISTENED {timestamp: datetime(), count: 8, device: 'mobile'}]->(m);
MATCH (u:User {name: 'Maria'}), (m:Music {title: 'Thriller'}) 
CREATE (u)-[:LISTENED {timestamp: datetime(), count: 6, device: 'tablet'}]->(m);
MATCH (u:User {name: 'Maria'}), (m:Music {title: 'Still D.R.E.'}) 
CREATE (u)-[:LIKED {timestamp: datetime()}]->(m);
MATCH (u:User {name: 'Maria'}), (a:Artist {name: 'Michael Jackson'}) 
CREATE (u)-[:FOLLOWS {timestamp: datetime()}]->(a);

// Pedro
MATCH (u:User {name: 'Pedro'}), (m:Music {title: 'So What'}) 
CREATE (u)-[:LISTENED {timestamp: datetime(), count: 10, device: 'desktop'}]->(m);
MATCH (u:User {name: 'Pedro'}), (m:Music {title: 'Kind of Blue'}) 
CREATE (u)-[:LISTENED {timestamp: datetime(), count: 7, device: 'mobile'}]->(m);
MATCH (u:User {name: 'Pedro'}), (m:Music {title: 'One More Time'}) 
CREATE (u)-[:LIKED {timestamp: datetime()}]->(m);
MATCH (u:User {name: 'Pedro'}), (a:Artist {name: 'Miles Davis'}) 
CREATE (u)-[:FOLLOWS {timestamp: datetime()}]->(a);

// Ana
MATCH (u:User {name: 'Ana'}), (m:Music {title: 'Harder Better Faster'}) 
CREATE (u)-[:LISTENED {timestamp: datetime(), count: 15, device: 'mobile'}]->(m);
MATCH (u:User {name: 'Ana'}), (m:Music {title: 'One More Time'}) 
CREATE (u)-[:LISTENED {timestamp: datetime(), count: 12, device: 'desktop'}]->(m);
MATCH (u:User {name: 'Ana'}), (m:Music {title: 'Still D.R.E.'}) 
CREATE (u)-[:LIKED {timestamp: datetime()}]->(m);
MATCH (u:User {name: 'Ana'}), (a:Artist {name: 'Daft Punk'}) 
CREATE (u)-[:FOLLOWS {timestamp: datetime()}]->(a);

// Carlos
MATCH (u:User {name: 'Carlos'}), (m:Music {title: 'Hey Jude'}) 
CREATE (u)-[:LISTENED {timestamp: datetime(), count: 6, device: 'desktop'}]->(m);
MATCH (u:User {name: 'Carlos'}), (m:Music {title: 'Let It Be'}) 
CREATE (u)-[:LISTENED {timestamp: datetime(), count: 4, device: 'mobile'}]->(m);
MATCH (u:User {name: 'Carlos'}), (m:Music {title: 'So What'}) 
CREATE (u)-[:LIKED {timestamp: datetime()}]->(m);
MATCH (u:User {name: 'Carlos'}), (a:Artist {name: 'The Beatles'}) 
CREATE (u)-[:FOLLOWS {timestamp: datetime()}]->(a);
