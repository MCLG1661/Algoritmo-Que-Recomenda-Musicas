// 3.1 Projetar grafo para PageRank
CALL gds.graph.project(
  'musicGraph',
  ['User', 'Music', 'Artist', 'Genre'],
  {
    LISTENED: {orientation: 'UNDIRECTED'},
    LIKED: {orientation: 'UNDIRECTED'},
    FOLLOWS: {orientation: 'UNDIRECTED'},
    PERFORMED_BY: {orientation: 'UNDIRECTED'},
    PLAYS_GENRE: {orientation: 'UNDIRECTED'}
  }
);

// 3.2 Executar PageRank para identificar músicas populares
CALL gds.pageRank.stream('musicGraph')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).title AS MusicTitle,
       gds.util.asNode(nodeId).name AS NodeName,
       labels(gds.util.asNode(nodeId)) AS Type,
       score AS PageRankScore
WHERE gds.util.asNode(nodeId):Music
ORDER BY PageRankScore DESC
LIMIT 10;

// 3.3 Recomendação baseada em PageRank + preferências do usuário
CALL gds.pageRank.stream('musicGraph')
YIELD nodeId, score
WITH gds.util.asNode(nodeId) AS node, score
WHERE node:Music
MATCH (u:User {name: 'João'})
OPTIONAL MATCH (u)-[:LISTENED|LIKED]-(node)
WHERE node IS NULL
RETURN node.title AS RecommendedMusic,
       score AS PopularityScore
ORDER BY PopularityScore DESC
LIMIT 5;
