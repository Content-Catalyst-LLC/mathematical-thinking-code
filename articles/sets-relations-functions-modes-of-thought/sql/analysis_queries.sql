.headers on
.mode column

.print 'Mathematical sets'
SELECT set_id, name, definition_rule, domain_note
FROM mathematical_set
ORDER BY set_id;

.print ''
.print 'Relation pair counts by type'
SELECT relation_id, relation_type, COUNT(*) AS pair_count
FROM relation_record
GROUP BY relation_id, relation_type
ORDER BY relation_id;

.print ''
.print 'Function records'
SELECT function_id, name, domain_set_id, codomain_set_id, mapping_rule, validation_note
FROM function_record
ORDER BY function_id;

.print ''
.print 'Mapping warnings'
SELECT structure_type, structure_id, warning, mitigation
FROM mapping_warning
ORDER BY warning_id;

.print ''
.print 'Model structures'
SELECT name, object_set, relation, functions, assumption_note
FROM model_structure
ORDER BY model_id;

.print ''
.print 'Non-function relation evidence'
SELECT relation_id, source, COUNT(DISTINCT target) AS distinct_outputs
FROM relation_record
WHERE relation_id = 'rel_not_function'
GROUP BY relation_id, source
HAVING COUNT(DISTINCT target) > 1;
