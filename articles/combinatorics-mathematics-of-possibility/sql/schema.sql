PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS possibility_warning;
DROP TABLE IF EXISTS generating_function_example;
DROP TABLE IF EXISTS probability_case;
DROP TABLE IF EXISTS graph_count_case;
DROP TABLE IF EXISTS counting_method;
DROP TABLE IF EXISTS combinatorial_problem;

CREATE TABLE combinatorial_problem (
  problem_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  object_count INTEGER NOT NULL,
  selected_count TEXT,
  order_matters INTEGER NOT NULL,
  repetition_allowed INTEGER NOT NULL,
  constraint_note TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE counting_method (
  method_id TEXT PRIMARY KEY,
  problem_id TEXT NOT NULL,
  method_name TEXT NOT NULL,
  formula TEXT NOT NULL,
  double_counting_risk TEXT NOT NULL,
  validation_note TEXT NOT NULL,
  FOREIGN KEY (problem_id) REFERENCES combinatorial_problem(problem_id)
);

CREATE TABLE graph_count_case (
  case_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  n INTEGER NOT NULL,
  graph_type TEXT NOT NULL,
  formula TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE probability_case (
  case_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  total_outcomes INTEGER NOT NULL,
  favorable_outcomes INTEGER NOT NULL,
  equally_likely INTEGER NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE generating_function_example (
  gf_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  series_form TEXT NOT NULL,
  coefficient_meaning TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE possibility_warning (
  warning_id TEXT PRIMARY KEY,
  problem_id TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL,
  FOREIGN KEY (problem_id) REFERENCES combinatorial_problem(problem_id)
);

INSERT INTO combinatorial_problem VALUES
('prob_committee','Committee selection',10,'3',0,0,'choose 3 people from 10','membership matters; order does not'),
('prob_ranked_finalists','Ranked finalists',10,'3',1,0,'choose and rank 3 people from 10','position matters'),
('prob_binary_string_8','Binary strings length 8',8,'8',1,1,'two symbols at each of 8 positions','multiplication principle'),
('prob_password_6','Password over 36 symbols length 6',36,'6',1,1,'36 choices per position','large search space from repeated choices'),
('prob_no_repeat_code','No-repeat code length 4 from 10 symbols',10,'4',1,0,'symbols cannot repeat','ordered selection without repetition'),
('prob_graph_simple_6','Simple labeled graphs on 6 vertices',6,NULL,0,0,'choose subset of possible edges','each edge is present or absent'),
('prob_multiples_2_or_3','Multiples of 2 or 3 through 100',100,NULL,0,0,'overlapping divisibility categories','inclusion-exclusion required'),
('prob_fibonacci_tilings','Fibonacci tilings length 12',12,NULL,1,1,'tiles of length 1 or 2','recursive construction'),
('prob_integer_partitions','Partitions of integer 12',12,NULL,0,1,'write integer as unordered positive sum','partition counting'),
('prob_feature_selection','Feature subset selection from 20 features',20,NULL,0,0,'choose any subset of features','2^n search space');

INSERT INTO counting_method VALUES
('method_committee','prob_committee','combination','C(n,k)','low if order ignored correctly','validate that membership is all that matters'),
('method_ranked','prob_ranked_finalists','permutation','P(n,k)=n!/(n-k)!','low if ranks are distinct','validate that order/position matters'),
('method_binary','prob_binary_string_8','multiplication_principle','2^n','low if choices independent by position','validate alphabet and length'),
('method_password','prob_password_6','multiplication_principle','36^6','low if repetition allowed','validate symbol set and repetition rule'),
('method_no_repeat','prob_no_repeat_code','permutation','P(10,4)','low if symbols cannot repeat','validate no repeated symbols'),
('method_graph','prob_graph_simple_6','edge_subset_count','2^C(n,2)','low for labeled simple graphs only','validate labeled vertices no loops no multiedges'),
('method_inclusion','prob_multiples_2_or_3','inclusion_exclusion','floor(n/2)+floor(n/3)-floor(n/6)','high if overlap not subtracted','validate overlap multiples of lcm'),
('method_recurrence','prob_fibonacci_tilings','recurrence','a_n=a_(n-1)+a_(n-2)','low if cases are disjoint','validate base cases and exhaustive first-tile casework'),
('method_partition','prob_integer_partitions','dynamic_programming','partition recurrence','medium if order counted accidentally','validate unordered positive sums'),
('method_feature','prob_feature_selection','power_set','2^n','medium if constraints or dependencies omitted','validate feature eligibility and interactions');

INSERT INTO graph_count_case VALUES
('graph_simple_3','Simple labeled graphs n=3',3,'simple_labeled','2^C(n,2)','each possible undirected edge is present or absent'),
('graph_simple_4','Simple labeled graphs n=4',4,'simple_labeled','2^C(n,2)','labeled simple graph count'),
('graph_simple_5','Simple labeled graphs n=5',5,'simple_labeled','2^C(n,2)','labeled simple graph count'),
('graph_simple_6','Simple labeled graphs n=6',6,'simple_labeled','2^C(n,2)','labeled simple graph count'),
('tree_labeled_4','Labeled trees n=4',4,'labeled_tree','n^(n-2)','Cayley formula for labeled trees'),
('tree_labeled_5','Labeled trees n=5',5,'labeled_tree','n^(n-2)','Cayley formula for labeled trees'),
('tree_labeled_6','Labeled trees n=6',6,'labeled_tree','n^(n-2)','Cayley formula for labeled trees');

INSERT INTO probability_case VALUES
('prob_die_even','Fair die even outcome',6,3,1,'probability from favorable outcomes over equally likely sample space'),
('prob_two_dice_sum_7','Two dice sum 7',36,6,1,'ordered dice pairs are equally likely'),
('prob_cards_5_hand','Five-card poker hands',2598960,4,1,'royal flush count over five-card hands'),
('prob_bad_sum_assumption','Two dice sum categories',11,1,0,'sums are not equally likely; outcome space must be defined as ordered pairs');

INSERT INTO generating_function_example VALUES
('gf_subsets','Subset generating function','(1+x)^n','coefficient of x^k counts k-element subsets','binomial theorem as counting structure'),
('gf_unlimited_parts','Unlimited identical parts','1/(1-x)','coefficient counts one way to choose any nonnegative quantity','basic ordinary generating factor'),
('gf_fibonacci','Fibonacci recurrence','1/(1-x-x^2)','coefficients satisfy Fibonacci recurrence','recurrence encoded algebraically'),
('gf_even_parts','Even counts','1/(1-x^2)','coefficient records even-numbered quantities','constraints encoded through exponents');

INSERT INTO possibility_warning VALUES
('warn_order','prob_committee','Order may be accidentally counted even when only membership matters.','State whether arrangements or selections are being counted.'),
('warn_repetition','prob_password_6','Repetition rule strongly changes the size of the space.','Document whether symbols may repeat.'),
('warn_overlap','prob_multiples_2_or_3','Overlapping categories cause double-counting.','Use inclusion-exclusion or disjoint case partitions.'),
('warn_graph_assumption','prob_graph_simple_6','Graph count changes if vertices are unlabeled, loops allowed, or multiple edges allowed.','State graph convention before counting.'),
('warn_search_explosion','prob_feature_selection','Power-set growth can make exhaustive search infeasible and hide omitted constraints.','Audit constraints, dependencies, and objective function.'),
('warn_probability','prob_binary_string_8','Counting outcomes is not enough if outcomes are not equally likely.','Separate count from probability model.'),
('warn_scenario_boundary','prob_feature_selection','A possibility space can omit important real-world cases.','Review boundaries with domain stakeholders.');
