PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS responsible_verification_check;
DROP TABLE IF EXISTS ai_formalization_workflow;
DROP TABLE IF EXISTS proof_layer;
DROP TABLE IF EXISTS proof_assistant_skill;
DROP TABLE IF EXISTS proof_trust_boundary;
DROP TABLE IF EXISTS theorem_statement_audit;
DROP TABLE IF EXISTS formalization_project;
DROP TABLE IF EXISTS proof_assistant_system;

CREATE TABLE proof_assistant_system (
  system_id TEXT PRIMARY KEY,
  system_name TEXT NOT NULL,
  foundation_or_logic TEXT NOT NULL,
  typical_strength TEXT NOT NULL,
  common_use TEXT NOT NULL,
  trust_note TEXT NOT NULL
);

CREATE TABLE formalization_project (
  project_id TEXT PRIMARY KEY,
  project_name TEXT NOT NULL,
  proof_assistant TEXT NOT NULL,
  foundation TEXT NOT NULL,
  mathematical_domain TEXT NOT NULL,
  purpose TEXT NOT NULL,
  status_note TEXT NOT NULL
);

CREATE TABLE theorem_statement_audit (
  theorem_id TEXT PRIMARY KEY,
  project_id TEXT NOT NULL,
  informal_statement TEXT NOT NULL,
  formal_statement_summary TEXT NOT NULL,
  hypotheses TEXT NOT NULL,
  intended_meaning_review TEXT NOT NULL,
  risk TEXT NOT NULL
);

CREATE TABLE proof_trust_boundary (
  boundary_id TEXT PRIMARY KEY,
  theorem_id TEXT NOT NULL,
  trusted_component TEXT NOT NULL,
  trust_question TEXT NOT NULL,
  review_note TEXT NOT NULL
);

CREATE TABLE proof_assistant_skill (
  skill_id TEXT PRIMARY KEY,
  skill_name TEXT NOT NULL,
  why_it_matters TEXT NOT NULL,
  review_question TEXT NOT NULL
);

CREATE TABLE proof_layer (
  layer_id TEXT PRIMARY KEY,
  layer_name TEXT NOT NULL,
  human_role TEXT NOT NULL,
  machine_role TEXT NOT NULL,
  risk_or_limitation TEXT NOT NULL
);

