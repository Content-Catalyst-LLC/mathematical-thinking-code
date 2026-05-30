.headers on
.mode column

.print 'Historical layers'
SELECT layer_id, name, historical_period, dominant_unifying_idea, later_connection
FROM historical_layer
ORDER BY layer_id;

.print ''
.print 'Mathematical ideas'
SELECT idea_id, name, primary_field, unifying_role, transformation, invariant_or_preserved_structure
FROM mathematical_idea
ORDER BY idea_id;

.print ''
.print 'Ideas by field'
SELECT primary_field, COUNT(*) AS idea_count
FROM mathematical_idea
GROUP BY primary_field
ORDER BY primary_field;

.print ''
.print 'Cross-field connections'
SELECT source_idea, target_idea, connection_type, preserved_structure, caution_note
FROM cross_field_connection
ORDER BY connection_id;

.print ''
.print 'Transformation and invariance'
SELECT field, transformation, invariant, meaning, example
FROM transformation_invariant
ORDER BY invariant_id;

.print ''
.print 'Proof, algorithm, model distinctions'
SELECT mathematical_form, core_question, evidence_standard, risk_if_confused, responsible_distinction
FROM proof_algorithm_model_connection
ORDER BY connection_id;

.print ''
.print 'Responsible generalization warnings'
SELECT topic, warning, mitigation
FROM responsible_generalization_warning
ORDER BY warning_id;
