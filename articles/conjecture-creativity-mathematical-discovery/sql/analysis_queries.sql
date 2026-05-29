.headers on
.mode column

.print 'Conjectures and proof status'
SELECT conjecture_id, mathematical_area, proof_status, statement
FROM conjecture
ORDER BY mathematical_area, conjecture_id;

.print ''
.print 'Evidence counts'
SELECT
  c.conjecture_id,
  c.proof_status,
  COUNT(e.evidence_id) AS evidence_count
FROM conjecture c
LEFT JOIN evidence_record e ON e.conjecture_id = c.conjecture_id
GROUP BY c.conjecture_id, c.proof_status
ORDER BY evidence_count DESC, c.conjecture_id;

.print ''
.print 'Counterexample audit'
SELECT
  c.conjecture_id,
  ce.object_description,
  ce.failure_mode,
  ce.revision_suggestion
FROM counterexample ce
JOIN conjecture c ON c.conjecture_id = ce.conjecture_id
ORDER BY ce.counterexample_id;

.print ''
.print 'Proof attempts'
SELECT
  c.conjecture_id,
  p.method,
  p.status,
  p.lesson
FROM proof_attempt p
JOIN conjecture c ON c.conjecture_id = p.conjecture_id
ORDER BY c.conjecture_id, p.method;

.print ''
.print 'Discovery methods'
SELECT name, purpose, risk, professional_practice
FROM discovery_method
ORDER BY method_id;
