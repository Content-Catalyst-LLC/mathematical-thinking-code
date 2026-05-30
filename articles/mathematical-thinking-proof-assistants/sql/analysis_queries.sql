.headers on
.mode column

.print 'Proof assistant systems'
SELECT system_name, foundation_or_logic, typical_strength, common_use, trust_note
FROM proof_assistant_system
ORDER BY system_id;

.print ''
.print 'Formalization projects'
SELECT project_name, proof_assistant, foundation, mathematical_domain, purpose
FROM formalization_project
ORDER BY project_id;

.print ''
.print 'Theorem statement audits'
SELECT theorem_id, informal_statement, formal_statement_summary, hypotheses, risk
FROM theorem_statement_audit
ORDER BY theorem_id;

.print ''
.print 'Trust boundaries'
SELECT theorem_id, trusted_component, trust_question, review_note
FROM proof_trust_boundary
ORDER BY boundary_id;

.print ''
.print 'Proof assistant skills'
SELECT skill_name, why_it_matters, review_question
FROM proof_assistant_skill
ORDER BY skill_id;

.print ''
.print 'AI-to-proof-assistant workflows'
SELECT stage, ai_role, proof_assistant_role, human_role, risk, mitigation
FROM ai_formalization_workflow
ORDER BY workflow_id;

.print ''
.print 'Responsible verification checklist'
SELECT stage, question, failure_mode, mitigation
FROM responsible_verification_check
ORDER BY check_id;
