PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS counterexample_record;
DROP TABLE IF EXISTS invariant_record;
DROP TABLE IF EXISTS pattern_record;
DROP TABLE IF EXISTS pattern_domain;

CREATE TABLE pattern_domain (
  domain_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE pattern_record (
  pattern_id TEXT PRIMARY KEY,
  domain_id TEXT NOT NULL,
  name TEXT NOT NULL,
  pattern_type TEXT NOT NULL,
  mathematical_structure TEXT NOT NULL,
  evidence_type TEXT NOT NULL,
  proof_status TEXT NOT NULL,
  interpretive_warning TEXT NOT NULL,
  FOREIGN KEY (domain_id) REFERENCES pattern_domain(domain_id)
);

CREATE TABLE invariant_record (
  invariant_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  object_class TEXT NOT NULL,
  transformation_class TEXT NOT NULL,
  description TEXT NOT NULL,
  completeness_warning TEXT NOT NULL
);

CREATE TABLE counterexample_record (
  counterexample_id TEXT PRIMARY KEY,
  pattern_id TEXT NOT NULL,
  claim TEXT NOT NULL,
  object_description TEXT NOT NULL,
  lesson TEXT NOT NULL,
  FOREIGN KEY (pattern_id) REFERENCES pattern_record(pattern_id)
);

INSERT INTO pattern_domain VALUES
('dom_numerical','Numerical patterns','Sequences, divisibility, recurrence, modular behavior, and growth.'),
('dom_spatial','Spatial patterns','Geometry, symmetry, topology, tiling, and deformation.'),
('dom_structural','Structural patterns','Algebraic, relational, graph-theoretic, and categorical structures.'),
('dom_logical','Logical patterns','Proof forms, inference rules, formal systems, and dependency structures.'),
('dom_dynamic','Dynamic patterns','Recurrence, differential equations, feedback, iteration, and long-run behavior.'),
('dom_probabilistic','Probabilistic patterns','Distributions, stochastic processes, sampling, and uncertainty.');

INSERT INTO pattern_record VALUES
('pat_square_numbers','dom_numerical','Square number pattern','numerical','explicit formula and quadratic growth','computed examples plus known theorem','proved','finite sequence prefixes alone do not uniquely determine an infinite rule'),
('pat_cycle_graph','dom_structural','Cycle graph degree pattern','relational','regular graph with degree sequence 2 2 2 2','computed invariant','requires graph definition','degree sequence is not a complete isomorphism invariant'),
('pat_even_symmetry','dom_spatial','Even function symmetry','spatial/symbolic','invariance under x -> -x','symbolic verification','depends on function','visual symmetry needs algebraic verification'),
('pat_induction_schema','dom_logical','Mathematical induction','logical','base case plus successor preservation','formal proof rule','accepted proof principle','requires domain with appropriate successor structure'),
('pat_random_walk_variance','dom_probabilistic','Random walk spread','probabilistic','variance growth under independent increments','simulation plus theorem','proved under assumptions','independence and distribution assumptions matter'),
('pat_logistic_iteration','dom_dynamic','Logistic iteration','dynamic','nonlinear recurrence under parameter r','simulation and theory','parameter-dependent','finite simulation does not exhaust all behavior');

INSERT INTO invariant_record VALUES
('inv_degree_sequence','Degree Sequence','finite graph','vertex relabeling','sorted multiset of vertex degrees','not complete for graph isomorphism'),
('inv_connected_components','Connected Components','finite graph','graph isomorphism','number of connected components','coarse invariant'),
('inv_parity','Parity','integer sequence','addition of even increments','remainder class modulo 2','depends on chosen modulus'),
('inv_fixed_point','Fixed Point','dynamical system','iteration','state satisfying f(x)=x','existence and stability are distinct'),
('inv_expectation','Expected Value','random variable','distributional representation','probability-weighted mean','does not describe full distribution');

INSERT INTO counterexample_record VALUES
('ce_false_sequence','pat_square_numbers','finite sequence prefix determines a unique infinite rule','different formulas can match the same finite terms','finite pattern recognition is not proof'),
('ce_degree_sequence','pat_cycle_graph','same degree sequence guarantees graph isomorphism','non-isomorphic graphs can share a degree sequence','some invariants distinguish but do not fully classify'),
('ce_diagram','pat_even_symmetry','visual symmetry alone proves an equation','a misleading graphing window can hide asymmetry','visual evidence must be checked structurally'),
('ce_random_noise','pat_random_walk_variance','any visible trend is meaningful','random data can produce apparent streaks','probabilistic patterns require uncertainty analysis');
