.headers on
.mode column

.print 'Combinatorial problems'
SELECT problem_id, name, order_matters, repetition_allowed, constraint_note
FROM combinatorial_problem
ORDER BY problem_id;

.print ''
.print 'Counting methods and validation notes'
SELECT p.name AS problem, m.method_name, m.formula, m.double_counting_risk, m.validation_note
FROM counting_method m
JOIN combinatorial_problem p ON p.problem_id = m.problem_id
ORDER BY m.method_id;

.print ''
.print 'Possibility warnings'
SELECT p.name AS problem, w.warning, w.mitigation
FROM possibility_warning w
JOIN combinatorial_problem p ON p.problem_id = w.problem_id
ORDER BY w.warning_id;

.print ''
.print 'Probability cases'
SELECT name, total_outcomes, favorable_outcomes, equally_likely,
       CASE WHEN equally_likely = 1 THEN CAST(favorable_outcomes AS REAL)/total_outcomes ELSE NULL END AS probability_if_valid
FROM probability_case
ORDER BY case_id;

.print ''
.print 'Graph count cases'
SELECT name, n, graph_type, formula, interpretation
FROM graph_count_case
ORDER BY case_id;

.print ''
.print 'Generating function examples'
SELECT name, series_form, coefficient_meaning, interpretation
FROM generating_function_example
ORDER BY gf_id;
