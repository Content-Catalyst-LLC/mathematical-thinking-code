PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS notation_warning;
DROP TABLE IF EXISTS transformation_rule;
DROP TABLE IF EXISTS expression_example;
DROP TABLE IF EXISTS symbol_record;
DROP TABLE IF EXISTS notation_milestone;
DROP TABLE IF EXISTS notation_style;

CREATE TABLE notation_style (
  style_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  dominant_medium TEXT NOT NULL,
  mathematical_effect TEXT NOT NULL,
  limitation_note TEXT NOT NULL,
  historical_note TEXT NOT NULL
);

CREATE TABLE notation_milestone (
  milestone_id TEXT PRIMARY KEY,
  period TEXT NOT NULL,
  tradition_or_figure TEXT NOT NULL,
  style_id TEXT NOT NULL,
  contribution TEXT NOT NULL,
  interpretation_note TEXT NOT NULL,
  FOREIGN KEY (style_id) REFERENCES notation_style(style_id)
);

CREATE TABLE symbol_record (
  symbol_id TEXT PRIMARY KEY,
  symbol_text TEXT NOT NULL,
  meaning_context TEXT NOT NULL,
  mathematical_role TEXT NOT NULL,
  ambiguity_note TEXT NOT NULL,
  responsible_pedagogy_note TEXT NOT NULL
);

