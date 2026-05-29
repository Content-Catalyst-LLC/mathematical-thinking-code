PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS mapping_warning;
DROP TABLE IF EXISTS model_structure;
DROP TABLE IF EXISTS function_record;
DROP TABLE IF EXISTS relation_record;
DROP TABLE IF EXISTS mathematical_set;

CREATE TABLE mathematical_set (
  set_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  elements TEXT NOT NULL,
  definition_rule TEXT NOT NULL,
  domain_note TEXT NOT NULL
);

CREATE TABLE relation_record (
  pair_id INTEGER PRIMARY KEY AUTOINCREMENT,
  relation_id TEXT NOT NULL,
  source TEXT NOT NULL,
  target TEXT NOT NULL,
  relation_type TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE function_record (
  function_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  domain_set_id TEXT NOT NULL,
  codomain_set_id TEXT NOT NULL,
  mapping_rule TEXT NOT NULL,
  domain_elements TEXT NOT NULL,
  codomain_elements TEXT NOT NULL,
  mapping_pairs TEXT NOT NULL,
  validation_note TEXT NOT NULL,
  FOREIGN KEY (domain_set_id) REFERENCES mathematical_set(set_id),
  FOREIGN KEY (codomain_set_id) REFERENCES mathematical_set(set_id)
);

CREATE TABLE mapping_warning (
  warning_id TEXT PRIMARY KEY,
  structure_type TEXT NOT NULL,
  structure_id TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE model_structure (
  model_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  object_set TEXT NOT NULL,
  relation TEXT NOT NULL,
  functions TEXT NOT NULL,
  assumption_note TEXT NOT NULL
);

INSERT INTO mathematical_set VALUES
('set_A','Small natural domain','1 2 3 4','x is an integer from 1 through 4','finite domain used for examples'),
('set_B','Even outputs','2 4 6 8','x is an even integer from 2 through 8','finite codomain for doubling function'),
('set_C','Residue domain','1 2 3 4 5 6 7 8','x is an integer from 1 through 8','finite domain for modular equivalence'),
('set_D','Divisibility domain','1 2 3 4 6 12','positive divisors of 12','finite partial-order domain'),
('set_E','Classification labels','low medium high','ordered qualitative labels','example of applied categories');

INSERT INTO relation_record (relation_id, source, target, relation_type, interpretation) VALUES
('rel_double','1','2','function_graph','doubling maps input to output'),
('rel_double','2','4','function_graph','doubling maps input to output'),
('rel_double','3','6','function_graph','doubling maps input to output'),
('rel_double','4','8','function_graph','doubling maps input to output'),
('rel_mod2','1','1','equivalence','same parity'),
('rel_mod2','1','3','equivalence','same parity'),
('rel_mod2','2','2','equivalence','same parity'),
('rel_mod2','2','4','equivalence','same parity'),
('rel_mod2','3','1','equivalence','same parity'),
('rel_mod2','3','3','equivalence','same parity'),
('rel_mod2','4','2','equivalence','same parity'),
('rel_mod2','4','4','equivalence','same parity'),
('rel_divides','1','1','partial_order','divisibility'),
('rel_divides','1','2','partial_order','divisibility'),
('rel_divides','1','3','partial_order','divisibility'),
('rel_divides','1','4','partial_order','divisibility'),
('rel_divides','1','6','partial_order','divisibility'),
('rel_divides','1','12','partial_order','divisibility'),
('rel_divides','2','2','partial_order','divisibility'),
('rel_divides','2','4','partial_order','divisibility'),
('rel_divides','2','6','partial_order','divisibility'),
('rel_divides','2','12','partial_order','divisibility'),
('rel_divides','3','3','partial_order','divisibility'),
('rel_divides','3','6','partial_order','divisibility'),
('rel_divides','3','12','partial_order','divisibility'),
('rel_divides','4','4','partial_order','divisibility'),
('rel_divides','4','12','partial_order','divisibility'),
('rel_divides','6','6','partial_order','divisibility'),
('rel_divides','6','12','partial_order','divisibility'),
('rel_divides','12','12','partial_order','divisibility'),
('rel_not_function','1','2','multivalued_relation','one input maps to multiple outputs'),
('rel_not_function','1','3','multivalued_relation','one input maps to multiple outputs'),
('rel_not_function','2','4','multivalued_relation','one input maps to one output');

INSERT INTO function_record VALUES
('fn_double','Doubling','set_A','set_B','f(x)=2x','1 2 3 4','2 4 6 8','1:2 2:4 3:6 4:8','valid total function from set_A to set_B'),
('fn_square_restricted','Restricted square','set_A','set_D','f(x)=x^2 when output is in divisor domain','1 2 3 4','1 2 3 4 6 12','1:1 2:4 3:9 4:16','invalid because outputs 9 and 16 are outside codomain'),
('fn_label','Score label','set_A','set_E','score category mapping','1 2 3 4','low medium high','1:low 2:medium 3:high 4:high','valid but categorical meaning requires context'),
('fn_partial_inverse','Partial inverse','set_B','set_A','f(y)=y/2','2 4 6 8','1 2 3 4','2:1 4:2 6:3','invalid total function because input 8 is missing');

INSERT INTO mapping_warning VALUES
('warn_boundary','set','set_E','Qualitative categories may hide contested thresholds.','Document category definitions and affected interpretation.'),
('warn_codomain','function','fn_square_restricted','Outputs outside codomain show the mapping is not valid as specified.','Revise codomain or restrict the domain.'),
('warn_missing_input','function','fn_partial_inverse','A missing input means this is not a total function on the stated domain.','Add mapping for every domain element or label as partial.'),
('warn_category_score','function','fn_label','Score labels may appear objective while encoding design choices.','State how labels are defined and validate consequences.'),
('warn_multivalued','relation','rel_not_function','A relation with multiple outputs for one input is not a function.','Represent as relation or restrict outputs.');

INSERT INTO model_structure VALUES
('model_network','Toy network','nodes A B C D','edge relation','centrality scoring function','layout may not represent metric distance'),
('model_prediction','Toy prediction system','records 1 2 3 4','similarity relation','feature-to-label function','training domain must match application domain'),
('model_order','Divisibility order','1 2 3 4 6 12','divides relation','rank/depth function','partial order does not compare every pair'),
('model_equivalence','Residue classifier','integers 1 through 8','same remainder modulo 3','residue mapping','equivalence classes depend on chosen modulus');
