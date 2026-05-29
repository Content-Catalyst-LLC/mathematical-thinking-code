.headers on
.mode column

.print 'Theorems and proof-step counts'
SELECT
  t.theorem_id,
  t.title,
  t.domain,
  COUNT(ps.proof_step_id) AS proof_step_count
FROM theorem t
LEFT JOIN proof_step ps ON ps.theorem_id = t.theorem_id
GROUP BY t.theorem_id, t.title, t.domain
ORDER BY proof_step_count DESC, t.title;

.print ''
.print 'Dependency edges'
SELECT source_id, relation_type, target_id, weight
FROM theorem_dependency
ORDER BY weight DESC, source_id, target_id;

.print ''
.print 'Counterexamples and boundary examples'
SELECT e.label, c.name AS concept, e.description
FROM example e
JOIN concept c ON c.concept_id = e.concept_id
WHERE e.is_counterexample = 1;
