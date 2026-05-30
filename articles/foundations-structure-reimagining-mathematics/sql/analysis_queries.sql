.headers on
.mode column

.print 'Foundation views'
SELECT view_id, name, central_question, mathematical_strength, limitation_note
FROM foundation_view
ORDER BY view_id;

.print ''
.print 'Mathematical structures'
SELECT structure_id, name, objects, relations_or_operations, laws_or_axioms, preserved_by
FROM mathematical_structure
ORDER BY structure_id;

.print ''
.print 'Formal systems'
SELECT system_id, language, axioms, inference_rules, intended_use, limitation_note
FROM formal_system
ORDER BY system_id;

.print ''
.print 'Transformation maps'
SELECT source_structure, target_structure, map_type, what_is_preserved, interpretation_note
FROM transformation_map
ORDER BY map_id;

.print ''
.print 'Model interpretations'
SELECT formal_structure, possible_interpretations, assumption_risk, responsible_question
FROM model_interpretation
ORDER BY model_id;

.print ''
.print 'Proof assistant layers'
SELECT layer_name, human_role, machine_role, risk_or_limitation
FROM proof_assistant_layer
ORDER BY layer_id;

.print ''
.print 'Abstraction warnings'
SELECT topic, warning, mitigation
FROM abstraction_warning
ORDER BY warning_id;
