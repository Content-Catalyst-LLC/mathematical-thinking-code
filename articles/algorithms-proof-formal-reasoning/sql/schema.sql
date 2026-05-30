PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS formal_reasoning_warning;
DROP TABLE IF EXISTS evidence_type;
DROP TABLE IF EXISTS graph_algorithm_assumption;
DROP TABLE IF EXISTS complexity_case;
DROP TABLE IF EXISTS termination_argument;
DROP TABLE IF EXISTS invariant_case;
DROP TABLE IF EXISTS proof_obligation;
DROP TABLE IF EXISTS algorithm_specification;

CREATE TABLE algorithm_specification (
  algorithm_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  input_domain TEXT NOT NULL,
  precondition TEXT NOT NULL,
  postcondition TEXT NOT NULL,
  termination_measure TEXT NOT NULL,
  complexity_note TEXT NOT NULL,
  responsible_use_note TEXT NOT NULL
);

CREATE TABLE proof_obligation (
  proof_id TEXT PRIMARY KEY,
  algorithm_id TEXT NOT NULL,
  proof_type TEXT NOT NULL,
  claim TEXT NOT NULL,
  invariant_or_measure TEXT NOT NULL,
  proof_status TEXT NOT NULL,
  risk_note TEXT NOT NULL,
  FOREIGN KEY (algorithm_id) REFERENCES algorithm_specification(algorithm_id)
);

CREATE TABLE invariant_case (
  invariant_id TEXT PRIMARY KEY,
  algorithm_id TEXT NOT NULL,
  location TEXT NOT NULL,
  invariant TEXT NOT NULL,
  initialization_note TEXT NOT NULL,
  preservation_note TEXT NOT NULL,
  termination_use TEXT NOT NULL,
  FOREIGN KEY (algorithm_id) REFERENCES algorithm_specification(algorithm_id)
);

CREATE TABLE termination_argument (
  termination_id TEXT PRIMARY KEY,
  algorithm_id TEXT NOT NULL,
  decreasing_measure TEXT NOT NULL,
  lower_bound TEXT NOT NULL,
  termination_claim TEXT NOT NULL,
  failure_mode TEXT NOT NULL,
  FOREIGN KEY (algorithm_id) REFERENCES algorithm_specification(algorithm_id)
);

CREATE TABLE complexity_case (
  case_id TEXT PRIMARY KEY,
  algorithm_id TEXT NOT NULL,
  growth_class TEXT NOT NULL,
  dominant_source TEXT NOT NULL,
  interpretation TEXT NOT NULL,
  FOREIGN KEY (algorithm_id) REFERENCES algorithm_specification(algorithm_id)
);

CREATE TABLE graph_algorithm_assumption (
  graph_case_id TEXT PRIMARY KEY,
  algorithm_id TEXT NOT NULL,
  graph_type TEXT NOT NULL,
  required_assumption TEXT NOT NULL,
  output_guarantee TEXT NOT NULL,
  interpretive_warning TEXT NOT NULL,
  FOREIGN KEY (algorithm_id) REFERENCES algorithm_specification(algorithm_id)
);

CREATE TABLE evidence_type (
  evidence_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  strength TEXT NOT NULL,
  limitation TEXT NOT NULL,
  best_use TEXT NOT NULL
);

CREATE TABLE formal_reasoning_warning (
  warning_id TEXT PRIMARY KEY,
  algorithm_id TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL,
  FOREIGN KEY (algorithm_id) REFERENCES algorithm_specification(algorithm_id)
);

INSERT INTO algorithm_specification VALUES
('alg_insertion_sort','Insertion sort','finite list of comparable integers','input list is finite and comparison is total','output is sorted and preserves the input multiset','number of unprocessed elements decreases','O(n^2) worst-case time and O(1) auxiliary space','formal sorting correctness does not validate downstream ranking criteria'),
('alg_binary_search','Binary search','sorted finite sequence and target value','sequence is sorted in nondecreasing order','returns a valid target index or a missing result','search interval length decreases','O(log n) time and O(1) auxiliary space','requires explicit equality and ordering semantics'),
('alg_merge_sort','Merge sort','finite list of comparable values','input list is finite and comparison is total','output is sorted and preserves the input multiset','subproblem list length decreases','O(n log n) time and O(n) auxiliary space','efficient ordering does not justify what is being ordered'),
('alg_bfs','Breadth-first search','unweighted graph and start vertex','start vertex exists in graph and adjacency representation is valid','all reachable vertices are discovered with shortest edge-count distances','number of undiscovered reachable vertices decreases','O(V+E)','edge meaning determines whether reachability has real-world significance'),
('alg_dijkstra','Dijkstra shortest path','weighted graph and source vertex','all edge weights are nonnegative','distances from source are shortest under the given weight semantics','number of unsettled vertices decreases','often O((V+E) log V) with a priority queue','shortest means only what the weight definition says it means'),
('alg_heap_insert','Heap insert','heap and new priority item','input structure satisfies heap invariant','output structure satisfies heap invariant and contains new item','distance from inserted item to root decreases during bubble-up','O(log n)','priority order may encode values or harms outside the formal heap property');

