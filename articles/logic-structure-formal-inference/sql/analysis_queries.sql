.headers on
.mode column

.print 'Propositions by type'
SELECT proposition_id, label, proposition_type, domain_note
FROM proposition
ORDER BY proposition_type, proposition_id;

.print ''
.print 'Inference rules'
SELECT rule_id, name, formal_pattern, accepted_context
FROM inference_rule
ORDER BY rule_id;

.print ''
.print 'Quantifier patterns'
SELECT logical_form, plain_language, proof_strategy, refutation_strategy
FROM quantifier_pattern
ORDER BY pattern_id;

.print ''
.print 'Derivation step counts'
SELECT derivation_id, COUNT(*) AS step_count
FROM derivation_step
GROUP BY derivation_id
ORDER BY derivation_id;

.print ''
.print 'Derivation dependencies'
SELECT source, relation, target, weight
FROM derivation_dependency
ORDER BY weight DESC, source;

.print ''
.print 'Counterexample audit'
SELECT
  p.label,
  c.claim,
  c.object_description,
  c.failure_mode,
  c.lesson
FROM counterexample c
JOIN proposition p ON p.proposition_id = c.proposition_id
ORDER BY c.counterexample_id;

.print ''
.print 'Proof systems'
SELECT name, style, primary_use, professional_note
FROM proof_system
ORDER BY system_id;
