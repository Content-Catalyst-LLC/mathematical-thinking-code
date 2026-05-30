.headers on
.mode column

.print 'Automation tasks'
SELECT task_name, tool_type, mathematical_object, output_type, assumptions, verification_method
FROM automation_task
ORDER BY task_id;

.print ''
.print 'Automation tools'
SELECT tool_name, tool_category, strength, human_review, failure_mode
FROM automation_tool
ORDER BY tool_id;

.print ''
.print 'Verification records'
SELECT task_id, verification_method, evidence_standard, trust_boundary, interpretation_note
FROM verification_record
ORDER BY verification_id;

.print ''
.print 'Automation risks'
SELECT risk_name, mathematical_problem, mitigation
FROM automation_risk
ORDER BY risk_id;

.print ''
.print 'Human judgment skills'
SELECT skill_name, automation_context, why_it_matters, review_question
FROM human_judgment_skill
ORDER BY skill_id;

.print ''
.print 'Proof assistant layers'
SELECT layer_name, human_role, machine_role, risk_or_limitation
FROM proof_assistant_layer
ORDER BY layer_id;
