.headers on
.mode column

.print 'Algebraic objects'
SELECT object_id, object_type, name
FROM algebraic_object
ORDER BY object_type, object_id;

.print ''
.print 'Variable roles'
SELECT symbol, role_type, example, interpretation
FROM variable_role
ORDER BY role_id;

.print ''
.print 'Transformation rules and risks'
SELECT name, source_form, target_form, preserved_meaning, risk_note
FROM transformation_rule
ORDER BY rule_id;

.print ''
.print 'Equation interpretations'
SELECT equation_text, equation_type, interpretation, verification_method
FROM equation_audit
ORDER BY equation_id;

.print ''
.print 'Function representations'
SELECT representation_type, representation_text, preserved_structure, possible_limitation
FROM function_representation
ORDER BY representation_type;

.print ''
.print 'Algebraic misconceptions'
SELECT name, diagnostic_signal, intervention
FROM algebraic_misconception
ORDER BY misconception_id;
