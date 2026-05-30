.headers on
.mode column

.print 'Notation styles'
SELECT style_id, name, dominant_medium, mathematical_effect, limitation_note
FROM notation_style
ORDER BY style_id;

.print ''
.print 'Notation milestones'
SELECT m.milestone_id, m.period, m.tradition_or_figure, s.name AS notation_style, m.contribution, m.interpretation_note
FROM notation_milestone m
JOIN notation_style s ON s.style_id = m.style_id
ORDER BY m.milestone_id;

.print ''
.print 'Milestone counts by style'
SELECT s.name AS notation_style, COUNT(m.milestone_id) AS milestone_count
FROM notation_style s
LEFT JOIN notation_milestone m ON m.style_id = s.style_id
GROUP BY s.style_id
ORDER BY s.name;

.print ''
.print 'Symbol records'
SELECT symbol_text, meaning_context, mathematical_role, ambiguity_note, responsible_pedagogy_note
FROM symbol_record
ORDER BY symbol_id;

.print ''
.print 'Transformation rules'
SELECT rule_name, input_pattern, output_pattern, mathematical_condition, interpretation_note
FROM transformation_rule
ORDER BY rule_id;

.print ''
.print 'Notation warnings'
SELECT topic, warning, mitigation
FROM notation_warning
ORDER BY warning_id;
