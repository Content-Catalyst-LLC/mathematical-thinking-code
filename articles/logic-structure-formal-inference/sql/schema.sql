PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS counterexample;
DROP TABLE IF EXISTS derivation_dependency;
DROP TABLE IF EXISTS derivation_step;
DROP TABLE IF EXISTS proof_system;
DROP TABLE IF EXISTS quantifier_pattern;
DROP TABLE IF EXISTS inference_rule;
DROP TABLE IF EXISTS proposition;

CREATE TABLE proposition (
  proposition_id TEXT PRIMARY KEY,
  label TEXT NOT NULL,
  statement TEXT NOT NULL,
  proposition_type TEXT NOT NULL,
  domain_note TEXT NOT NULL
);

CREATE TABLE inference_rule (
  rule_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  formal_pattern TEXT NOT NULL,
  description TEXT NOT NULL,
  accepted_context TEXT NOT NULL
);

CREATE TABLE quantifier_pattern (
  pattern_id TEXT PRIMARY KEY,
  logical_form TEXT NOT NULL,
  plain_language TEXT NOT NULL,
  proof_strategy TEXT NOT NULL,
  refutation_strategy TEXT NOT NULL
);

CREATE TABLE proof_system (
  system_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  style TEXT NOT NULL,
  primary_use TEXT NOT NULL,
  professional_note TEXT NOT NULL
);

CREATE TABLE derivation_step (
  derivation_id TEXT NOT NULL,
  step_id TEXT NOT NULL,
  step_order INTEGER NOT NULL CHECK (step_order > 0),
  proposition_label TEXT NOT NULL,
  rule_id TEXT NOT NULL,
  justification TEXT NOT NULL,
  PRIMARY KEY (derivation_id, step_id)
);

CREATE TABLE derivation_dependency (
  source TEXT NOT NULL,
  target TEXT NOT NULL,
  relation TEXT NOT NULL,
  weight INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (source, target, relation)
);

CREATE TABLE counterexample (
  counterexample_id TEXT PRIMARY KEY,
  proposition_id TEXT NOT NULL,
  claim TEXT NOT NULL,
  object_description TEXT NOT NULL,
  failure_mode TEXT NOT NULL,
  lesson TEXT NOT NULL,
  FOREIGN KEY (proposition_id) REFERENCES proposition(proposition_id)
);

INSERT INTO proposition VALUES
('prop_p','P','P is an arbitrary proposition.','atomic','propositional logic'),
('prop_q','Q','Q is an arbitrary proposition.','atomic','propositional logic'),
('prop_even_square','EvenSquare','If n is even then n squared is even.','conditional','number theory'),
('prop_continuity','Continuity','For every epsilon there exists delta satisfying the continuity condition.','quantified','analysis'),
('prop_universal_refuted','BoundedConverges','Every bounded real sequence converges.','universal_false','analysis'),
('prop_graph_iso','DegreeSequenceIso','Finite graphs with same degree sequence are isomorphic.','universal_false','graph theory');

INSERT INTO inference_rule VALUES
('rule_modus_ponens','Modus Ponens','P->Q;P therefore Q','Applies implication when antecedent is established.','classical_and_constructive'),
('rule_modus_tollens','Modus Tollens','P->Q;not Q therefore not P','Uses contrapositive reasoning.','classical'),
('rule_conjunction_intro','Conjunction Introduction','P;Q therefore P_and_Q','Builds a conjunction from two established claims.','standard_logic'),
('rule_conjunction_elim','Conjunction Elimination','P_and_Q therefore P','Extracts one component of a conjunction.','standard_logic'),
('rule_universal_instantiation','Universal Instantiation','forall x P(x) therefore P(a)','Applies a universal claim to a specific object.','predicate_logic'),
('rule_existential_intro','Existential Introduction','P(a) therefore exists x P(x)','Proves existence by witness.','predicate_logic'),
('rule_counterexample','Counterexample','exists x not P(x) therefore not forall x P(x)','Refutes a universal claim.','predicate_logic'),
('rule_induction','Mathematical Induction','P(0);forall n P(n)->P(n+1) therefore forall n P(n)','Propagates truth across natural numbers.','arithmetic');

