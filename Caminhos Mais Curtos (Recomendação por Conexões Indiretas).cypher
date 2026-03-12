// 6.1 Encontrar caminhos curtos entre usuário e músicas não ouvidas
MATCH (u:User {name: 'João'})
MATCH (m:Music)
WHERE NOT EXISTS((u)-[:LISTENED|LIKED]->(m))

MATCH p = shortestPath((u)-[*..4]-(m))
WHERE ALL(node IN nodes(p) WHERE 
          node:User OR node:Music OR node:Artist OR node:Genre)

RETURN m.title AS Music,
       length(p) AS PathLength,
       [node IN nodes(p) | 
        CASE 
          WHEN node:User THEN 'User:' + node.name
          WHEN node:Music THEN 'Music:' + node.title
          WHEN node:Artist THEN 'Artist:' + node.name
          WHEN node:Genre THEN 'Genre:' + node.name
        END] AS ConnectionPath
ORDER BY PathLength
LIMIT 5;

// 6.2 Recomendação baseada em "amigos de amigos" (follows)
MATCH (u:User {name: 'João'})-[:FOLLOWS]->(followedArtist:Artist)
MATCH (followedArtist)<-[:FOLLOWS]-(otherUser:User)
WHERE otherUser <> u
MATCH (otherUser)-[:LIKED|LISTENED]->(music:Music)
WHERE NOT EXISTS((u)-[:LIKED|LISTENED]->(music))
RETURN DISTINCT music.title AS RecommendedMusic,
       otherUser.name AS RecommendedBy,
       followedArtist.name AS CommonArtist
LIMIT 5;
