.headers on
.mode column

.print 'Recursive definitions'
SELECT definition_id, name, base_case, recursive_rule, termination_measure
FROM recursive_definition
ORDER BY definition_id;

.print ''
.print 'Recurrence records'
SELECT name, initial_values, recurrence_rule, closed_form_note, proof_status
FROM recurrence_record
ORDER BY recurrence_id;

.print ''
.print 'Grammar rules by type'
SELECT nonterminal, production, rule_type, interpretation
FROM grammar_rule
ORDER BY nonterminal, rule_type, rule_id;

.print ''
.print 'Recursive algorithms'
SELECT name, base_case, recursive_reduction, combination_rule, complexity_note, correctness_note
FROM recursive_algorithm
ORDER BY algorithm_id;

.print ''
.print 'Recursive model risks'
SELECT name, update_rule, stopping_condition, risk_note
FROM recursive_model_audit
ORDER BY model_id;

.print ''
.print 'Recursion warnings'
SELECT structure_type, structure_id, warning, mitigation
FROM recursion_warning
ORDER BY warning_id;
