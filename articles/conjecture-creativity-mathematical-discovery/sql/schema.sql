PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS proof_attempt;
DROP TABLE IF EXISTS counterexample;
DROP TABLE IF EXISTS evidence_record;
DROP TABLE IF EXISTS discovery_method;
DROP TABLE IF EXISTS conjecture;

CREATE TABLE conjecture (
  conjecture_id TEXT PRIMARY KEY,
  statement TEXT NOT NULL,
  domain_description TEXT NOT NULL,
  mathematical_area TEXT NOT NULL,
  proof_status TEXT NOT NULL,
  discovery_note TEXT NOT NULL
);

CREATE TABLE evidence_record (
  evidence_id TEXT PRIMARY KEY,
  conjecture_id TEXT NOT NULL,
  evidence_type TEXT NOT NULL,
  description TEXT NOT NULL,
  range_or_scope TEXT NOT NULL,
  interpretation TEXT NOT NULL,
  FOREIGN KEY (conjecture_id) REFERENCES conjecture(conjecture_id)
);

CREATE TABLE counterexample (
  counterexample_id TEXT PRIMARY KEY,
  conjecture_id TEXT NOT NULL,
  object_description TEXT NOT NULL,
  failure_mode TEXT NOT NULL,
  revision_suggestion TEXT NOT NULL,
  FOREIGN KEY (conjecture_id) REFERENCES conjecture(conjecture_id)
);

CREATE TABLE proof_attempt (
  proof_attempt_id TEXT PRIMARY KEY,
  conjecture_id TEXT NOT NULL,
  method TEXT NOT NULL,
  status TEXT NOT NULL,
  lesson TEXT NOT NULL,
  FOREIGN KEY (conjecture_id) REFERENCES conjecture(conjecture_id)
);

CREATE TABLE discovery_method (
  method_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  purpose TEXT NOT NULL,
  risk TEXT NOT NULL,
  professional_practice TEXT NOT NULL
);

INSERT INTO conjecture VALUES
('conj_even_square','If n is even then n squared is even.','integers','number_theory','proved','finite checks suggest the claim and direct proof establishes it'),
('conj_sum_first_n','The sum of the first n positive integers is n(n+1)/2.','positive_integers','discrete_mathematics','proved_by_induction','finite values suggest a polynomial formula'),
('conj_bounded_converges','Every bounded real sequence converges.','real_sequences','analysis','refuted','typical convergent examples can mislead'),
('conj_degree_sequence_iso','Finite simple graphs with the same degree sequence are isomorphic.','finite_graphs','graph_theory','refuted','degree sequence is useful but incomplete'),
('conj_cycle_rank_nonnegative','For a finite undirected graph the cycle rank m-n+c is nonnegative.','finite_graphs','graph_theory','proved_under_standard_assumptions','computable invariant suggests structural theorem'),
('conj_logistic_bounded','Logistic map iterates remain in [0,1] for r in [0,4] and initial x in [0,1].','dynamical_systems','dynamics','proved_under_assumptions','simulation suggests boundedness under parameter constraints');

INSERT INTO evidence_record VALUES
('ev_even_square_100','conj_even_square','finite_check','checked integers from -100 to 100','-100..100','supports but does not replace direct proof'),
('ev_sum_first_100','conj_sum_first_n','finite_check','checked first 100 positive integers','1..100','supports but induction proves generality'),
('ev_bounded_examples','conj_bounded_converges','example_set','constant and monotone bounded sequences converge','small_examples','misleading if treated as universal evidence'),
('ev_alternating_counterexample','conj_bounded_converges','counterexample','alternating sequence (-1)^n is bounded and nonconvergent','all_n','refutes original conjecture'),
('ev_degree_small_graphs','conj_degree_sequence_iso','counterexample_search','small graph search finds shared degree sequences','small_graph_catalog','degree sequence is incomplete invariant'),
('ev_logistic_simulation','conj_logistic_bounded','simulation','iterated logistic map over sampled parameters','sample_grid','suggestive evidence under numerical assumptions');

INSERT INTO counterexample VALUES
('ce_bounded_alt','conj_bounded_converges','The sequence (-1)^n is bounded but does not converge.','boundedness alone is insufficient','add monotonicity or compactness-style subsequence conclusions'),
('ce_degree_sequence','conj_degree_sequence_iso','Non-isomorphic finite graphs can share the same degree sequence.','degree sequence is not a complete invariant','use stronger invariants or full isomorphism testing'),
('ce_finite_cases','conj_sum_first_n','Checking first 100 cases does not prove the formula for all n.','finite evidence is not universal proof','use induction or another proof method'),
('ce_diagram_generalization','conj_even_square','A convincing diagram does not prove the arbitrary integer case.','visual intuition is not proof','translate intuition into definition-based proof');

INSERT INTO proof_attempt VALUES
('pa_even_square_direct','conj_even_square','direct_proof','successful','definition n=2k gives n^2=2(2k^2)'),
('pa_sum_induction','conj_sum_first_n','induction','successful','base case and successor step establish universal formula'),
('pa_bounded_naive','conj_bounded_converges','example_generalization','failed','typical examples do not prove universal convergence'),
('pa_degree_invariant','conj_degree_sequence_iso','invariant_classification','failed','degree sequence distinguishes some graphs but does not classify all graphs'),
('pa_cycle_rank','conj_cycle_rank_nonnegative','structural_graph_argument','successful','component structure explains nonnegative cycle rank'),
('pa_logistic_interval','conj_logistic_bounded','inequality_argument','successful_under_assumptions','parameter and initial-condition restrictions are essential');

INSERT INTO discovery_method VALUES
('method_examples','Examples','build intuition and reveal candidate patterns','typical examples may mislead','include boundary and pathological cases'),
('method_counterexample_search','Counterexample search','test universal claims and refine assumptions','search space may be incomplete','document domain and search limits'),
('method_analogy','Analogy','transfer ideas across structures','surface similarity may hide structural mismatch','state which structure is preserved'),
('method_abstraction','Abstraction','identify shared structure across cases','may strip away essential features','audit what is preserved and omitted'),
('method_computation','Computation','generate cases and discover patterns','finite evidence can be mistaken for proof','separate evidence status from proof status'),
('method_formalization','Formalization','make statements and proofs machine-checkable','formal statement may not match intention','audit definitions and theorem statement');
