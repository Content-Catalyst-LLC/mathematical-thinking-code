PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS counterexample;
DROP TABLE IF EXISTS proof_dependency;
DROP TABLE IF EXISTS proof_step;
DROP TABLE IF EXISTS assumption;
DROP TABLE IF EXISTS inference_rule;
DROP TABLE IF EXISTS claim;

CREATE TABLE claim (
  claim_id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  claim_type TEXT NOT NULL,
  statement TEXT NOT NULL,
  domain TEXT NOT NULL,
  proof_status TEXT NOT NULL
);

CREATE TABLE assumption (
  assumption_id TEXT PRIMARY KEY,
  claim_id TEXT NOT NULL,
  statement TEXT NOT NULL,
  assumption_type TEXT NOT NULL,
  FOREIGN KEY (claim_id) REFERENCES claim(claim_id)
);

CREATE TABLE proof_step (
  proof_step_id TEXT PRIMARY KEY,
  claim_id TEXT NOT NULL,
  step_order INTEGER NOT NULL CHECK (step_order > 0),
  statement TEXT NOT NULL,
  justification TEXT NOT NULL,
  FOREIGN KEY (claim_id) REFERENCES claim(claim_id)
);

CREATE TABLE proof_dependency (
  source_claim_id TEXT NOT NULL,
  target_claim_id TEXT NOT NULL,
  relation_type TEXT NOT NULL,
  weight INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (source_claim_id, target_claim_id, relation_type),
  FOREIGN KEY (source_claim_id) REFERENCES claim(claim_id),
  FOREIGN KEY (target_claim_id) REFERENCES claim(claim_id)
);

CREATE TABLE inference_rule (
  rule_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  formal_pattern TEXT NOT NULL,
  description TEXT NOT NULL,
  accepted_context TEXT NOT NULL
);

CREATE TABLE counterexample (
  counterexample_id TEXT PRIMARY KEY,
  claim_id TEXT NOT NULL,
  object_description TEXT NOT NULL,
  failure_mode TEXT NOT NULL,
  lesson TEXT NOT NULL,
  FOREIGN KEY (claim_id) REFERENCES claim(claim_id)
);

INSERT INTO claim VALUES
('def_even','Even Integer Definition','definition','An integer n is even iff n=2k for some integer k.','number theory','definition'),
('lemma_even_square','Even Square Lemma','lemma','If n is even, then n^2 is even.','number theory','proved'),
('thm_sum_first_n','Sum of First n Positive Integers','theorem','For every positive integer n, 1+2+...+n=n(n+1)/2.','discrete mathematics','proved_by_induction'),
('claim_bounded_converges','Bounded Sequence Convergence Claim','false_conjecture','Every bounded real sequence converges.','analysis','refuted'),
('claim_degree_sequence_iso','Degree Sequence Isomorphism Claim','false_conjecture','Finite graphs with the same degree sequence are isomorphic.','graph theory','refuted'),
('rule_modus_ponens','Modus Ponens','inference_rule','From A implies B and A, infer B.','logic','accepted_rule'),
('rule_induction','Mathematical Induction','inference_rule','A base case and successor-preservation establish a natural-number statement.','logic','accepted_rule');

INSERT INTO assumption VALUES
('asm_even_integer','lemma_even_square','n is an even integer.','hypothesis'),
('asm_positive_integer','thm_sum_first_n','n is a positive integer.','domain'),
('asm_real_sequence','claim_bounded_converges','The sequence is a bounded real sequence.','hypothesis'),
('asm_finite_graph','claim_degree_sequence_iso','The objects are finite simple graphs.','domain'),
('asm_implication','rule_modus_ponens','A implies B.','premise'),
('asm_antecedent','rule_modus_ponens','A holds.','premise'),
('asm_base_case','rule_induction','P(0) or P(1) holds.','premise'),
('asm_successor_step','rule_induction','For arbitrary n, P(n) implies P(n+1).','premise');

INSERT INTO proof_step VALUES
('ps_even_1','lemma_even_square',1,'Let n be even.','Hypothesis.'),
('ps_even_2','lemma_even_square',2,'Then n=2k for some integer k.','Definition of even.'),
('ps_even_3','lemma_even_square',3,'Then n^2=(2k)^2=4k^2=2(2k^2).','Algebra.'),
('ps_even_4','lemma_even_square',4,'Therefore n^2 is even.','Definition of even.'),
('ps_sum_1','thm_sum_first_n',1,'The formula holds for n=1.','Both sides equal 1.'),
('ps_sum_2','thm_sum_first_n',2,'Assume the formula holds for n.','Induction hypothesis.'),
('ps_sum_3','thm_sum_first_n',3,'Add n+1 to both sides.','Inductive construction.'),
('ps_sum_4','thm_sum_first_n',4,'The result simplifies to (n+1)(n+2)/2.','Algebra.'),
('ps_sum_5','thm_sum_first_n',5,'Therefore the formula holds for all positive integers n.','Mathematical induction.');

INSERT INTO proof_dependency VALUES
('def_even','lemma_even_square','supports',3),
('rule_induction','thm_sum_first_n','justifies_method',3),
('rule_modus_ponens','lemma_even_square','background_inference',1),
('rule_modus_ponens','thm_sum_first_n','background_inference',1),
('claim_bounded_converges','claim_degree_sequence_iso','shares_false_generalization_pattern',1);

INSERT INTO inference_rule VALUES
('rule_modus_ponens','Modus Ponens','A->B; A; therefore B','Applies an implication when the antecedent is established.','classical and constructive logic'),
('rule_contradiction','Proof by Contradiction','not C -> contradiction; therefore C','Establishes C by showing its negation is impossible.','classical logic'),
('rule_induction','Mathematical Induction','P(0); forall n P(n)->P(n+1); therefore forall n P(n)','Propagates truth across natural numbers.','arithmetic and recursive structures'),
('rule_counterexample','Counterexample','exists x not P(x); therefore not forall x P(x)','Refutes a universal claim with one failing instance.','standard first-order reasoning'),
('rule_construction','Constructive Existence','construct x with P(x); therefore exists x P(x)','Establishes existence by building a witness.','constructive and classical mathematics');

INSERT INTO counterexample VALUES
('ce_bounded_alt','claim_bounded_converges','The sequence (-1)^n is bounded but does not converge.','boundedness alone is insufficient','A stronger theorem may require monotonicity or compactness conditions.'),
('ce_degree_sequence','claim_degree_sequence_iso','Two non-isomorphic finite graphs can share the same degree sequence.','degree sequence is an incomplete invariant','Invariants may distinguish some objects without fully classifying them.'),
('ce_finite_cases','thm_sum_first_n','Checking the first 100 cases does not prove the formula for all n.','finite evidence is not universal proof','Induction supplies the missing general mechanism.'),
('ce_diagram','lemma_even_square','A convincing diagram may suggest evenness but not establish it.','visual intuition is not proof','Definitions and algebra carry the logical burden.');
