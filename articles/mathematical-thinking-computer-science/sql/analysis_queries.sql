.headers on
.mode column

.print 'Computational concepts'
SELECT concept_id, name, concept_type, mathematical_structure, computer_science_use
FROM computational_concept
ORDER BY concept_id;

.print ''
.print 'Algorithm specifications'
SELECT algorithm_id, name, input_domain, output_specification, invariant_note, complexity_note
FROM algorithm_specification
ORDER BY algorithm_id;

.print ''
.print 'Proof obligations'
SELECT p.proof_id, a.name AS algorithm, p.proof_type, p.claim, p.method, p.risk_note
FROM proof_obligation p
JOIN algorithm_specification a ON a.algorithm_id = p.algorithm_id
ORDER BY p.proof_id;

.print ''
.print 'Complexity classes'
SELECT name, growth_class, example_algorithm, interpretation
FROM complexity_case
ORDER BY case_id;

.print ''
.print 'Automata cases'
SELECT name, states, alphabet, start_state, accepting_states, recognized_language
FROM automata_case
ORDER BY automaton_id;

.print ''
.print 'Type examples'
SELECT name, type_kind, mathematical_analogy, programming_use, invariant_note
FROM type_example
ORDER BY type_id;

.print ''
.print 'Representation warnings'
SELECT c.name AS concept, w.warning, w.mitigation
FROM representation_warning w
JOIN computational_concept c ON c.concept_id = w.concept_id
ORDER BY w.warning_id;
