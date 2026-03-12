// 4.1 Criar grafo focado em usuários e músicas
CALL gds.graph.project(
  'userMusicGraph',
  ['User', 'Music'],
  {
    LISTENED: {orientation: 'UNDIRECTED'},
    LIKED: {orientation: 'UNDIRECTED'}
  }
);

// 4.2 Calcular similaridade de Jaccard entre usuários
MATCH (u1:User {name: 'João'})
MATCH (u2:User)
WHERE u1 <> u2

MATCH (u1)-[:LISTENED|LIKED]->(common:Music)<-[:LISTENED|LIKED]-(u2)
WITH u1, u2, COUNT(DISTINCT common) AS intersection

MATCH (u1)-[:LISTENED|LIKED]->(m1:Music)
WITH u1, u2, intersection, COLLECT(DISTINCT m1) AS set1
MATCH (u2)-[:LISTENED|LIKED]->(m2:Music)
WITH u1, u2, intersection, set1, COLLECT(DISTINCT m2) AS set2

WITH u1, u2, intersection,
     SIZE(set1) + SIZE(set2) - intersection AS union

RETURN u2.name AS SimilarUser,
       intersection * 1.0 / union AS JaccardSimilarity
ORDER BY JaccardSimilarity DESC
LIMIT 3;

// 4.3 Recomendação baseada em usuários similares
MATCH (u1:User {name: 'João'})
MATCH (u2:User)
WHERE u1 <> u2

MATCH (u1)-[:LISTENED|LIKED]->(common:Music)<-[:LISTENED|LIKED]-(u2)
WITH u1, u2, COUNT(DISTINCT common) AS intersection

MATCH (u1)-[:LISTENED|LIKED]->(m1:Music)
WITH u1, u2, intersection, COLLECT(DISTINCT m1) AS set1
MATCH (u2)-[:LISTENED|LIKED]->(m2:Music)
WITH u1, u2, intersection, set1, COLLECT(DISTINCT m2) AS set2

WITH u1, u2, intersection,
     SIZE(set1) + SIZE(set2) - intersection AS union,
     set2

WHERE union > 0
WITH u1, u2, intersection * 1.0 / union AS similarity, set2
ORDER BY similarity DESC
LIMIT 1

UNWIND set2 AS recommendedMusic
WHERE NOT EXISTS((u1)-[:LISTENED|LIKED]->(recommendedMusic))
RETURN DISTINCT recommendedMusic.title AS RecommendedMusic,
       similarity AS UserSimilarity
LIMIT 5;
