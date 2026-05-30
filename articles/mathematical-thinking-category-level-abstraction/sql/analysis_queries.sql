.headers on
.mode column

.print 'Category records'
SELECT category_name, objects, morphisms, preserved_structure, composition_rule, abstraction_risk
FROM category_record
ORDER BY category_id;

.print ''
.print 'Functor records'
SELECT functor_name, source_category, target_category, preserved_property, forgotten_or_added_structure
FROM functor_record
ORDER BY functor_id;

.print ''
.print 'Natural transformations'
SELECT transformation_name, source_functor, target_functor, naturality_condition, coherence_review
FROM natural_transformation_record
ORDER BY transformation_id;

.print ''
.print 'Universal properties'
SELECT construction_name, diagram_shape, universal_role, uniqueness_condition, review_question
FROM universal_property_record
ORDER BY property_id;

.print ''
.print 'Diagram records'
SELECT diagram_name, diagram_type, path_left, path_right, commutativity_condition, interpretation
FROM diagram_record
ORDER BY diagram_id;

.print ''
.print 'Abstraction risks'
SELECT risk_name, problem, mitigation
FROM abstraction_risk
ORDER BY risk_id;

.print ''
.print 'Responsible abstraction checklist'
SELECT stage, question, failure_mode, mitigation
FROM responsible_abstraction_check
ORDER BY check_id;
