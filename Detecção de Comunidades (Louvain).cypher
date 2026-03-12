// 5.1 Executar algoritmo de comunidades (Louvain)
CALL gds.louvain.stream('musicGraph')
YIELD nodeId, communityId
WITH gds.util.asNode(nodeId) AS node, communityId
WHERE node:User
RETURN node.name AS UserName,
       communityId AS Community
ORDER BY Community, UserName;

// 5.2 Recomendação baseada em comunidade (o que outros da comunidade estão ouvindo)
CALL gds.louvain.stream('musicGraph')
YIELD nodeId, communityId
WITH gds.util.asNode(nodeId) AS node, communityId
WHERE node:User

MATCH (u:User {name: 'João'})
MATCH (u)-[:LISTENED|LIKED]->(userMusic:Music)

WITH u, communityId, COLLECT(userMusic) AS userMusicList

MATCH (otherUser:User)-[:LISTENED|LIKED]->(communityMusic:Music)
WHERE otherUser <> u 
  AND otherUser.communityId = communityId
  AND NOT communityMusic IN userMusicList

RETURN DISTINCT communityMusic.title AS RecommendedMusic,
       COUNT(DISTINCT otherUser) AS UsersInCommunity
ORDER BY UsersInCommunity DESC
LIMIT 5;
