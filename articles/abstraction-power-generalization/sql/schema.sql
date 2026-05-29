PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS counterexample;
DROP TABLE IF EXISTS invariant;
DROP TABLE IF EXISTS mapping;
DROP TABLE IF EXISTS generalization;
DROP TABLE IF EXISTS abstraction;

CREATE TABLE abstraction (
  abstraction_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  source_context TEXT NOT NULL,
  preserved_structure TEXT NOT NULL,
  omitted_detail TEXT NOT NULL
);

CREATE TABLE generalization (
  generalization_id TEXT PRIMARY KEY,
  abstraction_id TEXT NOT NULL,
  claim TEXT NOT NULL,
  domain TEXT NOT NULL,
  required_assumptions TEXT NOT NULL,
  proof_status TEXT NOT NULL,
  FOREIGN KEY (abstraction_id) REFERENCES abstraction(abstraction_id)
);

CREATE TABLE mapping (
  mapping_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  source_structure TEXT NOT NULL,
  target_structure TEXT NOT NULL,
  preserved_relation TEXT NOT NULL,
  warning TEXT NOT NULL
);

CREATE TABLE invariant (
  invariant_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  object_class TEXT NOT NULL,
  transformation_class TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE counterexample (
  counterexample_id TEXT PRIMARY KEY,
  generalization_id TEXT NOT NULL,
  object_description TEXT NOT NULL,
  failure_mode TEXT NOT NULL,
  lesson TEXT NOT NULL,
  FOREIGN KEY (generalization_id) REFERENCES generalization(generalization_id)
);

INSERT INTO abstraction VALUES
('abs_number','Number as Cardinality','counting apples, stones, votes','cardinality','material identity and physical arrangement'),
('abs_graph','Graph as Relation','transport, proof, social, ecological, or software networks','entities and pairwise relations','spatial distance, weight, institutional meaning unless encoded'),
('abs_group','Group as Operation Structure','rotations, permutations, integer addition, modular arithmetic','closure associativity identity inverse','visual appearance and object substance'),
('abs_metric','Metric Space as Distance Structure','Euclidean geometry and generalized distance settings','distance relation satisfying metric axioms','coordinate representation and physical embedding'),
('abs_function','Function as Mapping','rules, formulas, algorithms, measurements','input-output assignment','mechanism or causal interpretation unless specified');

INSERT INTO generalization VALUES
('gen_sum_first_n','abs_number','1+2+...+n=n(n+1)/2','positive integers','n is a positive integer','proved by induction or pairing'),
('gen_commutative_addition','abs_group','a+b=b+a','ordinary number addition','operation is addition over a commutative numerical structure','proved in standard arithmetic systems'),
('gen_noncommutative_warning','abs_group','all meaningful operations commute','all algebraic operations','none sufficient because claim is false','refuted by counterexample'),
('gen_same_degree_isomorphism','abs_graph','graphs with same degree sequence are isomorphic','finite graphs','degree sequence alone is insufficient','refuted by counterexample'),
('gen_bounded_converges','abs_function','every bounded sequence converges','real sequences','boundedness alone is insufficient','refuted by counterexample');

INSERT INTO mapping VALUES
('map_fraction_normalization','Rational normalization','integer pairs','rational equivalence class','equality of rational value','requires nonzero denominator'),
('map_graph_relabeling','Graph relabeling','labeled graph','labeled graph','adjacency relation','does not preserve labels as meaningful names'),
('map_mod_double','Double map modulo n','Z/nZ','Z/nZ','addition','behavior depends on modulus and map definition'),
('map_metric_embedding','Distance-preserving embedding','metric space','metric space','distance','not every representation is isometric');

INSERT INTO invariant VALUES
('inv_degree_sequence','Degree Sequence','finite graph','vertex relabeling','sorted multiset of vertex degrees'),
('inv_connected_components','Connected Components','finite graph','graph isomorphism','number of connected components'),
('inv_normal_form','Normalized Rational Form','integer-pair fractions','rational equivalence','reduced numerator-denominator pair with positive denominator'),
('inv_cardinality','Cardinality','finite set','bijection','number of elements'),
('inv_parity','Parity','integer','addition of even increments','remainder modulo 2');

INSERT INTO counterexample VALUES
('ce_matrix_commute','gen_noncommutative_warning','2x2 matrices A and B where AB != BA','operation fails commutativity','operations require structure-specific laws'),
('ce_degree_sequence','gen_same_degree_isomorphism','two non-isomorphic finite graphs sharing a degree sequence','invariant is incomplete','some invariants distinguish but do not fully classify'),
('ce_bounded_sequence','gen_bounded_converges','sequence (-1)^n','bounded but not convergent','boundedness does not imply convergence'),
('ce_finite_sample','gen_sum_first_n','checking only the first 100 cases','finite confirmation is not universal proof','computation supports conjecture but proof establishes generality');
