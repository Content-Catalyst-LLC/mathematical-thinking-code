.headers on
.mode column

.print 'Metric records'
SELECT metric_name, metric_type, target_concept, consequence_level, intended_use, invalid_use_warning
FROM metric_record
ORDER BY metric_id;

.print ''
.print 'Metric risks'
SELECT metric_id, risk_name, problem, mitigation
FROM metric_risk
ORDER BY risk_id;

.print ''
.print 'Validity reviews'
SELECT metric_id, construct_validity_note, uncertainty_note, subgroup_review_note, context_note
FROM validity_review
ORDER BY review_id;

.print ''
.print 'Governance checks'
SELECT metric_id, documentation_available, contestability_mechanism, audit_frequency, invalid_use_warning
FROM governance_check
ORDER BY check_id;

.print ''
.print 'Goodhart records'
SELECT metric_id, target_goal, optimization_pressure, distortion_mechanism, countermeasure
FROM goodhart_record
ORDER BY goodhart_id;

.print ''
.print 'Aggregation reviews'
SELECT metric_id, aggregation_method, what_it_shows, what_it_may_hide, disaggregation_needed
FROM aggregation_review
ORDER BY aggregation_id;

.print ''
.print 'Ranking reviews'
SELECT metric_id, ranking_basis, instability_source, context_loss, responsible_reporting
FROM ranking_review
ORDER BY ranking_id;

.print ''
.print 'Uncertainty reviews'
SELECT metric_id, uncertainty_source, description, communication_method
FROM uncertainty_review
ORDER BY uncertainty_id;

.print ''
.print 'Justice reviews'
SELECT metric_id, recognition_question, distribution_question, voice_question, harm_question
FROM justice_review
ORDER BY justice_id;

.print ''
.print 'Responsible quantification checklist'
SELECT stage, question, failure_mode, mitigation
FROM responsible_quantification_check
ORDER BY check_id;
