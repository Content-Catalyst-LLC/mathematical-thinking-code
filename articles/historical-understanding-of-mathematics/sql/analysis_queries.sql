.headers on
.mode column

.print 'Historical practices'
SELECT practice_name, object_of_thought, medium, method, meaning, caution
FROM historical_practice
ORDER BY practice_id;

.print ''
.print 'Historiographic risks'
SELECT risk_name, problem, mitigation
FROM historiographic_risk
ORDER BY risk_id;

.print ''
.print 'Mathematical transmission'
SELECT source_context, target_context, preserved_content, transformed_content, interpretation_note
FROM mathematical_transmission
ORDER BY transmission_id;

.print ''
.print 'Notation history'
SELECT notation_or_medium, mathematical_function, historical_effect, anachronism_warning
FROM notation_history
ORDER BY notation_id;

.print ''
.print 'Proof styles'
SELECT name, historical_context, authority_basis, limitation_or_caution
FROM proof_style
ORDER BY proof_style_id;

.print ''
.print 'Canon risks'
SELECT risk, problem, responsible_response
FROM canon_risk
ORDER BY canon_risk_id;
