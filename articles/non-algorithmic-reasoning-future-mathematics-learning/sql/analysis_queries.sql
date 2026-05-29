.headers on
.mode column

.print 'Reasoning moves by stage'
SELECT stage, COUNT(*) AS move_count
FROM reasoning_move
GROUP BY stage
ORDER BY stage;

.print ''
.print 'Learning tasks with algorithmic and non-algorithmic components'
SELECT task_id, task_type, algorithmic_component, non_algorithmic_component
FROM learning_task
ORDER BY task_type, task_id;

.print ''
.print 'Assessment dimensions'
SELECT name, max_score, evidence_of_learning
FROM assessment_dimension
ORDER BY dimension_id;

.print ''
.print 'Solution audit total scores'
SELECT
  audit_id,
  task_id,
  student_id,
  method_used,
  framing_score + representation_score + strategy_score + assumption_score + justification_score + reflection_score AS total_score,
  comment
FROM solution_audit
ORDER BY total_score DESC, audit_id;

.print ''
.print 'AI output verification needs'
SELECT
  ai_output_id,
  task_id,
  claim_or_answer,
  known_issue,
  verification_needed
FROM ai_output_audit
ORDER BY ai_output_id;

.print ''
.print 'Misconception interventions'
SELECT name, diagnostic_signal, intervention
FROM misconception
ORDER BY misconception_id;
