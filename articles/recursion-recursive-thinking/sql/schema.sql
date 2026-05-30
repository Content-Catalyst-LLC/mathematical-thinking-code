PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS recursion_warning;
DROP TABLE IF EXISTS recursive_model_audit;
DROP TABLE IF EXISTS recursive_algorithm;
DROP TABLE IF EXISTS grammar_rule;
DROP TABLE IF EXISTS recurrence_record;
DROP TABLE IF EXISTS recursive_definition;

CREATE TABLE recursive_definition (
  definition_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  base_case TEXT NOT NULL,
  recursive_rule TEXT NOT NULL,
  termination_measure TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE recurrence_record (
  recurrence_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  initial_values TEXT NOT NULL,
  recurrence_rule TEXT NOT NULL,
  closed_form_note TEXT NOT NULL,
  proof_status TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE grammar_rule (
  rule_id TEXT PRIMARY KEY,
  nonterminal TEXT NOT NULL,
  production TEXT NOT NULL,
  rule_type TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE recursive_algorithm (
  algorithm_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  base_case TEXT NOT NULL,
  recursive_reduction TEXT NOT NULL,
  combination_rule TEXT NOT NULL,
  complexity_note TEXT NOT NULL,
  correctness_note TEXT NOT NULL
);

CREATE TABLE recursive_model_audit (
  model_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  initial_state TEXT NOT NULL,
  update_rule TEXT NOT NULL,
  stopping_condition TEXT NOT NULL,
  risk_note TEXT NOT NULL
);

CREATE TABLE recursion_warning (
  warning_id TEXT PRIMARY KEY,
  structure_type TEXT NOT NULL,
  structure_id TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO recursive_definition VALUES
('def_factorial','Factorial','0! = 1','n! = n*(n-1)!','n decreases by 1','product sequence generated from base case'),
('def_fibonacci','Fibonacci','F_0=0; F_1=1','F_n=F_(n-1)+F_(n-2)','n decreases to 0 or 1','two-branch recurrence over previous terms'),
('def_tree_size','Tree size','empty tree or leaf','size(node)=1+sum(size(child))','tree height or node count decreases','structural recursion over nested tree'),
('def_merge_sort','Merge sort','list length <= 1','sort(left); sort(right); merge','list length halves','divide-and-conquer recursion'),
('def_binary_search','Binary search','empty interval or target found','search relevant half','interval length decreases','recursive search over ordered domain'),
('def_expression','Expression grammar','number','expression = number | expression + expression | expression * expression','parse tree depth decreases during evaluation','recursive formal grammar'),
('def_state_update','Recursive state update','initial state x_0','x_(t+1)=F(x_t)','time horizon or convergence criterion','recursive model evolution');

INSERT INTO recurrence_record VALUES
('rec_factorial','Factorial','1','a_n=n*a_(n-1)','n!','definition_or_induction','recursive product sequence'),
('rec_fibonacci','Fibonacci','0 1','F_n=F_(n-1)+F_(n-2)','Binet formula available but recurrence is structural','definition_or_induction','two previous terms define next term'),
('rec_arithmetic','Arithmetic sequence','3','a_n=a_(n-1)+5','a_n=3+5n','proved_by_induction','constant additive recursion'),
('rec_geometric','Geometric sequence','2','a_n=3*a_(n-1)','a_n=2*3^n','proved_by_induction','multiplicative recursion'),
('rec_merge_sort','Merge sort cost','1','T(n)=2T(n/2)+n','O(n log n)','master_theorem_or_recursion_tree','divide-and-conquer cost recurrence'),
('rec_binary_search','Binary search cost','1','T(n)=T(n/2)+1','O(log n)','recurrence_solution','recursive halving');

INSERT INTO grammar_rule VALUES
('g_expr_num','E','n','base','number is a base expression'),
('g_expr_add','E','(E+E)','recursive','sum contains recursive subexpressions'),
('g_expr_mul','E','(E*E)','recursive','product contains recursive subexpressions'),
('g_list_empty','L','empty','base','empty list is a base list'),
('g_list_cons','L','item:L','recursive','list can be item followed by smaller list'),
('g_tree_leaf','T','leaf','base','leaf is a base tree'),
('g_tree_node','T','node(T,T)','recursive','node contains recursive subtrees');

INSERT INTO recursive_algorithm VALUES
('alg_factorial','Recursive factorial','n=0','n -> n-1','multiply by n','O(n) time stack depth O(n)','prove by induction on n'),
('alg_merge_sort','Merge sort','list length <= 1','split list into halves','merge sorted halves','O(n log n)','prove sortedness and permutation preservation'),
('alg_binary_search','Binary search','empty interval or match','choose relevant half','return found/missing result','O(log n)','requires sorted input invariant'),
('alg_tree_size','Tree size','empty/leaf','recurse over children','sum child sizes plus root','O(nodes)','prove by structural induction'),
('alg_dfs','Depth-first search','no unvisited neighbors','visit unvisited neighbor recursively','accumulate visited set','O(V+E)','requires visited-set invariant for cycles'),
('alg_parser','Recursive descent parser','terminal token','parse subexpressions','assemble parse tree','depends on grammar','requires grammar and token invariants');

INSERT INTO recursive_model_audit VALUES
('model_decay','Exponential decay','100','x_next=0.85*x','time horizon or small threshold','rounding and model-form assumptions'),
('model_feedback','Feedback score','1','x_next=1.2*x+0.5','time horizon or cap','reinforcing loop can amplify values'),
('model_classifier','Recursive classifier review','unlabeled','label_next=review(label_previous,data)','stable label or human review','early errors can propagate'),
('model_language','Autoregressive text generation','prompt','token_next=F(previous_tokens)','length limit or stop token','ungrounded continuation can compound plausible errors'),
('model_iteration','Fixed-point iteration','0.25','x_next=cos(x)','difference below tolerance','convergence depends on update rule and starting point');

INSERT INTO recursion_warning VALUES
('warn_missing_base','definition','def_factorial','A recursive definition without a base case can fail to terminate.','State a base case explicitly.'),
('warn_no_progress','definition','def_binary_search','A recursive step that does not reduce problem size may loop indefinitely.','Track a decreasing size measure.'),
('warn_repeated_subproblem','algorithm','alg_factorial','Some recursive algorithms repeat subproblems unnecessarily.','Use memoization or tabulation when overlap exists.'),
('warn_cycle_graph','algorithm','alg_dfs','Recursive graph traversal can revisit cycles indefinitely.','Maintain a visited set.'),
('warn_error_amplification','model','model_feedback','Recursive updates can amplify error, bias, or instability.','Validate against external data and monitor feedback.'),
('warn_stopping_condition','model','model_language','Recursive generation can continue beyond meaningful grounding.','Use stopping conditions, verification, and review.'),
('warn_wrong_base','proof','proof_induction','An incorrect base case invalidates an induction proof.','Check base cases and boundary values.');