INSERT INTO proof_obligation VALUES
('proof_insert_sorted','alg_insertion_sort','loop invariant','processed prefix is sorted and contains exactly the processed input elements','sorted prefix grows by one element per outer loop','demonstration scaffold','tests can miss multiset preservation bugs'),
('proof_binary_interval','alg_binary_search','loop invariant','if target exists then it remains inside the active interval','active interval length decreases','demonstration scaffold','unsorted input invalidates proof'),
('proof_merge_induction','alg_merge_sort','structural induction','merge sort returns sorted permutation of input','subproblem size decreases recursively','demonstration scaffold','comparison relation must be consistent'),
('proof_bfs_layers','alg_bfs','induction on distance','BFS discovers vertices in nondecreasing graph distance','queue stores frontier by distance layer','demonstration scaffold','weighted edges require a different shortest-path algorithm'),
('proof_dijkstra_greedy','alg_dijkstra','greedy invariant','settled vertices have final shortest-path distances','minimum unsettled tentative distance is final under nonnegative weights','demonstration scaffold','negative weights break guarantee'),
('proof_heap_bubble','alg_heap_insert','data-structure invariant','bubble-up restores heap property','violation can move only toward root','demonstration scaffold','array bounds and comparator semantics must also be valid');

INSERT INTO invariant_case VALUES
('inv_insert_prefix','alg_insertion_sort','outer loop','prefix before index i is sorted and contains original prefix elements','single-element prefix is sorted','inner loop inserts key into sorted prefix','when i reaches length full list is sorted'),
('inv_binary_interval','alg_binary_search','while loop','target if present is within low/high search interval','full sequence is active interval','comparison discards impossible half','empty interval implies target absent'),
('inv_bfs_queue','alg_bfs','queue processing','discovered vertices have assigned shortest known unweighted distance','start vertex has distance zero','neighbors are discovered one layer beyond current vertex','all reachable vertices have distances'),
('inv_dijkstra_settled','alg_dijkstra','settling step','settled vertices have final shortest distances','source distance is zero','nonnegative weights prevent later shorter route to settled vertex','all settled vertices have final distances'),
('inv_heap_property','alg_heap_insert','bubble-up loop','all heap violations if any are along inserted node path','new item appended at leaf','swapping with parent moves violation upward','root reached or parent order satisfied');

INSERT INTO termination_argument VALUES
('term_insert','alg_insertion_sort','unprocessed suffix length','0','outer loop eventually processes all indices','index update bug can prevent progress'),
('term_binary','alg_binary_search','active interval length','0','each iteration removes at least one candidate','midpoint or bound update bug can keep interval unchanged'),
('term_merge','alg_merge_sort','subproblem list length','1','recursive calls eventually reach singleton or empty lists','bad split can repeat same-size subproblem'),
('term_bfs','alg_bfs','undiscovered reachable vertices','0','visited set prevents repeated infinite traversal','missing visited set can loop in cyclic graphs'),
('term_heap','alg_heap_insert','node depth from root','0','bubble-up eventually reaches root or valid parent','invalid parent indexing can break progress');

INSERT INTO complexity_case VALUES
('cx_insert','alg_insertion_sort','O(n^2)','nested shifting/comparison in worst case','quadratic growth can be acceptable for small data but costly at scale'),
('cx_binary','alg_binary_search','O(log n)','repeated halving','logarithmic search depends on sorted input'),
('cx_merge','alg_merge_sort','O(n log n)','divide-and-conquer levels with linear merge work','efficient comparison sorting at scale'),
('cx_bfs','alg_bfs','O(V+E)','visit each vertex and edge once','linear in graph representation size'),
('cx_dijkstra','alg_dijkstra','O((V+E) log V)','priority queue updates','implementation and graph density matter'),
('cx_heap','alg_heap_insert','O(log n)','height of heap','tree height controls insertion cost');

INSERT INTO graph_algorithm_assumption VALUES
('graph_bfs','alg_bfs','unweighted graph','edges have uniform traversal cost','shortest paths by edge count','edge count may not represent distance, time, risk, or harm'),
('graph_dijkstra','alg_dijkstra','weighted graph','all weights are nonnegative','minimum total weight path','weight meaning must be documented'),
('graph_dependency','alg_bfs','dependency graph','edge direction and meaning are explicit','reachable dependencies or dependents','reachability does not automatically imply causality or responsibility');

INSERT INTO evidence_type VALUES
('ev_unit_test','Unit test','checks selected examples','does not prove all cases','catch local defects and regressions'),
('ev_property_test','Property-based test','generates many cases from stated properties','depends on quality of property and generator','explore broader input space'),
('ev_proof','Proof','establishes general claim under assumptions','may prove wrong or incomplete specification','correctness and safety-critical reasoning'),
('ev_static_analysis','Static analysis','finds classes of defects before runtime','may be conservative or incomplete','bug detection and compliance checks'),
('ev_monitoring','Runtime monitoring','observes deployed behavior','detects after deployment','operational feedback and drift detection');

INSERT INTO formal_reasoning_warning VALUES
('warn_wrong_spec','alg_insertion_sort','An algorithm can be correct relative to a harmful or incomplete specification.','Audit objective, postcondition, and downstream use.'),
('warn_hidden_precondition','alg_binary_search','A hidden precondition can invalidate the proof in production.','Document and check preconditions explicitly.'),
('warn_edge_weight','alg_dijkstra','Shortest path depends entirely on edge-weight meaning.','Document whether weight means distance, time, cost, risk, or priority.'),
('warn_testing_only','alg_merge_sort','Passing tests may be mistaken for proof.','Distinguish test evidence from correctness argument.'),
('warn_formal_model','alg_bfs','A formally correct graph algorithm may be applied to a poorly modeled network.','Audit graph construction, edge semantics, and missing data.'),
('warn_priority_value','alg_heap_insert','Priority ordering can encode questionable values while preserving heap correctness.','Review priority criteria and affected stakeholders.');
