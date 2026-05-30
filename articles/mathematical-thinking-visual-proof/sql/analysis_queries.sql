.headers on
.mode column

.print 'Visual proof records'
SELECT title, domain, visual_role, visible_structure, proof_status, generalization_question
FROM visual_proof_record
ORDER BY record_id;

.print ''
.print 'Diagram relations'
SELECT record_id, visual_feature, mathematical_relation, proof_requirement
FROM diagram_relation
ORDER BY relation_id;

.print ''
.print 'Visual risks'
SELECT risk_name, problem, mitigation
FROM visual_risk
ORDER BY risk_id;

.print ''
.print 'Accessibility reviews'
SELECT record_id, visual_dependency, alternative_description, accessibility_note
FROM accessibility_review
ORDER BY review_id;

.print ''
.print 'Visual workflow'
SELECT stage, question, failure_mode, mitigation
FROM visual_workflow
ORDER BY workflow_id;

.print ''
.print 'Proofs without words'
SELECT title, visual_device, mathematical_idea, missing_words_prompt
FROM proof_without_words_example
ORDER BY example_id;
