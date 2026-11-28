// 5.1 Executar algoritmo de comunidades (Louvain)
CALL gds.louvain.stream('musicGraph')
YIELD nodeId, communityId
WITH gds.util.asNode(nodeId) AS node, communityId
WHERE node:User
RETURN node.name AS UserName,
       communityId AS Community
ORDER BY Community, UserName;

// 5.2 Recomendar músicas de outros usuários da comunidade de João
CALL gds.louvain.stream('musicGraph')
YIELD nodeId, communityId
WITH gds.util.asNode(nodeId) AS node, communityId
WHERE node:User
WITH communityId, collect(node) AS members
MATCH (u:User {name: 'João'})
WHERE u IN members
UNWIND members AS otherUser
MATCH (otherUser)-[:LISTENED|LIKED]->(communityMusic:Music)
WHERE otherUser <> u
  AND NOT EXISTS { MATCH (u)-[:LISTENED|LIKED]->(communityMusic) }
RETURN communityMusic.title AS RecommendedMusic,
       COUNT(DISTINCT otherUser) AS UsersInCommunity
ORDER BY UsersInCommunity DESC, RecommendedMusic
LIMIT 5;