CREATE TABLE expression_example (
  expression_id TEXT PRIMARY KEY,
  expression_text TEXT NOT NULL,
  historical_layer TEXT NOT NULL,
  structure_type TEXT NOT NULL,
  tree_description TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE transformation_rule (
  rule_id TEXT PRIMARY KEY,
  rule_name TEXT NOT NULL,
  input_pattern TEXT NOT NULL,
  output_pattern TEXT NOT NULL,
  mathematical_condition TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE notation_warning (
  warning_id TEXT PRIMARY KEY,
  topic TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO notation_style VALUES
('style_procedural','Procedural','worked method or rule','transmits operations through examples','general symbolic structure may remain implicit','important in ancient mathematical problem traditions'),
('style_rhetorical','Rhetorical','ordinary language','describes relationships verbally','long expressions can obscure repeated form','common in early algebraic texts and equation classifications'),
('style_syncopated','Syncopated','abbreviations and partial symbols','compresses recurring algebraic objects','not yet a full symbolic system','associated with Diophantine and cossic abbreviation traditions'),
('style_symbolic','Symbolic','systematic algebraic signs','supports manipulation, parameterization, and generality','requires learned conventions and hidden domain assumptions','strongly associated with Viète, Descartes, and early modern algebra'),
('style_structural','Structural','operations, sets, mappings, laws','represents algebraic systems rather than only numbers','abstraction can obscure examples and access','central to nineteenth- and twentieth-century abstract algebra'),
('style_logical','Logical and set-theoretic','quantifiers, predicates, membership, implication','formalizes claims, membership, relations, and inference','symbol density can hide meaning for learners','important in algebra of logic, set theory, and foundations'),
('style_computational','Computational','expression trees, parser syntax, formal languages','turns symbols into data structures for computation','software syntax and mathematical notation can diverge','central to computer algebra, programming languages, and proof assistants');

INSERT INTO notation_milestone VALUES
('ms_babylonian','ancient','Babylonian problem texts','style_procedural','worked methods for algebraic problem types','algebraic structure can exist before symbolic notation'),
('ms_egyptian','ancient','Egyptian mathematical papyri','style_procedural','rules for arithmetic, measurement, area, and volume','procedural notation supports reliable calculation'),
('ms_diophantus','late antique','Diophantus','style_syncopated','abbreviations for unknowns and powers','recurring algebraic objects become compactly writable'),
('ms_indian','classical to early modern','Indian algebraic traditions','style_syncopated','terms and abbreviations for unknowns, powers, zero, negative quantities, and indeterminate problems','notation develops through verse, rule, computation, and commentary'),
('ms_islamic','medieval','Islamic algebra','style_rhetorical','classification and solution of equation types','algebra organized through verbal procedures and geometric justification'),
('ms_cossic','medieval to Renaissance','European cossic algebra','style_syncopated','abbreviations for the unknown and its powers','bridge from rhetorical expression to symbolic algebra'),
('ms_viete','early modern','François Viète','style_symbolic','systematic letters for unknowns and given quantities','parameterized generality becomes central'),
('ms_descartes','seventeenth century','René Descartes','style_symbolic','modern-style unknowns, exponent notation, and equations for curves','algebra becomes a language for geometry'),
('ms_leibniz','seventeenth century','Gottfried Wilhelm Leibniz','style_symbolic','calculus notation for differentials and integrals','algebraic symbolism extends to variation and accumulation'),
('ms_euler','eighteenth century','Leonhard Euler','style_symbolic','standardization of function and analysis notation','notation becomes a stable language of analysis'),
('ms_boole','nineteenth century','George Boole and algebra of logic','style_logical','symbolic algebraic treatment of logical classes and propositions','algebraic notation expands into logic'),
('ms_matrices','nineteenth century','Matrix and vector notation','style_structural','compact representation of systems and transformations','large systems become manipulable symbolic objects'),
('ms_abstract','nineteenth to twentieth century','Abstract algebra','style_structural','notation for groups, rings, fields, homomorphisms, and quotients','operations and structures become primary objects'),
('ms_cas','contemporary','Computer algebra systems','style_computational','symbolic expressions represented as parsable data structures','notation becomes computational infrastructure');

INSERT INTO symbol_record VALUES
('sym_x','x','unknown or variable','represents a quantity, input, or placeholder','can mean unknown, variable, coordinate, or generic element','state whether x is unknown, variable, parameter, coordinate, or element'),
('sym_a','a','coefficient or parameter','represents a given quantity or structural constant','can be constant, variable, element, or index depending on context','explain parameter role before manipulating formula'),
('sym_equal','=','equality relation','states sameness, equation, identity, or definition depending on use','confused with assignment in programming or step-by-step transformation','distinguish equation, identity, definition, and assignment'),
('sym_pow','^','power or exponent','represents repeated multiplication or generalized exponentiation','software syntax may differ; exponent laws depend on domain','state domain assumptions for exponent rules'),
('sym_function','f(x)','function application','represents output of a function at input x','students may treat f(x) as multiplication','teach function application separately from multiplication'),
('sym_map','f:A->B','mapping from domain to codomain','specifies valid input and output spaces','codomain and range are often confused','distinguish domain, codomain, image, and range'),
('sym_member','∈','set membership','states that an object belongs to a set','can be confused with subset relation','contrast element membership with subset inclusion'),
('sym_group','(G,*)','algebraic structure','set with operation under specified laws','operation symbol is abstract and may not be ordinary multiplication','connect abstract operation to concrete examples'),
('sym_matrix','Ax=b','linear system','compresses multiple linear equations','matrix dimensions and assumptions can be hidden','state dimensions and invertibility assumptions');

INSERT INTO expression_example VALUES
('expr_linear','a*x+b=c','symbolic algebra','linear equation','equality between addition and constant','parameterized linear form'),
('expr_quadratic','a*x^2+b*x+c=0','symbolic algebra','quadratic equation','sum of power, product, and constant terms','letters allow a family of equations'),
('expr_curve','y=x^2','analytic geometry','curve equation','equality between coordinate and power expression','algebraic equation represents geometric curve'),
('expr_function','f:A->B','function notation','mapping declaration','function symbol with domain and codomain','dependence and transformation become explicit'),
('expr_group_law','(a*b)*c=a*(b*c)','abstract algebra','associative law','equality between two differently grouped products','operation law independent of number interpretation'),
('expr_factor','x^2+2*x+1=(x+1)^2','computer algebra','polynomial identity','expanded and factored forms connected by equality','symbolic transformation can be checked computationally');

INSERT INTO transformation_rule VALUES
('rule_comm_add','commutativity of addition','a+b','b+a','addition is commutative','valid in many familiar algebraic systems but not every possible operation'),
('rule_assoc_add','associativity of addition','(a+b)+c','a+(b+c)','addition is associative','grouping can be changed when law holds'),
('rule_distribute','distributive law','a*(b+c)','a*b+a*c','multiplication distributes over addition','central to polynomial expansion'),
('rule_factor_square','perfect-square factoring','x^2+2*x+1','(x+1)^2','polynomial identity over valid coefficient domain','connects expanded and factored symbolic forms'),
('rule_solve_linear','linear equation solve','a*x+b=c','x=(c-b)/a','a is nonzero and operations are valid','symbolic solution exposes hidden nonzero assumption'),
('rule_matrix_system','linear system compression','multiple linear equations','A*x=b','coefficient matrix and vectors have compatible dimensions','matrix notation compresses system structure');

INSERT INTO notation_warning VALUES
('warn_presentism','history','Modern notation can make earlier mathematics appear less sophisticated than it was.','Separate reconstructed algebraic structure from original notation and reasoning.'),
('warn_eurocentrism','canon','Notation history can be reduced to European symbolic algebra.','Include Indian, Chinese, Islamic, Mesopotamian, Egyptian, Greek, and other traditions.'),
('warn_symbol_opacity','pedagogy','Compact notation can make meaning opaque for learners.','Teach notation as meaningful structure, not decoration.'),
('warn_domain_assumption','mathematical validity','Symbolic transformations can hide domain restrictions and nonzero assumptions.','State domains, operations, and valid transformation conditions.'),
('warn_programming_confusion','computing','Mathematical equality and programming assignment are easily confused.','Distinguish equality, identity, definition, assignment, and comparison operators.'),
('warn_computer_algebra','computer algebra','Symbolic simplification can be treated as interpretation or proof without assumption checks.','Audit assumptions, domains, branch cuts, and expression equivalence conditions.');
