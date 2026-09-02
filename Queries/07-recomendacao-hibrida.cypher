// Query final combinando múltiplas estratégias
MATCH (u:User {name: 'João'})

// Estratégia 1: Músicas curtidas por usuários com gostos similares
OPTIONAL MATCH (u)-[:LIKED]->(liked:Music)
WITH u, COLLECT(liked) AS likedMusics

// Estratégia 2: Baseado em artistas seguidos
OPTIONAL MATCH (u)-[:FOLLOWS]->(followed:Artist)
WITH u, likedMusics, COLLECT(followed) AS followedArtists

// Coletar recomendações potenciais com diferentes pontuações
CALL {
  WITH u, likedMusics
  // Recomendações baseadas em usuários similares (peso 3)
  MATCH (u)-[:LIKED|LISTENED]->(common:Music)<-[:LIKED|LISTENED]-(other:User)
  WHERE other <> u
  MATCH (other)-[:LIKED|LISTENED]->(rec:Music)
  WHERE NOT rec IN likedMusics
  RETURN rec, 3.0 AS weight, COUNT(DISTINCT other) AS score
  UNION
  WITH u, followedArtists
  // Recomendações baseadas em artistas seguidos (peso 2)
  MATCH (followedArtists)<-[:PERFORMED_BY]-(rec:Music)
  WHERE NOT rec IN likedMusics
  RETURN rec, 2.0 AS weight, COUNT(DISTINCT followedArtists) AS score
  UNION
  WITH u
  // Recomendações baseadas em popularidade (PageRank) (peso 1)
  CALL gds.pageRank.stream('musicGraph')
  YIELD nodeId, score
  WITH gds.util.asNode(nodeId) AS rec, score
  WHERE rec:Music AND NOT rec IN likedMusics
  RETURN rec, 1.0 AS weight, score AS popularity
}

// Calcular pontuação final
RETURN rec.title AS RecommendedMusic,
       SUM(weight * score) AS TotalScore
ORDER BY TotalScore DESC
LIMIT 10;
