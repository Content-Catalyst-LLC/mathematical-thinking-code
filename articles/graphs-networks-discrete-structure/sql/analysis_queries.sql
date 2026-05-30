.headers on
.mode column

.print 'Graph nodes'
SELECT node_id, label, node_type, interpretation
FROM graph_node
ORDER BY node_id;

.print ''
.print 'Graph edge counts by graph'
SELECT graph_id, relation_type, directed, COUNT(*) AS edge_count
FROM graph_edge
GROUP BY graph_id, relation_type, directed
ORDER BY graph_id;

.print ''
.print 'Undirected graph_main listed degrees'
SELECT node_id, COUNT(edge_id) AS listed_incident_edges
FROM (
  SELECT source_node_id AS node_id, edge_id FROM graph_edge WHERE graph_id = 'graph_main'
  UNION ALL
  SELECT target_node_id AS node_id, edge_id FROM graph_edge WHERE graph_id = 'graph_main'
)
GROUP BY node_id
ORDER BY node_id;

.print ''
.print 'Bipartite edge counts by left node'
SELECT left_node, COUNT(*) AS degree
FROM bipartite_edge
GROUP BY left_node
ORDER BY left_node;

.print ''
.print 'Centrality interpretation cases'
SELECT node_id, metric, value_note, interpretation_risk, mitigation
FROM centrality_case
ORDER BY case_id;

.print ''
.print 'Algorithm assumptions'
SELECT name, graph_type, input_assumption, output, complexity_note, audit_note
FROM graph_algorithm_audit
ORDER BY algorithm_id;

.print ''
.print 'Network warnings'
SELECT graph_id, structure_type, warning, mitigation
FROM graph_model_warning
ORDER BY warning_id;
