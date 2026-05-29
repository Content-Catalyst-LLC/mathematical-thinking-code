PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS structure_warning;
DROP TABLE IF EXISTS proof_pattern;
DROP TABLE IF EXISTS algorithm_audit;
DROP TABLE IF EXISTS relation_edge;
DROP TABLE IF EXISTS discrete_object;

CREATE TABLE discrete_object (
  object_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  object_type TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE relation_edge (
  edge_id TEXT PRIMARY KEY,
  source_id TEXT NOT NULL,
  target_id TEXT NOT NULL,
  graph_id TEXT NOT NULL,
  directed INTEGER NOT NULL,
  relation_type TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE algorithm_audit (
  algorithm_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  input_structure TEXT NOT NULL,
  output_structure TEXT NOT NULL,
  invariant_note TEXT NOT NULL,
  complexity_note TEXT NOT NULL
);

CREATE TABLE proof_pattern (
  proof_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  discrete_use TEXT NOT NULL,
  required_structure TEXT NOT NULL,
  risk_note TEXT NOT NULL
);

CREATE TABLE structure_warning (
  warning_id TEXT PRIMARY KEY,
  structure_type TEXT NOT NULL,
  structure_id TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO discrete_object VALUES
('obj_A','Vertex A','vertex','A graph vertex in the main connected component.'),
('obj_B','Vertex B','vertex','A graph vertex connected to A and D.'),
('obj_C','Vertex C','vertex','A graph vertex connected to A.'),
('obj_D','Vertex D','vertex','A graph vertex connected to B.'),
('obj_E','Vertex E','vertex','An isolated graph vertex.'),
('prop_P','Proposition P','proposition','A Boolean proposition used in truth-table examples.'),
('prop_Q','Proposition Q','proposition','A Boolean proposition used in truth-table examples.'),
('state_0','State 0','state','Initial finite-state example.'),
('state_1','State 1','state','Intermediate finite-state example.'),
('state_2','State 2','state','Terminal finite-state example.');

INSERT INTO relation_edge VALUES
('edge_AB','A','B','graph_main',0,'adjacency','A is adjacent to B'),
('edge_AC','A','C','graph_main',0,'adjacency','A is adjacent to C'),
('edge_BD','B','D','graph_main',0,'adjacency','B is adjacent to D'),
('edge_cycle_12','1','2','graph_cycle',1,'transition','directed cycle transition'),
('edge_cycle_23','2','3','graph_cycle',1,'transition','directed cycle transition'),
('edge_cycle_31','3','1','graph_cycle',1,'transition','directed cycle transition'),
('edge_dep_logic','definitions','lemma','proof_dependency',1,'dependency','definitions support lemma'),
('edge_dep_lemma','lemma','theorem','proof_dependency',1,'dependency','lemma supports theorem');

INSERT INTO algorithm_audit VALUES
('alg_bfs','Breadth-first search','graph and start vertex','reachable component','visited set only grows and contains reached vertices','O(V+E)'),
('alg_inclusion_exclusion','Inclusion-exclusion','finite overlapping sets','count of union','overlap is subtracted once','constant for two sets; grows by subset count'),
('alg_mod_residue','Residue computation','integer and modulus','remainder class','output is in range 0 to modulus-1','O(1) arithmetic model'),
('alg_rec_fib_iter','Iterative Fibonacci','natural number','F_n','current and previous track adjacent Fibonacci terms','O(n) time O(1) memory'),
('alg_tree_size','Tree size','rooted tree','node count','each node counted once','O(n)');

INSERT INTO proof_pattern VALUES
('proof_direct','Direct proof','unfold definitions and derive conclusion','premises and definitions','may skip hidden assumptions'),
('proof_cases','Proof by cases','exhaust finite possibilities','complete case partition','may omit edge cases'),
('proof_contrapositive','Contrapositive','prove implication through reversed negation','logical equivalence','requires correct negation'),
('proof_induction','Induction','prove statement over natural numbers','base case and inductive step','weak induction step invalidates proof'),
('proof_bijection','Bijection','show equal finite counts','one-to-one and onto pairing','must prove both directions'),
('proof_invariant','Invariant proof','show property preserved by algorithm or transition','state transition relation','must prove initialization and preservation');

INSERT INTO structure_warning VALUES
('warn_graph_layout','graph','graph_main','Graph drawing layout may imply distances that are not part of the graph.','State whether layout is aesthetic or metric.'),
('warn_category_boundary','category','label_system','Discrete categories may erase boundary cases and context.','Document category rules and review edge cases.'),
('warn_boolean_binary','boolean_rule','case_table','Boolean rules may force binary decisions on ambiguous contexts.','Add review pathways and contextual safeguards.'),
('warn_algorithm_assumption','algorithm','alg_bfs','Correct algorithmic output may still reflect incomplete input structure.','Validate input data and relation definitions.'),
('warn_finite_examples','proof','proof_induction','Finite examples do not prove universal discrete claims.','Use induction, exhaustive proof, or formal verification.'),
('warn_double_counting','counting','inclusion_2_or_3','Overlapping cases can be counted more than once.','Use inclusion-exclusion or disjoint case design.');
