.headers on
.mode column

.print 'Proof traditions'
SELECT tradition_id, name, period, region_or_language_context, dominant_proof_style
FROM proof_tradition
ORDER BY tradition_id;

.print ''
.print 'Milestones with proof styles'
SELECT m.milestone_id, m.figure_or_text, m.approximate_period, t.name AS tradition, s.name AS proof_style, m.proof_historical_significance
FROM proof_milestone m
JOIN proof_tradition t ON t.tradition_id = m.tradition_id
JOIN proof_style s ON s.style_id = m.proof_style_id
ORDER BY m.milestone_id;

.print ''
.print 'Style counts'
SELECT s.name AS proof_style, COUNT(m.milestone_id) AS milestone_count
FROM proof_style s
LEFT JOIN proof_milestone m ON m.proof_style_id = s.style_id
GROUP BY s.style_id
ORDER BY s.name;

.print ''
.print 'Proof media'
SELECT name, historical_context, proof_effect, interpretation_risk
FROM proof_medium
ORDER BY medium_id;

.print ''
.print 'Proposition dependencies'
SELECT system_id, source_claim, relationship, target_claim, interpretation
FROM proposition_dependency
ORDER BY dependency_id;

.print ''
.print 'Historiographic warnings'
SELECT topic, warning, mitigation
FROM historiographic_warning
ORDER BY warning_id;
