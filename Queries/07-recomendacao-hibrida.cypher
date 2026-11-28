// Combina vizinhos com escutas em comum, artistas seguidos e PageRank.
MATCH (u:User {name: 'João'})
CALL {
  WITH u
  MATCH (u)-[:LIKED|LISTENED]->(common:Music)<-[:LIKED|LISTENED]-(other:User)
  WHERE other <> u
  MATCH (other)-[:LIKED|LISTENED]->(rec:Music)
  RETURN rec, 3.0 AS weight, COUNT(DISTINCT other) AS score
  UNION ALL
  WITH u
  MATCH (u)-[:FOLLOWS]->(artist:Artist)<-[:PERFORMED_BY]-(rec:Music)
  RETURN rec, 2.0 AS weight, COUNT(DISTINCT artist) AS score
  UNION ALL
  CALL gds.pageRank.stream('musicGraph')
  YIELD nodeId, score
  WITH gds.util.asNode(nodeId) AS rec, score
  WHERE rec:Music
  RETURN rec, 1.0 AS weight, score
}
WITH u, rec, SUM(weight * score) AS TotalScore
WHERE NOT EXISTS { MATCH (u)-[:LISTENED|LIKED]->(rec) }
RETURN rec.title AS RecommendedMusic, TotalScore
ORDER BY TotalScore DESC, RecommendedMusic
LIMIT 10;
