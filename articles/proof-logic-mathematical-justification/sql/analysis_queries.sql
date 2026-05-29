.headers on
.mode column

.print 'Claims and proof status'
SELECT claim_id, title, claim_type, domain, proof_status
FROM claim
ORDER BY claim_type, claim_id;

.print ''
.print 'Proof-step counts'
SELECT
  c.claim_id,
  c.title,
  COUNT(ps.proof_step_id) AS proof_step_count
FROM claim c
LEFT JOIN proof_step ps ON ps.claim_id = c.claim_id
GROUP BY c.claim_id, c.title
ORDER BY proof_step_count DESC, c.claim_id;

.print ''
.print 'Assumption audit'
SELECT
  c.title,
  a.assumption_type,
  a.statement
FROM assumption a
JOIN claim c ON c.claim_id = a.claim_id
ORDER BY c.title, a.assumption_type;

.print ''
.print 'Dependency edges'
SELECT source_claim_id, relation_type, target_claim_id, weight
FROM proof_dependency
ORDER BY weight DESC, source_claim_id, target_claim_id;

.print ''
.print 'Counterexample discipline'
SELECT
  c.title,
  ce.object_description,
  ce.failure_mode,
  ce.lesson
FROM counterexample ce
JOIN claim c ON c.claim_id = ce.claim_id
ORDER BY ce.counterexample_id;

.print ''
.print 'Inference rules'
SELECT name, formal_pattern, accepted_context
FROM inference_rule
ORDER BY name;