INSERT INTO quantifier_pattern VALUES
('qp_universal','forall x P(x)','Every object has property P.','Let x be arbitrary and prove P(x).','Find one x such that not P(x).'),
('qp_existential','exists x P(x)','At least one object has property P.','Construct a witness.','Show every candidate fails.'),
('qp_unique','exists unique x P(x)','Exactly one object has property P.','Prove existence then uniqueness.','Show none exist or at least two exist.'),
('qp_pointwise','forall x exists y R(x,y)','Each x has some possibly different y.','Given arbitrary x construct y.','Find x with no witness.'),
('qp_uniform','exists y forall x R(x,y)','One y works for every x.','Construct one universal witness.','Show every y fails for some x.');

INSERT INTO proof_system VALUES
('sys_natural_deduction','Natural Deduction','introduction_elimination_rules','readable_formal_proofs','Close to ordinary mathematical proof structure.'),
('sys_sequent_calculus','Sequent Calculus','context_to_conclusion_derivations','proof_theory','Good for structural proof analysis and cut elimination.'),
('sys_hilbert','Hilbert System','axiom_schemas_and_few_rules','metatheory','Compact but often less readable for humans.'),
('sys_type_theory','Type Theory','proofs_as_terms','constructive_math_and_assistants','Important for Lean Agda Rocq and related systems.'),
('sys_resolution','Resolution','refutation_search','automated_theorem_proving','Useful for mechanized proof search.');

INSERT INTO derivation_step VALUES
('drv_modus_ponens','step_1',1,'P->Q','premise','Given implication'),
('drv_modus_ponens','step_2',2,'P','premise','Given antecedent'),
('drv_modus_ponens','step_3',3,'Q','rule_modus_ponens','Apply modus ponens'),
('drv_contrapositive','step_1',1,'P->Q','premise','Original implication'),
('drv_contrapositive','step_2',2,'not_Q','premise','Assume negated consequent'),
('drv_contrapositive','step_3',3,'not_P','rule_modus_tollens','Apply modus tollens'),
('drv_counterexample','step_1',1,'exists_x_not_Px','premise','Counterexample witness exists'),
('drv_counterexample','step_2',2,'not_forall_x_Px','rule_counterexample','Universal claim refuted');

INSERT INTO derivation_dependency VALUES
('drv_modus_ponens:step_1','drv_modus_ponens:step_3','supports',2),
('drv_modus_ponens:step_2','drv_modus_ponens:step_3','supports',2),
('drv_contrapositive:step_1','drv_contrapositive:step_3','supports',2),
('drv_contrapositive:step_2','drv_contrapositive:step_3','supports',2),
('drv_counterexample:step_1','drv_counterexample:step_2','refutes_universal',3),
('rule_modus_ponens','drv_modus_ponens:step_3','justifies_rule_application',3),
('rule_modus_tollens','drv_contrapositive:step_3','justifies_rule_application',3),
('rule_counterexample','drv_counterexample:step_2','justifies_rule_application',3);

INSERT INTO counterexample VALUES
('ce_bounded_sequence','prop_universal_refuted','Every bounded real sequence converges.','The sequence (-1)^n is bounded but does not converge.','Boundedness alone is insufficient.','A universal claim fails when one domain object violates it.'),
('ce_degree_sequence','prop_graph_iso','Finite graphs with same degree sequence are isomorphic.','Non-isomorphic graphs can share degree sequence.','Degree sequence is incomplete.','An invariant may be useful without being complete.'),
('ce_converse_error','prop_even_square','If n squared is even then n is even follows by the same direction.','Attempting to prove converse without separate argument.','Direction of implication matters.','Biconditional claims require both directions.'),
('ce_finite_audit','prop_even_square','Checking finitely many even n proves the universal claim.','Finite case table from -50 to 50.','Finite evidence is not proof.','Proof must cover arbitrary domain objects.');
