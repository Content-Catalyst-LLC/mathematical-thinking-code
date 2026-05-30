PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS representation_warning;
DROP TABLE IF EXISTS modular_example;
DROP TABLE IF EXISTS linear_algebra_example;
DROP TABLE IF EXISTS probability_case;
DROP TABLE IF EXISTS type_example;
DROP TABLE IF EXISTS automata_case;
DROP TABLE IF EXISTS proof_obligation;
DROP TABLE IF EXISTS complexity_case;
DROP TABLE IF EXISTS algorithm_specification;
DROP TABLE IF EXISTS computational_concept;

CREATE TABLE computational_concept (
  concept_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  concept_type TEXT NOT NULL,
  mathematical_structure TEXT NOT NULL,
  computer_science_use TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE algorithm_specification (
  algorithm_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  input_domain TEXT NOT NULL,
  output_specification TEXT NOT NULL,
  invariant_note TEXT NOT NULL,
  complexity_note TEXT NOT NULL,
  correctness_note TEXT NOT NULL,
  responsible_use_note TEXT NOT NULL
);

CREATE TABLE complexity_case (
  case_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  growth_class TEXT NOT NULL,
  example_algorithm TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE proof_obligation (
  proof_id TEXT PRIMARY KEY,
  algorithm_id TEXT NOT NULL,
  proof_type TEXT NOT NULL,
  claim TEXT NOT NULL,
  method TEXT NOT NULL,
  risk_note TEXT NOT NULL,
  FOREIGN KEY (algorithm_id) REFERENCES algorithm_specification(algorithm_id)
);

CREATE TABLE automata_case (
  automaton_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  states TEXT NOT NULL,
  alphabet TEXT NOT NULL,
  start_state TEXT NOT NULL,
  accepting_states TEXT NOT NULL,
  transition_summary TEXT NOT NULL,
  recognized_language TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE type_example (
  type_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  type_kind TEXT NOT NULL,
  mathematical_analogy TEXT NOT NULL,
  programming_use TEXT NOT NULL,
  invariant_note TEXT NOT NULL
);

CREATE TABLE probability_case (
  case_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  sample_space TEXT NOT NULL,
  event TEXT NOT NULL,
  assumption_note TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE linear_algebra_example (
  example_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  object_type TEXT NOT NULL,
  formula TEXT NOT NULL,
  computer_science_use TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE modular_example (
  example_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  modulus TEXT NOT NULL,
  operation TEXT NOT NULL,
  computer_science_use TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE representation_warning (
  warning_id TEXT PRIMARY KEY,
  concept_id TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL,
  FOREIGN KEY (concept_id) REFERENCES computational_concept(concept_id)
);

INSERT INTO computational_concept VALUES
('concept_algorithm','Algorithm','procedure','finite rule-governed transformation','sorting, searching, routing, parsing, inference','algorithmic behavior should be specified and proven under assumptions'),
('concept_graph','Graph','discrete structure','vertices and edges','networks, dependencies, state spaces, knowledge graphs','edge meaning and direction must be explicit'),
('concept_type','Type','classification','set, product, sum, or function-like constraint','program safety, abstraction, interface design','types constrain valid operations and document structure'),
('concept_automaton','Finite automaton','formal machine','states, alphabet, transition function, start, accepting states','regular languages, parsing, protocols, state machines','formal machines recognize structured symbol sequences'),
('concept_complexity','Complexity','growth analysis','asymptotic function comparison','scalability and feasibility analysis','growth rate explains why some procedures become infeasible'),
('concept_probability','Probability','uncertainty model','sample space, event, measure','randomized algorithms, ML, cryptography, reliability','probability requires valid assumptions about the sample space'),
('concept_linear_algebra','Linear algebra','vector-space structure','vectors, matrices, transformations','ML, graphics, retrieval, numerical computing','vector representation is useful but not identical to meaning'),
('concept_modular','Modular arithmetic','number theory','congruence classes and remainders','hashing, cryptography, cyclic buffers, checksums','finite arithmetic supports secure and efficient computation');

INSERT INTO algorithm_specification VALUES
('alg_insertion_sort','Insertion sort','finite list of comparable values','sorted permutation of input','processed prefix is sorted','O(n^2) worst case, O(1) auxiliary space','prove by loop invariant','correct sorting does not validate downstream ranking criteria'),
('alg_binary_search','Binary search','sorted finite sequence and target','found index or missing result','target, if present, remains inside search interval','O(log n)','prove by interval-shrinking invariant','requires sorted input and clear equality semantics'),
('alg_bfs','Breadth-first search','graph and start vertex','reachable vertices and unweighted distances','queue processes vertices by nondecreasing distance','O(V+E)','prove by layers from source','edge meaning determines interpretation of reachability'),
('alg_merge_sort','Merge sort','finite list of comparable values','sorted permutation of input','merged list preserves sorted order and all elements','O(n log n)','prove by induction over list length','efficient ordering does not justify what is being ordered'),
('alg_dijkstra','Dijkstra shortest path','weighted graph with nonnegative weights and source','minimum known distances from source','settled vertices have final shortest distances','implementation dependent; often O((V+E) log V)','prove using nonnegative weights and greedy invariant','weight semantics determine what shortest means'),
('alg_dp_knapsack','Dynamic programming knapsack','finite items, values, weights, capacity','maximum value under capacity','table entry represents best value for prefix and capacity','O(nW) pseudo-polynomial','prove by induction over table states','objective function may omit fairness, risk, or public consequences');

INSERT INTO complexity_case VALUES
('cx_constant','Constant','O(1)','array index access','resource use does not grow with input size under model assumptions'),
('cx_log','Logarithmic','O(log n)','binary search','halving structure produces slow growth'),
('cx_linear','Linear','O(n)','single scan','work grows proportionally to input length'),
('cx_nlogn','Near-linear','O(n log n)','merge sort','divide-and-conquer sorting growth'),
('cx_quadratic','Quadratic','O(n^2)','insertion sort worst case','nested comparisons produce square growth'),
('cx_exponential','Exponential','O(2^n)','subset search','possibility spaces can become infeasible quickly');

INSERT INTO proof_obligation VALUES
('proof_sort_perm','alg_insertion_sort','loop invariant','output is sorted and contains same multiset as input','prove initialization, preservation, termination','tests on examples do not prove all cases'),
('proof_binary_interval','alg_binary_search','invariant','target remains in active interval if present','prove interval shrinks while preserving possibility','requires sorted input'),
('proof_bfs_distance','alg_bfs','induction on distance','BFS discovers shortest unweighted distances','prove by graph layers','edge weights invalidate unweighted-distance meaning'),
('proof_merge_sort','alg_merge_sort','structural induction','merge sort returns sorted permutation','induct on list length and prove merge correctness','comparison relation must be well-defined'),
('proof_dijkstra','alg_dijkstra','greedy invariant','settled distances are final shortest distances','use nonnegative weight condition','negative weights break guarantee');

INSERT INTO automata_case VALUES
('dfa_even_ones','Even number of ones','even odd','0 1','even','even','0 preserves parity; 1 toggles parity','binary strings with even number of 1 symbols','finite-state memory tracks parity'),
('dfa_ends_ab','Strings ending in ab','start seen_a seen_ab','a b','start','seen_ab','track suffix progress toward ab','strings over {a,b} ending in ab','state tracks relevant suffix history');

INSERT INTO type_example VALUES
('type_bool','Bool','primitive','two-element set','conditions and predicates','value is true or false'),
('type_pair','Pair','product','cartesian product','combine fields','contains both components'),
('type_result','Result','sum','disjoint union','success or error','exactly one variant is present'),
('type_tree','Tree','recursive','initial algebra / recursive structure','syntax, hierarchy, search','subtrees are also trees'),
('type_function','Function','mapping','domain to codomain','input-output transformation','valid input type maps to output type');

INSERT INTO probability_case VALUES
('prob_hash_collision','Hash bucket collision','keys assigned to buckets','two keys share bucket','uniform hashing is an idealization','probabilistic assumptions affect collision analysis'),
('prob_randomized_algo','Randomized algorithm success','random choices during procedure','algorithm succeeds within bound','random source must match model','expected behavior is not a deterministic guarantee'),
('prob_model_score','Model score','possible labels or outcomes','predicted class','calibration and data distribution matter','score is not truth without validation');

INSERT INTO linear_algebra_example VALUES
('la_vector','Feature vector','vector','x in R^n','data representation and embeddings','vector encodes selected features, not full meaning'),
('la_transform','Linear transform','matrix','y = A x','graphics, ML layers, numerical computing','matrix operation transforms representation'),
('la_adjacency','Adjacency matrix','matrix','A_ij = 1 if edge i->j exists','graph representation and spectral methods','matrix encodes graph structure'),
('la_dot','Dot product similarity','operation','x dot y','retrieval and ranking','similarity metric depends on representation and normalization');

INSERT INTO modular_example VALUES
('mod_clock','Clock arithmetic','12','addition modulo 12','cyclic indexing','values wrap around finite cycle'),
('mod_hash','Hash bucket','10','hash(key) mod m','hash table bucket selection','modulus maps large key space into finite buckets'),
('mod_checksum','Checksum residue','97','sum mod 97','error detection scaffold','residue supports simple consistency checks'),
('mod_crypto','Cryptographic residue','prime','modular exponentiation','public-key cryptography scaffold','security depends on deeper number-theoretic assumptions');

INSERT INTO representation_warning VALUES
('warn_spec','concept_algorithm','An algorithm can be correct relative to a harmful or incomplete specification.','Audit objectives, constraints, and consequences.'),
('warn_graph_edge','concept_graph','Graph edges can imply unsupported association, causation, suspicion, or influence.','Track edge meaning, evidence, provenance, and uncertainty.'),
('warn_type_boundary','concept_type','Types and categories can simplify or erase boundary cases.','Document category boundaries and failure cases.'),
('warn_complexity','concept_complexity','Small examples can hide explosive growth and exclusion at scale.','Audit complexity and scalability assumptions.'),
('warn_probability','concept_probability','Probabilistic outputs can be misread as truth or certainty.','Document calibration, uncertainty, and validation limits.'),
('warn_embedding','concept_linear_algebra','Vector similarity can be mistaken for semantic or moral similarity.','Validate representation, metric, and downstream use.'),
('warn_crypto','concept_modular','Correct modular arithmetic does not guarantee secure implementation.','Use expert cryptographic review and established protocols.');
