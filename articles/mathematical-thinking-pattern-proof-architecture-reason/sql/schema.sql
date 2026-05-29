PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS theorem_dependency;
DROP TABLE IF EXISTS proof_step;
DROP TABLE IF EXISTS example;
DROP TABLE IF EXISTS theorem;
DROP TABLE IF EXISTS concept;

CREATE TABLE concept (
  concept_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  domain TEXT NOT NULL,
  definition TEXT NOT NULL
);

CREATE TABLE theorem (
  theorem_id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  domain TEXT NOT NULL,
  status TEXT NOT NULL,
  statement TEXT NOT NULL
);

CREATE TABLE proof_step (
  proof_step_id TEXT PRIMARY KEY,
  theorem_id TEXT NOT NULL,
  step_order INTEGER NOT NULL CHECK (step_order > 0),
  claim TEXT NOT NULL,
  justification TEXT NOT NULL,
  FOREIGN KEY (theorem_id) REFERENCES theorem(theorem_id)
);

CREATE TABLE example (
  example_id TEXT PRIMARY KEY,
  concept_id TEXT NOT NULL,
  label TEXT NOT NULL,
  description TEXT NOT NULL,
  is_counterexample INTEGER NOT NULL CHECK (is_counterexample IN (0, 1)),
  FOREIGN KEY (concept_id) REFERENCES concept(concept_id)
);

CREATE TABLE theorem_dependency (
  source_id TEXT NOT NULL,
  target_id TEXT NOT NULL,
  relation_type TEXT NOT NULL,
  weight INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (source_id, target_id, relation_type)
);

INSERT INTO concept VALUES
('concept_sequence','Sequence','discrete mathematics','An ordered collection indexed by natural numbers or another ordered set.'),
('concept_recurrence','Recurrence relation','discrete mathematics','A rule defining a term from previous terms.'),
('concept_induction','Mathematical induction','logic','A proof principle for statements over natural numbers.'),
('concept_proof_graph','Proof dependency graph','mathematical knowledge architecture','A directed graph representing dependencies among mathematical objects.'),
('concept_counterexample','Counterexample','mathematical reasoning','A case showing that a universal claim is false.');

INSERT INTO theorem VALUES
('thm_even_fibonacci_index','Even Fibonacci Index Criterion','number theory','proved','F_n is even if and only if n is divisible by 3.'),
('thm_induction_schema','Principle of Mathematical Induction','logic','axiom_schema','A property holding at 0 and preserved by successor holds for all natural numbers.'),
('thm_graph_acyclic_toposort','Topological Ordering of Finite DAGs','graph theory','proved','Every finite directed acyclic graph admits a topological ordering.'),
('thm_recurrence_matrix_form','Matrix Form of Linear Recurrences','linear algebra','proved','A finite-order linear recurrence can be represented by iterated matrix multiplication.');

INSERT INTO proof_step VALUES
('ps_even_fib_1','thm_even_fibonacci_index',1,'The parity sequence begins 0,1,1,0,1,1.','Compute the recurrence modulo 2.'),
('ps_even_fib_2','thm_even_fibonacci_index',2,'The parity pattern repeats with period 3.','The state pair returns to its initial pair after three updates.'),
('ps_even_fib_3','thm_even_fibonacci_index',3,'Even terms occur exactly at indices divisible by 3.','Zeros occur at the first position of each repeated parity cycle.'),
('ps_dag_1','thm_graph_acyclic_toposort',1,'Every finite DAG has a source vertex.','Otherwise finite backward traversal would force a cycle.'),
('ps_dag_2','thm_graph_acyclic_toposort',2,'Repeated source removal gives an ordering.','Acyclicity is preserved and finiteness ensures termination.');

INSERT INTO example VALUES
('ex_fibonacci','concept_recurrence','Fibonacci sequence','Second-order linear recurrence with seeds 0 and 1.',0),
('ex_empty_graph','concept_proof_graph','Empty graph','A degenerate proof graph with no nodes or dependencies.',0),
('ex_false_pattern','concept_counterexample','Finite-pattern failure','A pattern that holds in early terms but fails later.',1);

INSERT INTO theorem_dependency VALUES
('concept_sequence','concept_recurrence','defines_context',1),
('concept_recurrence','thm_recurrence_matrix_form','supports',2),
('concept_induction','thm_even_fibonacci_index','supports',2),
('concept_recurrence','thm_even_fibonacci_index','supports',2),
('concept_proof_graph','thm_graph_acyclic_toposort','motivates',1),
('thm_induction_schema','thm_even_fibonacci_index','supports',3);
