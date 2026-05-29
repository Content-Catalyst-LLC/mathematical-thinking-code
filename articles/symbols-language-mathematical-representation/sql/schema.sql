PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS representation_warning;
DROP TABLE IF EXISTS translation;
DROP TABLE IF EXISTS notation_symbol;
DROP TABLE IF EXISTS representation;
DROP TABLE IF EXISTS mathematical_object;

CREATE TABLE mathematical_object (
  object_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  object_type TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE representation (
  representation_id TEXT PRIMARY KEY,
  object_id TEXT NOT NULL,
  representation_type TEXT NOT NULL,
  notation_or_format TEXT NOT NULL,
  preserved_structure TEXT NOT NULL,
  omitted_detail TEXT NOT NULL,
  FOREIGN KEY (object_id) REFERENCES mathematical_object(object_id)
);

CREATE TABLE translation (
  translation_id TEXT PRIMARY KEY,
  source_representation_id TEXT NOT NULL,
  target_representation_id TEXT NOT NULL,
  translation_rule TEXT NOT NULL,
  validity_condition TEXT NOT NULL,
  FOREIGN KEY (source_representation_id) REFERENCES representation(representation_id),
  FOREIGN KEY (target_representation_id) REFERENCES representation(representation_id)
);

CREATE TABLE notation_symbol (
  symbol_id TEXT PRIMARY KEY,
  symbol TEXT NOT NULL,
  typical_meaning TEXT NOT NULL,
  mathematical_role TEXT NOT NULL,
  ambiguity_warning TEXT NOT NULL
);

CREATE TABLE representation_warning (
  warning_id TEXT PRIMARY KEY,
  representation_id TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL,
  FOREIGN KEY (representation_id) REFERENCES representation(representation_id)
);

INSERT INTO mathematical_object VALUES
('obj_rational_half','Rational one half','number','A rational value represented by different fractions decimals and percentages.'),
('obj_quadratic_function','Quadratic function','function','The mapping x -> x^2 over a specified numerical domain.'),
('obj_cycle_graph','Cycle graph C4','graph','A four-vertex cycle represented as an edge list matrix and drawing.'),
('obj_even_square_theorem','Even-square theorem','theorem','If n is even then n squared is even.'),
('obj_linear_system','Linear system','system','A set of linear equations represented as Ax=b.'),
('obj_continuity_definition','Continuity definition','definition','Epsilon-delta representation of continuity at a point.');

INSERT INTO representation VALUES
('rep_fraction_half','obj_rational_half','fraction','1/2','ratio of integers','decimal expansion and percentage framing'),
('rep_decimal_half','obj_rational_half','decimal','0.5','base-ten magnitude','rational numerator-denominator structure'),
('rep_percent_half','obj_rational_half','percentage','50%','proportion out of one hundred','exact fractional form'),
('rep_formula_quadratic','obj_quadratic_function','formula','f(x)=x^2','input-output symbolic rule','domain codomain and numerical implementation'),
('rep_table_quadratic','obj_quadratic_function','table','sampled x and f(x) values','finite behavior on selected inputs','full infinite-domain behavior'),
('rep_graph_edges_c4','obj_cycle_graph','edge_list','a-b b-c c-d d-a','adjacency relation','visual geometry and matrix algebra'),
('rep_matrix_c4','obj_cycle_graph','adjacency_matrix','4x4 binary matrix','adjacency relation and algebraic operations','edge labels as named pairs'),
('rep_prose_theorem','obj_even_square_theorem','prose','If n is even then n^2 is even','human-readable statement','formal proof dependencies'),
('rep_formal_theorem','obj_even_square_theorem','formal_logic','forall n even(n) -> even(n^2)','quantifier and implication structure','motivation and explanatory prose'),
('rep_matrix_linear_system','obj_linear_system','matrix_equation','Ax=b','linear operator structure','original verbal equation context'),
('rep_epsilon_delta','obj_continuity_definition','formal_definition','forall epsilon exists delta','quantifier dependency','intuitive visual continuity');

INSERT INTO translation VALUES
('tr_fraction_decimal','rep_fraction_half','rep_decimal_half','divide numerator by denominator','denominator nonzero and decimal representation accepted'),
('tr_decimal_percent','rep_decimal_half','rep_percent_half','multiply by 100 and append percent symbol','base-ten decimal interpretation'),
('tr_formula_table','rep_formula_quadratic','rep_table_quadratic','evaluate formula on finite sample domain','sample domain explicitly recorded'),
('tr_edges_matrix','rep_graph_edges_c4','rep_matrix_c4','map vertices to indices and mark adjacency entries','vertex ordering fixed and graph treated as undirected'),
('tr_prose_formal','rep_prose_theorem','rep_formal_theorem','translate theorem into predicate logic','domain and predicate definitions specified'),
('tr_system_matrix','rep_matrix_linear_system','rep_matrix_linear_system','identity representation for matrix equation','coefficient matrix and vector dimensions compatible');

INSERT INTO notation_symbol VALUES
('sym_forall','∀','for all','universal quantification','domain and scope must be specified'),
('sym_exists','∃','there exists','existence claim','witness and domain must be specified'),
('sym_in','∈','is an element of','set membership','set must be defined'),
('sym_implies','⇒','implies','conditional inference','converse is not equivalent'),
('sym_equiv','⇔','if and only if','two-way implication','requires proof in both directions'),
('sym_sum','Σ','summation','indexed accumulation','bounds and convergence may matter'),
('sym_arrow','→','maps to','function or morphism','domain codomain and rule may be hidden');

INSERT INTO representation_warning VALUES
('warn_formula_domain','rep_formula_quadratic','Formula alone may hide domain and codomain.','Record f:X->Y and define X and Y.'),
('warn_table_finite','rep_table_quadratic','Finite table does not establish full functional equality.','Use proof or symbolic reasoning for universal equality.'),
('warn_graph_layout','rep_graph_edges_c4','Graph representation preserves adjacency but not visual distance.','Document edge semantics and representation type.'),
('warn_inverse_symbol','rep_matrix_linear_system','Inverse notation may imply invertibility that may not hold.','Check rank determinant or solvability conditions.'),
('warn_formal_statement','rep_formal_theorem','Formal statement may fail to capture intended theorem.','Audit definitions and domain before formalization.'),
('warn_metric_reality','rep_epsilon_delta','Formal precision can obscure intuitive interpretation for learners.','Pair formal definition with visual and verbal explanation.');
