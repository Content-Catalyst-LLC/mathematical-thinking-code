.headers on
.mode column

.print 'Algorithm specifications'
SELECT algorithm_id, name, precondition, postcondition, termination_measure, complexity_note
FROM algorithm_specification
ORDER BY algorithm_id;

.print ''
.print 'Proof obligations'
SELECT p.proof_id, a.name AS algorithm, p.proof_type, p.claim, p.invariant_or_measure, p.risk_note
FROM proof_obligation p
JOIN algorithm_specification a ON a.algorithm_id = p.algorithm_id
ORDER BY p.proof_id;

.print ''
.print 'Loop/data-structure invariants'
SELECT i.invariant_id, a.name AS algorithm, i.location, i.invariant, i.initialization_note, i.preservation_note, i.termination_use
FROM invariant_case i
JOIN algorithm_specification a ON a.algorithm_id = i.algorithm_id
ORDER BY i.invariant_id;

.print ''
.print 'Termination arguments'
SELECT t.termination_id, a.name AS algorithm, t.decreasing_measure, t.lower_bound, t.termination_claim, t.failure_mode
FROM termination_argument t
JOIN algorithm_specification a ON a.algorithm_id = t.algorithm_id
ORDER BY t.termination_id;

.print ''
.print 'Complexity cases'
SELECT c.case_id, a.name AS algorithm, c.growth_class, c.dominant_source, c.interpretation
FROM complexity_case c
JOIN algorithm_specification a ON a.algorithm_id = c.algorithm_id
ORDER BY c.case_id;

.print ''
.print 'Evidence types'
SELECT name, strength, limitation, best_use
FROM evidence_type
ORDER BY evidence_id;

.print ''
.print 'Formal reasoning warnings'
SELECT a.name AS algorithm, w.warning, w.mitigation
FROM formal_reasoning_warning w
JOIN algorithm_specification a ON a.algorithm_id = w.algorithm_id
ORDER BY w.warning_id;
