PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS object_invariant;
DROP TABLE IF EXISTS analogy;
DROP TABLE IF EXISTS counterexample;
DROP TABLE IF EXISTS invariant;
DROP TABLE IF EXISTS graph_edge;
DROP TABLE IF EXISTS mathematical_object;
DROP TABLE IF EXISTS pattern_sequence;

CREATE TABLE pattern_sequence (
  sequence_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  initial_terms TEXT NOT NULL,
  pattern_type TEXT NOT NULL,
  structural_interpretation TEXT NOT NULL,
  notes TEXT NOT NULL
);

CREATE TABLE mathematical_object (
  object_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  object_type TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE graph_edge (
  object_id TEXT NOT NULL,
  source TEXT NOT NULL,
  target TEXT NOT NULL,
  FOREIGN KEY (object_id) REFERENCES mathematical_object(object_id)
);

CREATE TABLE invariant (
  invariant_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  applies_to TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE object_invariant (
  object_id TEXT NOT NULL,
  invariant_id TEXT NOT NULL,
  evidence_note TEXT NOT NULL,
  PRIMARY KEY (object_id, invariant_id),
  FOREIGN KEY (object_id) REFERENCES mathematical_object(object_id),
  FOREIGN KEY (invariant_id) REFERENCES invariant(invariant_id)
);

CREATE TABLE analogy (
  analogy_id TEXT PRIMARY KEY,
  source_domain TEXT NOT NULL,
  target_domain TEXT NOT NULL,
  structural_correspondence TEXT NOT NULL,
  risk TEXT NOT NULL
);

CREATE TABLE counterexample (
  counterexample_id TEXT PRIMARY KEY,
  claim TEXT NOT NULL,
  object TEXT NOT NULL,
  lesson TEXT NOT NULL
);

INSERT INTO pattern_sequence VALUES
('seq_odd_sum_squares','Odd Sum Squares','1 4 9 16 25 36 49','figurate identity','sum of first n odd numbers equals n^2','Connects arithmetic pattern to geometric square growth'),
('seq_triangular','Triangular Numbers','1 3 6 10 15 21 28','figurate number','T_n=n(n+1)/2','Counts pairwise accumulation and triangular arrays'),
('seq_fibonacci','Fibonacci','0 1 1 2 3 5 8 13','linear recurrence','F_n=F_{n-1}+F_{n-2}','Pattern, recursion, growth, and modular cycles'),
('seq_powers_two','Powers of Two','1 2 4 8 16 32 64','exponential growth','a_n=2^n','Simple scaling pattern with multiplicative structure');

INSERT INTO mathematical_object VALUES
('g_cycle4','Cycle on Four Vertices','graph','A four-vertex cycle graph with all vertices degree 2.'),
('g_path4','Path on Four Vertices','graph','A four-vertex path graph with degree sequence 2,2,1,1.'),
('g_star4','Star on Four Leaves','graph','A central vertex connected to four leaf vertices.'),
('g_triangle','Triangle Graph','graph','A complete graph on three vertices.'),
('g_square_diagonal','Square with One Diagonal','graph','A four-vertex cycle with one added diagonal edge.');

INSERT INTO graph_edge VALUES
('g_cycle4','a','b'),('g_cycle4','b','c'),('g_cycle4','c','d'),('g_cycle4','d','a'),
('g_path4','a','b'),('g_path4','b','c'),('g_path4','c','d'),
('g_star4','o','a'),('g_star4','o','b'),('g_star4','o','c'),('g_star4','o','d'),
('g_triangle','a','b'),('g_triangle','b','c'),('g_triangle','c','a'),
('g_square_diagonal','a','b'),('g_square_diagonal','b','c'),('g_square_diagonal','c','d'),('g_square_diagonal','d','a'),('g_square_diagonal','a','c');

INSERT INTO invariant VALUES
('inv_degree_sequence','Degree Sequence','graph','Sorted multiset of vertex degrees.'),
('inv_edge_count','Edge Count','graph','Number of edges in a graph.'),
('inv_vertex_count','Vertex Count','graph','Number of vertices in a graph.'),
('inv_connected_components','Connected Components','graph','Number of connected components.'),
('inv_parity_pattern','Parity Pattern','sequence','Remainder pattern modulo 2.'),
('inv_periodicity','Observed Periodicity','sequence','Repeated residue or value pattern over an index range.');

INSERT INTO object_invariant VALUES
('g_cycle4','inv_degree_sequence','Degree sequence is 2,2,2,2.'),
('g_path4','inv_degree_sequence','Degree sequence is 2,2,1,1.'),
('g_star4','inv_degree_sequence','Degree sequence is 4,1,1,1,1.'),
('g_triangle','inv_degree_sequence','Degree sequence is 2,2,2.'),
('g_square_diagonal','inv_degree_sequence','Degree sequence is 3,3,2,2.');

INSERT INTO analogy VALUES
('ana_sequence_dynamics','sequences','dynamical systems','Iteration and state update under a recurrence rule','Discrete behavior may be overinterpreted as continuous dynamics'),
('ana_proof_graph','proofs','graphs','Proof dependencies can be represented as directed edges among claims','Edge labels may hide explanatory meaning'),
('ana_symmetry_group','geometry','algebra','Transformations preserving shape can form algebraic groups','Visual resemblance is weaker than structural equivalence'),
('ana_model_world','models','empirical systems','Selected relations in reality can be represented mathematically','The model may omit ethically or empirically important factors');

INSERT INTO counterexample VALUES
('ce_early_pattern','A pattern observed in early cases must continue.','Finite initial segment with later failure.','Observed pattern is not proof.'),
('ce_diagram_proof','A convincing diagram proves a geometric claim.','Diagram with hidden degeneracy.','Visual intuition needs formal justification.'),
('ce_same_degree_sequence','Graphs with the same degree sequence are isomorphic.','Non-isomorphic graphs sharing a degree sequence.','An invariant may distinguish some objects but not fully classify them.'),
('ce_computation_proof','Checking many cases proves a universal theorem.','Large finite sample without exhaustive argument.','Computation suggests conjecture but does not always establish proof.');
