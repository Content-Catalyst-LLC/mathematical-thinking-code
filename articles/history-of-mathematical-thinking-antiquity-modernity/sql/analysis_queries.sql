.headers on
.mode column

.print 'Historical periods'
SELECT period_id, name, approximate_range, dominant_mathematical_mode
FROM historical_period
ORDER BY period_id;

.print ''
.print 'Mathematical traditions'
SELECT tradition_id, name, region_or_language_context, dominant_thinking_mode, historiographic_caution
FROM mathematical_tradition
ORDER BY tradition_id;

.print ''
.print 'Milestone timeline'
SELECT m.milestone_id, p.name AS period, t.name AS tradition, tm.name AS mode, m.contribution, m.long_term_significance
FROM mathematical_milestone m
JOIN historical_period p ON p.period_id = m.period_id
JOIN mathematical_tradition t ON t.tradition_id = m.tradition_id
JOIN thinking_mode tm ON tm.mode_id = m.mode_id
ORDER BY m.milestone_id;

.print ''
.print 'Thinking mode counts'
SELECT tm.name AS thinking_mode, COUNT(m.milestone_id) AS milestone_count
FROM thinking_mode tm
LEFT JOIN mathematical_milestone m ON m.mode_id = tm.mode_id
GROUP BY tm.mode_id
ORDER BY tm.name;

.print ''
.print 'Representation forms'
SELECT name, historical_layer, mathematical_function, interpretation_risk
FROM representation_form
ORDER BY representation_id;

.print ''
.print 'Structural abstractions'
SELECT name, objects, relations_or_operations, thinking_shift, example_use
FROM structural_abstraction
ORDER BY structure_id;

.print ''
.print 'Computational milestones'
SELECT name, period, mathematical_role, representation, interpretation_warning
FROM computational_milestone
ORDER BY computation_id;

.print ''
.print 'Historiographic warnings'
SELECT topic, warning, mitigation
FROM historiographic_warning
ORDER BY warning_id;
