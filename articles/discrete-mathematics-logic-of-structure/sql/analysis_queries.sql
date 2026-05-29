.headers on
.mode column

.print 'Discrete objects'
SELECT object_id, name, object_type, description
FROM discrete_object
ORDER BY object_type, object_id;

.print ''
.print 'Relation edges by graph'
SELECT graph_id, relation_type, directed, COUNT(*) AS edge_count
FROM relation_edge
GROUP BY graph_id, relation_type, directed
ORDER BY graph_id;

.print ''
.print 'Algorithm audit metadata'
SELECT algorithm_id, name, input_structure, output_structure, invariant_note, complexity_note
FROM algorithm_audit
ORDER BY algorithm_id;

.print ''
.print 'Proof patterns'
SELECT name, discrete_use, required_structure, risk_note
FROM proof_pattern
ORDER BY proof_id;

.print ''
.print 'Structure warnings'
SELECT structure_type, structure_id, warning, mitigation
FROM structure_warning
ORDER BY warning_id;

.print ''
.print 'Main graph degree counts'
SELECT source_id AS vertex, COUNT(*) AS outgoing_or_listed_edges
FROM relation_edge
WHERE graph_id = 'graph_main'
GROUP BY source_id
ORDER BY source_id;
