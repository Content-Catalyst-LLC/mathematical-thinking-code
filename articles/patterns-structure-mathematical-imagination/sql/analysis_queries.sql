.headers on
.mode column

.print 'Pattern sequences and structural interpretations'
SELECT sequence_id, name, pattern_type, structural_interpretation
FROM pattern_sequence
ORDER BY sequence_id;

.print ''
.print 'Graph edge counts'
SELECT
  mo.object_id,
  mo.name,
  COUNT(ge.source) AS edge_count
FROM mathematical_object mo
LEFT JOIN graph_edge ge ON ge.object_id = mo.object_id
GROUP BY mo.object_id, mo.name
ORDER BY edge_count DESC, mo.name;

.print ''
.print 'Recorded graph invariants'
SELECT
  mo.name AS object_name,
  inv.name AS invariant_name,
  oi.evidence_note
FROM object_invariant oi
JOIN mathematical_object mo ON mo.object_id = oi.object_id
JOIN invariant inv ON inv.invariant_id = oi.invariant_id
ORDER BY mo.name, inv.name;

.print ''
.print 'Analogy audit'
SELECT source_domain, target_domain, structural_correspondence, risk
FROM analogy
ORDER BY source_domain, target_domain;

.print ''
.print 'Counterexample discipline'
SELECT claim, object, lesson
FROM counterexample
ORDER BY counterexample_id;