CREATE TABLE ai_formalization_workflow (
  workflow_id TEXT PRIMARY KEY,
  stage TEXT NOT NULL,
  ai_role TEXT NOT NULL,
  proof_assistant_role TEXT NOT NULL,
  human_role TEXT NOT NULL,
  risk TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE responsible_verification_check (
  check_id TEXT PRIMARY KEY,
  stage TEXT NOT NULL,
  question TEXT NOT NULL,
  failure_mode TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO proof_assistant_system VALUES
('sys_lean','Lean','dependent type theory','large modern mathematics library and active community','formal mathematics, education, AI-assisted theorem proving','review formal statement, imported libraries, kernel, and accepted axioms'),
('sys_rocq','Rocq / Coq','calculus of inductive constructions','dependent type theory and constructive formalization','mathematics, programming languages, certified software','review constructive assumptions, extraction pipeline, libraries, and kernel'),
('sys_isabelle','Isabelle/HOL','generic framework with higher-order logic as major object logic','mature automation and structured proof','formal mathematics, verification, logic, computer science','review object logic, automation, imported theories, and formal statement'),
('sys_hol_light','HOL Light','classical higher-order logic','small trusted core and landmark theorem formalizations','formalized analysis, verification, theorem proving','review core, axioms, definitions, and theorem statement'),
('sys_mizar','Mizar','set-theoretic formalization with declarative style','long-standing mathematical library and readable formal style','formalized mathematics and library development','review definitions, library dependencies, and article environment'),
('sys_agda','Agda','dependent type theory','constructive mathematics and programming with dependent types','type theory, constructive proof, programming-language research','review termination, types, constructive commitments, and formal meaning'),
('sys_metamath','Metamath','minimal formal proof framework','foundational transparency and explicit proof databases','minimal proof checking and formal databases','review axioms, compressed proof checking, and database dependencies');

INSERT INTO formalization_project VALUES
('proj_basic_algebra','Basic algebra formalization','Lean','dependent type theory','algebra','show how definitions and lemmas become reusable infrastructure','synthetic teaching project'),
('proj_continuity','Continuity theorem formalization','Isabelle/HOL','higher-order logic','analysis','audit assumptions and statement precision in analysis','synthetic teaching project'),
('proj_induction','Induction proof formalization','Rocq / Coq','dependent type theory','logic and arithmetic','show proof as construction and recursion over structure','synthetic teaching project'),
('proj_ai_bridge','AI-to-proof-assistant workflow','Lean','dependent type theory','formalization workflow','treat AI output as proposal and proof assistant output as checked derivation','workflow audit project'),
('proj_trust_review','Trust-boundary review','multiple','multiple','formal verification governance','map formal statement, kernel, axioms, libraries, and intended meaning','cross-system review project');

INSERT INTO theorem_statement_audit VALUES
('thm_group_identity','proj_basic_algebra','The identity element of a group is unique.','For any group and any two identity-like elements satisfying identity laws, the elements are equal.','group structure, identity laws, equality in carrier type','Confirm that identity-like element conditions match the informal uniqueness claim.','formal statement may prove uniqueness for a stronger or weaker predicate'),
('thm_continuity_sum','proj_continuity','The sum of continuous functions is continuous.','In a specified topological or metric setting, if f and g are continuous, then f plus g is continuous.','domain space, codomain structure, addition operation, continuity definition','Confirm the topology, codomain, and addition structure match the intended theorem.','missing structure or overly specific domain'),
('thm_induction_sum','proj_induction','A recursively defined sum formula holds for all natural numbers.','By induction on natural numbers, base and successor cases imply universal property.','natural numbers, recursive definition, proposition over n','Confirm the recursive definition and induction principle match the informal proof.','off-by-one statement or wrong induction target'),
('thm_ai_suggested','proj_ai_bridge','An AI-suggested lemma appears to simplify the target proof.','Candidate lemma is formalized with explicit variables and hypotheses.','all generated assumptions must be explicit and checked','Translate the AI-suggested statement back into prose before relying on it.','fluent false lemma or irrelevant formalization');

INSERT INTO proof_trust_boundary VALUES
('bound_kernel','thm_group_identity','kernel or checker','What core component validates the derivation?','Keep the trusted core and unsafe mechanisms visible.'),
('bound_axioms','thm_continuity_sum','axioms and foundations','Which axioms or logic principles are admitted?','Record classical, constructive, choice, quotient, and extensionality assumptions where relevant.'),
('bound_libraries','thm_continuity_sum','imported libraries','Which definitions and prior theorems are imported?','Track library dependencies and naming conventions.'),
('bound_statement','thm_ai_suggested','formal statement','Does the checked statement match the intended informal claim?','Machine checking verifies derivability, not intended meaning.'),
('bound_interpretation','thm_induction_sum','human interpretation','What should not be inferred from the formal proof?','State scope, limitations, and explanation separately from checking.');

INSERT INTO proof_assistant_skill VALUES
('skill_formal_statement','Reading formal statements','the machine checks the formal statement, not the informal intention','Can the formal statement be translated back into ordinary mathematical prose?'),
('skill_assumptions','Tracking assumptions','hidden assumptions determine theorem scope','Which hypotheses, axioms, instances, and libraries are used?'),
('skill_definitions','Choosing definitions','definitions shape proof difficulty and reuse','Does this definition preserve the intended mathematical concept?'),
('skill_libraries','Using libraries','formal mathematics is cumulative infrastructure','Which existing theorem, structure, or convention should be reused?'),
('skill_tactics','Understanding tactics','automation helps construct proof steps but must be understood','What did the tactic actually solve?'),
('skill_interpretation','Interpreting verification','machine checking verifies derivation, not broader meaning','What exactly has been verified, and what remains a human judgment?');

INSERT INTO proof_layer VALUES
('layer_concept','Concept','choose the mathematical problem and why it matters','no independent mathematical purpose','formalizing a poorly framed or trivial question'),
('layer_definition','Definition','encode objects, structures, and assumptions','check syntax and type correctness','definition works formally but obscures meaning'),
('layer_statement','Theorem statement','state the intended theorem precisely','represent the proposition in formal language','machine checks the wrong theorem'),
('layer_proof','Proof construction','guide strategy, decomposition, and lemma selection','track goals and accept valid proof steps','proof script becomes opaque or fragile'),
('layer_check','Machine check','understand the trusted components and accepted assumptions','check derivation under formal rules','trust boundary misunderstood'),
('layer_interpretation','Interpretation','explain significance, scope, and limitations','no contextual or ethical judgment','formal correctness replaces explanation');

INSERT INTO ai_formalization_workflow VALUES
('wf_premise_retrieval','premise retrieval','suggest relevant theorems or library names','check whether suggested theorem applies in proof context','review hypotheses and applicability','irrelevant or inapplicable premise','inspect theorem statement and proof state'),
('wf_statement_draft','statement drafting','draft formal statement or syntax','parse and type-check the statement','review intended meaning and scope','formal mismatch','translate formal statement back into prose'),
('wf_tactic_suggestion','tactic suggestion','suggest tactic or proof step','accept or reject resulting derivation','understand what the tactic solved','opaque proof script','document proof strategy and dependencies'),
('wf_error_explanation','error explanation','explain error message or proof state','provide actual goals and type errors','compare explanation to real proof state','misleading explanation','trust proof state over generated prose'),
('wf_proof_outline','proof outline','suggest informal strategy','check formal proof when implemented','verify every inference and interpret result','fluent falsehood','formalize or independently prove each step');

INSERT INTO responsible_verification_check VALUES
('check_define','Define','What objects and structures are being encoded?','bad definitions make proofs awkward or misleading','compare formal definitions against examples and intended use'),
('check_state','State','What exactly is the theorem?','formal statement misses informal meaning','translate formal statement back into prose and review hypotheses'),
('check_prove','Prove','How is the derivation constructed?','proof script becomes fragile or opaque','use named lemmas, comments, and modular proof structure'),
('check_check','Check','What does the system verify?','trust boundary is misunderstood','document kernel, axioms, libraries, unsafe features, and accepted assumptions'),
('check_interpret','Interpret','What does the theorem mean and why does it matter?','formal correctness replaces explanation','state scope, significance, limitations, and responsible use');
