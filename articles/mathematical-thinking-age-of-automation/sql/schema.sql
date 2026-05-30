PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS proof_assistant_layer;
DROP TABLE IF EXISTS human_judgment_skill;
DROP TABLE IF EXISTS automation_risk;
DROP TABLE IF EXISTS verification_record;
DROP TABLE IF EXISTS automation_tool;
DROP TABLE IF EXISTS automation_task;

CREATE TABLE automation_task (
  task_id TEXT PRIMARY KEY,
  task_name TEXT NOT NULL,
  tool_type TEXT NOT NULL,
  mathematical_object TEXT NOT NULL,
  output_type TEXT NOT NULL,
  assumptions TEXT NOT NULL,
  verification_method TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE automation_tool (
  tool_id TEXT PRIMARY KEY,
  tool_name TEXT NOT NULL,
  tool_category TEXT NOT NULL,
  strength TEXT NOT NULL,
  human_review TEXT NOT NULL,
  failure_mode TEXT NOT NULL
);

CREATE TABLE verification_record (
  verification_id TEXT PRIMARY KEY,
  task_id TEXT NOT NULL,
  verification_method TEXT NOT NULL,
  evidence_standard TEXT NOT NULL,
  trust_boundary TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE automation_risk (
  risk_id TEXT PRIMARY KEY,
  risk_name TEXT NOT NULL,
  mathematical_problem TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE human_judgment_skill (
  skill_id TEXT PRIMARY KEY,
  skill_name TEXT NOT NULL,
  automation_context TEXT NOT NULL,
  why_it_matters TEXT NOT NULL,
  review_question TEXT NOT NULL
);

CREATE TABLE proof_assistant_layer (
  layer_id TEXT PRIMARY KEY,
  layer_name TEXT NOT NULL,
  human_role TEXT NOT NULL,
  machine_role TEXT NOT NULL,
  risk_or_limitation TEXT NOT NULL
);

INSERT INTO automation_task VALUES
('task_calculation_units','Calculate physical quantity','calculator','quantity with units','arithmetic output','inputs, units, operation, precision','unit check, estimate, dimensional review','correct arithmetic can still answer the wrong quantity'),
('task_symbolic_simplification','Simplify sqrt(x^2)','computer algebra system','symbolic expression','symbolic transformation','domain of x, branch choices, simplification rules','equivalence check under explicit assumptions','domain conditions determine whether x or abs(x) is appropriate'),
('task_epidemic_simulation','Simulate epidemic curve','numerical simulator','dynamical model','simulation trajectory','model structure, parameters, initial conditions, step size','sensitivity analysis, stability review, validation against data','simulation output is model-based exploration, not proof'),
('task_ai_proof_outline','Generate proof outline','AI assistant','informal theorem and reasoning path','AI-generated explanation','definitions, lemmas, theorem statements, background claims','step-by-step proof review or formalization','AI suggestions require independent mathematical checking'),
('task_formal_proof_check','Check theorem in proof assistant','proof assistant','formal theorem and proof object','machine-checked derivation','formal statement, libraries, kernel, foundations','machine check plus informal statement review','verified derivation must still match intended mathematical meaning');

INSERT INTO automation_tool VALUES
('tool_calculator','Calculator','arithmetic automation','arithmetic speed and precision','quantity, units, operation, and reasonableness','right number for wrong problem'),
('tool_cas','Computer algebra system','symbolic automation','symbolic manipulation and exact transformation','domain assumptions, equivalence, and lost conditions','invalid or misleading simplification'),
('tool_simulator','Numerical simulator','numerical automation','model exploration and approximation','stability, sensitivity, validation, and interpretation','simulation mistaken for proof or reality'),
('tool_ai','AI assistant','generative assistance','proposal generation, explanation, code drafting, and search','independent verification of every mathematical claim','fluent falsehood'),
('tool_proof_assistant','Proof assistant','formal verification','machine-checked formal derivation','formal statement, libraries, kernel, foundations, and intended meaning','verified theorem with wrong informal interpretation');

INSERT INTO verification_record VALUES
('verify_units','task_calculation_units','unit and estimate review','arithmetic correctness plus dimensional sense','inputs, units, operation, precision','dimensional correctness helps detect nonsense'),
('verify_symbolic','task_symbolic_simplification','symbolic equivalence under assumptions','algebraic validity under stated domain','domain, branches, expression language, simplifier rules','symbolic equivalence is conditional on assumptions'),
('verify_simulation','task_epidemic_simulation','sensitivity, stability, convergence, and validation checks','model-based numerical adequacy','model form, method, parameters, data','simulation is evidence under assumptions'),
('verify_ai','task_ai_proof_outline','independent proof review','valid inference or formal derivation','definitions, lemmas, generated claims','AI output is proposal, not authority'),
('verify_formal','task_formal_proof_check','proof assistant check plus statement audit','machine-checked derivation','kernel, libraries, formal statement, foundations','formal result requires intended-meaning review');

INSERT INTO automation_risk VALUES
('risk_fluent_falsehood','Fluent falsehood','convincing explanation with invalid reasoning','check definitions, steps, examples, and proof obligations'),
('risk_hidden_assumptions','Hidden assumptions','output is valid only under unstated conditions','document domain, constraints, parameters, data, and libraries'),
('risk_model_overreach','Model overreach','formal model treated as reality','validate model, state limitations, and run sensitivity checks'),
('risk_optimization_harm','Optimization harm','wrong objective optimized efficiently','review objectives, constraints, affected groups, and decision context before solving'),
('risk_formal_mismatch','Formal mismatch','verified theorem differs from intended informal claim','review formal statement, definitions, theorem scope, and library assumptions'),
('risk_skill_erosion','Skill erosion','users lose estimation, sense-making, and verification habits','teach tools alongside reasoning, explanation, and independent checks');

INSERT INTO human_judgment_skill VALUES
('skill_specification','Specification','modeling, proof assistants, programming, AI prompts','automated systems need precise tasks','What exactly is being asked?'),
('skill_representation','Representation choice','graphs, matrices, equations, algorithms, diagrams','different representations reveal different structures','Is this the right mathematical form?'),
('skill_assumptions','Assumption tracking','symbolic computation, modeling, proof, statistics','automated outputs depend on hidden conditions','Which assumptions make the result valid?'),
('skill_counterexample','Counterexample thinking','AI explanations, conjectures, symbolic rules, theorem statements','protects against overgeneralization','What case would break this claim?'),
('skill_interpretation','Interpretation','simulation, statistics, optimization, verification','outputs need meaning and consequence review','What does this result mean in context?'),
('skill_communication','Communication','education, research, policy, engineering','mathematics must remain understandable to humans','Can the result be explained clearly and responsibly?');

INSERT INTO proof_assistant_layer VALUES
('layer_concept','Concept','decide what mathematical idea matters','no independent mathematical purpose','important questions may be formalized poorly or not at all'),
('layer_definition','Definition','choose formal objects and assumptions','check syntax and type correctness','bad definitions can make a proof correct but unhelpful'),
('layer_statement','Theorem statement','translate informal claim into formal language','represent the proposition precisely','formal statement may not match intended informal meaning'),
('layer_proof','Proof construction','guide strategy, structure, and decomposition','verify accepted inference steps','machine verification does not explain importance'),
('layer_interpretation','Interpretation','explain why the result matters','no social or philosophical judgment','formal correctness can be overextended into unwarranted authority');
