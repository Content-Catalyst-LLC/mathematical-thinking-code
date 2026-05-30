.headers on
.mode column

.print 'Scientific model records'
SELECT model_name, model_type, purpose, target_system, intended_use, scope_limit
FROM scientific_model_record
ORDER BY model_id;

.print ''
.print 'Model assumptions'
SELECT model_id, assumption_type, assumption_text, failure_consequence
FROM model_assumption
ORDER BY assumption_id;

.print ''
.print 'Variables and parameters'
SELECT model_id, name, role, unit, uncertainty_note
FROM variable_parameter_record
ORDER BY record_id;

.print ''
.print 'Calibration records'
SELECT model_id, calibration_method, data_used, risk, review_question
FROM calibration_record
ORDER BY calibration_id;

.print ''
.print 'Validation records'
SELECT model_id, validation_type, evidence_used, limitation, credibility_note
FROM validation_record
ORDER BY validation_id;

.print ''
.print 'Uncertainty sources'
SELECT model_id, source_type, description, mitigation
FROM uncertainty_source
ORDER BY uncertainty_id;

.print ''
.print 'Sensitivity records'
SELECT model_id, factor_tested, method, finding, decision_relevance
FROM sensitivity_record
ORDER BY sensitivity_id;

.print ''
.print 'Model risks'
SELECT risk_name, problem, mitigation
FROM model_risk
ORDER BY risk_id;

.print ''
.print 'Responsible modeling checklist'
SELECT stage, question, failure_mode, mitigation
FROM responsible_modeling_check
ORDER BY check_id;
