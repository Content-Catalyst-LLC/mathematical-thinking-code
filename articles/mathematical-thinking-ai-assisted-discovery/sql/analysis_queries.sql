.headers on
.mode column

.print 'Discovery candidates'
SELECT title, output_type, generated_by, current_status, interpretation_question
FROM discovery_candidate
ORDER BY candidate_id;

.print ''
.print 'Evaluator records'
SELECT candidate_id, evaluator_type, criterion, limitation
FROM evaluator_record
ORDER BY evaluator_id;

.print ''
.print 'Verification records'
SELECT candidate_id, verification_method, evidence_standard, result_summary, remaining_question
FROM verification_record
ORDER BY verification_id;

.print ''
.print 'Discovery risks'
SELECT risk_name, mathematical_problem, mitigation
FROM discovery_risk
ORDER BY risk_id;

.print ''
.print 'Human interpretation records'
SELECT candidate_id, novelty_review, significance_review, proof_status, credit_and_workflow_note
FROM human_interpretation_record
ORDER BY interpretation_id;

.print ''
.print 'Discovery workflow'
SELECT stage, ai_role, evaluator_role, human_role, risk, mitigation
FROM discovery_workflow
ORDER BY workflow_id;

.print ''
.print 'Proof status taxonomy'
SELECT status_name, meaning, promotion_requirement
FROM proof_status_taxonomy
ORDER BY status_id;
