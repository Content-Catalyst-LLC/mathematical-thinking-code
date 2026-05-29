PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS solution_audit;
DROP TABLE IF EXISTS ai_output_audit;
DROP TABLE IF EXISTS misconception;
DROP TABLE IF EXISTS assessment_dimension;
DROP TABLE IF EXISTS learning_task;
DROP TABLE IF EXISTS reasoning_move;

CREATE TABLE reasoning_move (
  move_id TEXT PRIMARY KEY,
  stage TEXT NOT NULL,
  guiding_question TEXT NOT NULL,
  mathematical_role TEXT NOT NULL,
  evidence_of_learning TEXT NOT NULL
);

CREATE TABLE learning_task (
  task_id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  task_type TEXT NOT NULL,
  algorithmic_component TEXT NOT NULL,
  non_algorithmic_component TEXT NOT NULL
);

CREATE TABLE assessment_dimension (
  dimension_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  evidence_of_learning TEXT NOT NULL,
  max_score INTEGER NOT NULL
);

CREATE TABLE misconception (
  misconception_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  diagnostic_signal TEXT NOT NULL,
  intervention TEXT NOT NULL
);

CREATE TABLE ai_output_audit (
  ai_output_id TEXT PRIMARY KEY,
  task_id TEXT NOT NULL,
  claim_or_answer TEXT NOT NULL,
  method_summary TEXT NOT NULL,
  known_issue TEXT NOT NULL,
  verification_needed TEXT NOT NULL,
  FOREIGN KEY (task_id) REFERENCES learning_task(task_id)
);

CREATE TABLE solution_audit (
  audit_id TEXT PRIMARY KEY,
  task_id TEXT NOT NULL,
  student_id TEXT NOT NULL,
  method_used TEXT NOT NULL,
  framing_score INTEGER NOT NULL,
  representation_score INTEGER NOT NULL,
  strategy_score INTEGER NOT NULL,
  assumption_score INTEGER NOT NULL,
  justification_score INTEGER NOT NULL,
  reflection_score INTEGER NOT NULL,
  comment TEXT NOT NULL,
  FOREIGN KEY (task_id) REFERENCES learning_task(task_id)
);

INSERT INTO reasoning_move VALUES
('notice_pattern','notice','What pattern or structure appears?','initiates conjecture and exploration','student identifies regularity or anomaly'),
('frame_problem','frame','What is the mathematical problem?','turns a situation into a mathematical task','student states object goal constraints and assumptions'),
('choose_representation','represent','Which representation makes the structure visible?','supports strategy selection and transfer','student justifies equation graph table diagram code or proof tree'),
('check_assumptions','justify','What conditions does this method require?','prevents invalid procedure use','student names domain constraints and hypotheses'),
('verify_output','justify','Does the answer satisfy the original problem?','connects procedure output to validation','student checks residuals substitution units or theorem conditions'),
('search_counterexample','reason','Can the claim fail in a boundary case?','tests generality and sharpens statements','student constructs or searches for failing cases'),
('reflect_transfer','reflect','What does this problem teach for future problems?','builds metacognitive transfer','student names principle method or limitation');

INSERT INTO learning_task VALUES
('task_quadratic_roots','Quadratic roots and verification','procedural_plus_verification','apply quadratic formula','check roots by substitution and interpret discriminant'),
('task_function_representation','Represent a function three ways','representation_choice','evaluate formula values','compare table graph equation and domain meaning'),
('task_false_generalization','Find a counterexample to a universal claim','counterexample','test cases','explain why one counterexample refutes the universal statement'),
('task_proof_strategy','Choose a proof strategy','proof_judgment','apply inference rules','decide direct proof induction contradiction or construction'),
('task_ai_solution_audit','Audit an AI-generated solution','ai_verification','parse generated steps','identify assumptions errors missing justification and interpretation'),
('task_model_framing','Frame an applied modeling problem','modeling','set up equations','state assumptions units variables limitations and interpretation');

INSERT INTO assessment_dimension VALUES
('dim_framing','Problem framing','identifies object goal constraints assumptions and domain','clear statement of what is being solved and why',3),
('dim_representation','Representation choice','selects and justifies a useful mathematical representation','representation is appropriate and limitations are noted',3),
('dim_strategy','Strategy explanation','explains why a method applies','strategy is linked to structure not only template',3),
('dim_assumptions','Assumption checking','checks conditions domains and hidden requirements','assumptions are named and verified',3),
('dim_justification','Justification','shows why conclusion follows','proof explanation verification or residual check is present',4),
('dim_reflection','Reflection','connects task to transfer limitations or alternative strategies','student articulates learning beyond answer',2);

INSERT INTO misconception VALUES
('mis_examples_as_proof','Examples as proof','treating many examples as proof of a universal claim','student says checked cases prove all cases','introduce counterexample logic and quantifier negation'),
('mis_domain_omission','Domain omission','using formulas without domain conditions','student applies method outside allowed domain','require domain and assumption check'),
('mis_answer_only','Answer-only reasoning','reporting result without interpretation or verification','student gives number but no meaning','add residual checks and explanation prompts'),
('mis_symbol_manipulation','Symbol manipulation without meaning','performing algebraic moves without equivalence awareness','extraneous solution or invalid operation appears','teach transformation validity and substitution checks'),
('mis_tool_trust','Uncritical tool trust','accepting calculator AI or CAS output without review','student cannot explain or verify output','require verification and interpretation workflow');

INSERT INTO ai_output_audit VALUES
('ai_quad_ok','task_quadratic_roots','roots are 2 and 3','uses quadratic formula','mostly correct but needs residual verification','substitute roots into original equation'),
('ai_square_bad','task_false_generalization','checking many square numbers proves the rule','finite examples','confuses finite evidence with proof','distinguish sample evidence from universal proof'),
('ai_domain_bad','task_function_representation','f(x)=sqrt(x) works for all real x','formula statement','ignores real-domain restriction','state domain x >= 0 for real-valued function'),
('ai_proof_gap','task_proof_strategy','therefore the theorem is true by examples','example-based explanation','examples do not prove universal theorem','provide proof or label as conjecture');

INSERT INTO solution_audit VALUES
('audit_a1','task_quadratic_roots','A','quadratic formula',3,2,2,2,3,1,'correct computation with partial interpretation'),
('audit_b1','task_quadratic_roots','B','quadratic formula',1,1,1,0,1,0,'answer-focused with no assumption or residual check'),
('audit_c1','task_quadratic_roots','C','factoring and verification',3,3,3,3,4,2,'strong reasoning and verification'),
('audit_a2','task_false_generalization','A','counterexample search',2,2,2,2,3,1,'found example but explanation needs precision'),
('audit_b2','task_false_generalization','B','finite testing',1,1,1,0,1,0,'mistook finite evidence for proof'),
('audit_c2','task_false_generalization','C','constructed boundary case',3,2,3,3,4,2,'explained why counterexample refutes universal claim');
