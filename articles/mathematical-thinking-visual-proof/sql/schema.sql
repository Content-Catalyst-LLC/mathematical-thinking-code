PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS proof_without_words_example;
DROP TABLE IF EXISTS visual_workflow;
DROP TABLE IF EXISTS accessibility_review;
DROP TABLE IF EXISTS visual_risk;
DROP TABLE IF EXISTS diagram_relation;
DROP TABLE IF EXISTS visual_proof_record;

CREATE TABLE visual_proof_record (
  record_id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  domain TEXT NOT NULL,
  visual_role TEXT NOT NULL,
  visible_structure TEXT NOT NULL,
  proof_status TEXT NOT NULL,
  generalization_question TEXT NOT NULL
);

CREATE TABLE diagram_relation (
  relation_id TEXT PRIMARY KEY,
  record_id TEXT NOT NULL,
  visual_feature TEXT NOT NULL,
  mathematical_relation TEXT NOT NULL,
  proof_requirement TEXT NOT NULL
);

CREATE TABLE visual_risk (
  risk_id TEXT PRIMARY KEY,
  risk_name TEXT NOT NULL,
  problem TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE accessibility_review (
  review_id TEXT PRIMARY KEY,
  record_id TEXT NOT NULL,
  visual_dependency TEXT NOT NULL,
  alternative_description TEXT NOT NULL,
  accessibility_note TEXT NOT NULL
);

CREATE TABLE visual_workflow (
  workflow_id TEXT PRIMARY KEY,
  stage TEXT NOT NULL,
  question TEXT NOT NULL,
  failure_mode TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE proof_without_words_example (
  example_id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  visual_device TEXT NOT NULL,
  mathematical_idea TEXT NOT NULL,
  missing_words_prompt TEXT NOT NULL
);

INSERT INTO visual_proof_record VALUES
('vis_odd_square_layers','Sum of odd numbers as square layers','combinatorics','diagrammatic_argument','successive odd layers build a square','informally_justified','Does the layer pattern hold for arbitrary n?'),
('vis_binomial_square','Area model for binomial square','algebra','diagrammatic_argument','large square decomposes into two squares and two rectangles','informally_justified','Are side lengths arbitrary quantities under the model?'),
('vis_dynamic_invariant','Dynamic geometry invariant','geometry','heuristic','angle appears constant under dragging','needs_generalization','What construction forces the angle relation?'),
('vis_graph_connectivity','Graph drawing of connected network','graph_theory','evidence','vertices appear clustered and connected','needs_generalization','Is the property about the abstract graph or this drawing?'),
('vis_calculus_secants','Derivative as limiting secant slope','calculus','heuristic','secant lines approach tangent line','needs_formal_limit','Can the visual motion be expressed as a limit?'),
('vis_category_square','Commutative square diagram','category_diagram','formal_diagrammatic_proof','two paths of arrows have equal composition','formally_expressible','Which compositions are equal by diagram commutativity?');

INSERT INTO diagram_relation VALUES
('rel_odd_layer','vis_odd_square_layers','new L-shaped layer around prior square','nth odd number adds the next square layer','show layer size is 2n-1 and total square is n^2'),
('rel_binomial_parts','vis_binomial_square','one large square split by side lengths a and b','(a+b)^2 equals a^2 plus 2ab plus b^2','show area preservation and identify all regions'),
('rel_dynamic_angle','vis_dynamic_invariant','angle measure remains stable while dragging','invariant angle relation follows from construction','derive angle equality from geometry theorems'),
('rel_graph_connected','vis_graph_connectivity','single visible cluster of vertices','graph may be connected','show path exists between every pair of vertices'),
('rel_secant_tangent','vis_calculus_secants','secant line rotates toward tangent','difference quotient approaches derivative','state and verify limit definition'),
('rel_commutative_square','vis_category_square','two arrow paths from same source to same target','two morphism compositions are equal','state equality of compositions explicitly');

INSERT INTO visual_risk VALUES
('risk_special_case','Special case','diagram represents only one configuration','vary the case and identify invariant relations'),
('risk_scale_illusion','Scale illusion','graph or figure distorts relation through scale','check axes, units, and numerical values'),
('risk_hidden_assumption','Hidden assumption','argument depends on unstated condition','list hypotheses and exceptional cases'),
('risk_accidental_alignment','Accidental alignment','points or lines appear related because of drawing choices','derive relation from construction'),
('risk_finite_pattern','Finite pattern overreach','early examples suggest false generalization','search counterexamples and prove general structure'),
('risk_accessibility_gap','Accessibility gap','visual argument is not available in nonvisual form','provide verbal, symbolic, and structural description'),
('risk_decorative_diagram','Decorative diagram','image appears mathematical but carries no argument','explain what relation the diagram establishes');

INSERT INTO accessibility_review VALUES
('acc_odd_layers','vis_odd_square_layers','dot or square layer arrangement','describe each new odd layer as the additional cells needed to grow an (n-1) by (n-1) square into an n by n square','do not rely on color alone to distinguish layers'),
('acc_binomial','vis_binomial_square','area regions labeled by side lengths','describe the square as four rectangular regions with areas a^2, ab, ab, and b^2','labels and text explanation should accompany the diagram'),
('acc_dynamic','vis_dynamic_invariant','movement and persistent angle measure','state which point moves, which construction remains fixed, and which measured relation appears invariant','animation needs textual description and static key frames'),
('acc_graph','vis_graph_connectivity','spatial layout of vertices and edges','list vertices, edges, and paths that establish connectivity','do not use page proximity as the only explanation'),
('acc_calculus','vis_calculus_secants','secant lines visually approaching tangent','describe the difference quotient and limiting process in words and formula form','graph must include axes, labels, and limit explanation'),
('acc_category','vis_category_square','arrow diagram and path equality','spell out the two compositions and the equation they satisfy','diagram should be accompanied by the symbolic equality');

INSERT INTO visual_workflow VALUES
('wf_see','See','What pattern, relation, or structure is visible?','noticing only a special case','identify what appears invariant under variation'),
('wf_abstract','Abstract','What is essential and what is accidental?','confusing drawing features with theorem conditions','separate representation from mathematical structure'),
('wf_prove','Prove','Why does the relation hold generally?','visual plausibility without justification','translate visual relation into verbal, symbolic, or formal proof'),
('wf_interpret','Interpret','What does the proof reveal and how should it be communicated?','diagram treated as decoration rather than reasoning','explain meaning, scope, limits, and accessibility requirements');

INSERT INTO proof_without_words_example VALUES
('pww_odd_sums','Odd sums form squares','successive square layers','sum of first n odd numbers equals n squared','Explain why each added layer has odd size and why the total shape is a square.'),
('pww_binomial_square','Square of a sum','area decomposition','binomial square identity','Explain why the two cross rectangles both have area ab.'),
('pww_binomial_symmetry','Choosing k or leaving n-k','complementary selection','binomial coefficient symmetry','Explain why choosing included objects determines excluded objects.'),
('pww_pythagorean_dissection','Pythagorean dissection','area-preserving rearrangement','square on hypotenuse equals sum of squares on legs','Explain why the rearrangement preserves area and covers without overlap.');
