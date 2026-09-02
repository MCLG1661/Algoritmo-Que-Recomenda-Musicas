// 2.1 Recomendação baseada em músicas curtidas
MATCH (u:User {name: 'João'})-[:LIKED]->(likedMusic:Music)<-[:LIKED]-(otherUser:User)
MATCH (otherUser)-[:LIKED|LISTENED]->(recommended:Music)
WHERE NOT EXISTS((u)-[:LIKED|LISTENED]->(recommended))
RETURN DISTINCT recommended.title AS RecommendedMusic, 
       COUNT(*) AS Commonality
ORDER BY Commonality DESC
LIMIT 5;

// 2.2 Recomendação baseada em artistas seguidos
MATCH (u:User {name: 'João'})-[:FOLLOWS]->(followedArtist:Artist)
MATCH (followedArtist)<-[:PERFORMED_BY]-(music:Music)
WHERE NOT EXISTS((u)-[:LISTENED]->(music))
RETURN music.title AS RecommendedByFollowedArtist,
       followedArtist.name AS Artist
LIMIT 5;

// 2.3 Recomendação baseada em gêneros mais ouvidos
MATCH (u:User {name: 'João'})-[r:LISTENED]->(music:Music)-[:PERFORMED_BY]->(artist:Artist)-[:PLAYS_GENRE]->(genre:Genre)
WITH u, genre, SUM(r.count) AS totalListens
ORDER BY totalListens DESC
LIMIT 2
MATCH (genre)<-[:PLAYS_GENRE]-(artist:Artist)-[:PERFORMED_BY]->(otherMusic:Music)
WHERE NOT EXISTS((u)-[:LISTENED]->(otherMusic))
RETURN DISTINCT otherMusic.title AS RecommendedMusic,
       artist.name AS Artist,
       genre.name AS Genre
LIMIT 5;
