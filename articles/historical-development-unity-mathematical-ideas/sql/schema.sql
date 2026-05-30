PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS responsible_generalization_warning;
DROP TABLE IF EXISTS proof_algorithm_model_connection;
DROP TABLE IF EXISTS transformation_invariant;
DROP TABLE IF EXISTS cross_field_connection;
DROP TABLE IF EXISTS mathematical_idea;
DROP TABLE IF EXISTS historical_layer;

CREATE TABLE historical_layer (
  layer_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  historical_period TEXT NOT NULL,
  dominant_unifying_idea TEXT NOT NULL,
  representation_forms TEXT NOT NULL,
  later_connection TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE mathematical_idea (
  idea_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  primary_field TEXT NOT NULL,
  historical_layer TEXT NOT NULL,
  unifying_role TEXT NOT NULL,
  representation TEXT NOT NULL,
  transformation TEXT NOT NULL,
  invariant_or_preserved_structure TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE cross_field_connection (
  connection_id TEXT PRIMARY KEY,
  source_idea TEXT NOT NULL,
  target_idea TEXT NOT NULL,
  connection_type TEXT NOT NULL,
  preserved_structure TEXT NOT NULL,
  example TEXT NOT NULL,
  caution_note TEXT NOT NULL
);

CREATE TABLE transformation_invariant (
  invariant_id TEXT PRIMARY KEY,
  field TEXT NOT NULL,
  transformation TEXT NOT NULL,
  invariant TEXT NOT NULL,
  meaning TEXT NOT NULL,
  example TEXT NOT NULL
);

CREATE TABLE proof_algorithm_model_connection (
  connection_id TEXT PRIMARY KEY,
  mathematical_form TEXT NOT NULL,
  core_question TEXT NOT NULL,
  evidence_standard TEXT NOT NULL,
  risk_if_confused TEXT NOT NULL,
  responsible_distinction TEXT NOT NULL
);

CREATE TABLE responsible_generalization_warning (
  warning_id TEXT PRIMARY KEY,
  topic TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO historical_layer VALUES
('layer_ancient','Ancient calculation and measurement','ancient','quantity, measurement, procedure, periodicity','numerals, tables, units, diagrams, worked examples','arithmetic, geometry, astronomy, algorithms, modeling','early unity came from repeated practical forms across counting, measuring, building, trading, and observing'),
('layer_greek_proof','Greek proof and geometry','classical antiquity','deductive necessity','definitions, postulates, diagrams, propositions, proofs','proof theory, formal verification, axiomatic systems','proof unified claims by making dependencies and assumptions explicit'),
('layer_algorithmic','Algorithmic and procedural traditions','ancient to medieval global traditions','procedure and repeatable transformation','tables, rules, commentaries, rod calculation, equation procedures','algorithms, computer science, symbolic computation','procedural unity should not be treated as inferior to proof-based unity'),
('layer_algebra','Algebraic symbolism and general form','medieval to early modern','unknowns, equations, symbolic generalization','rhetorical, syncopated, and symbolic algebra','abstract algebra, computer algebra, modeling, optimization','algebra unified problems by exposing common symbolic form'),
('layer_analytic_geometry','Analytic geometry','early modern','curve as equation','coordinates, equations, curves, systems','calculus, mathematical physics, graphics, data geometry','analytic geometry joined spatial and symbolic representation'),
('layer_calculus','Calculus','early modern to modern','change and accumulation','derivatives, integrals, limits, series, differential equations','physics, engineering, simulation, optimization, dynamical systems','calculus unified local change and global accumulation'),
('layer_rigor','Rigor and foundations of analysis','nineteenth century','quantified control, limit, continuity, infinity','epsilon-delta definitions, sets, functions, quantifiers','analysis, topology, measure theory, probability','rigor unified analysis by replacing intuition with explicit conditions'),
('layer_structure','Structural mathematics','nineteenth and twentieth centuries','objects through relations and operations','groups, rings, vector spaces, topological spaces, graphs, categories','abstract algebra, topology, category theory, systems thinking','structure unified fields by identifying laws preserved across representations'),
('layer_logic','Logic and formal foundations','nineteenth and twentieth centuries','formal reasoning and derivability','formal languages, axioms, inference rules, models, proof systems','proof theory, model theory, computability, proof assistants','logic unified reasoning while revealing limits of formal systems'),
('layer_computation','Computation and formal verification','twentieth century to present','executable representation and machine-checkable proof','algorithms, programs, expression trees, proof scripts, formal libraries','computer science, AI, simulation, verified software, theorem proving','computation unifies mathematical objects by making procedures executable');

INSERT INTO mathematical_idea VALUES
('idea_quantity','Quantity','arithmetic','ancient calculation and measurement','connects counting, magnitude, comparison, and modeling','number, unit, measure','calculation and comparison','same numerical form across different objects','quantity abstracts from the thing counted or measured'),
('idea_proportion','Proportion','geometry','number and space','connects number, similarity, scale, music, rate, and modeling','ratio of magnitudes','scaling','same relative relation','proportion is a bridge between arithmetic and geometry'),
('idea_proof','Proof','geometry and logic','Greek proof and formal foundations','makes reasoning accountable under assumptions','demonstration, derivation, proof script','valid inference','truth under accepted rules and assumptions','proof unifies mathematical claims through justified dependency'),
('idea_algorithm','Algorithm','computation','procedural traditions and computer science','turns reasoning into repeatable transformation','procedure, program, recipe','input to output','specified behavior','algorithmic thinking predates computers but becomes formal in computer science'),
('idea_equation','Equation','algebra','algebraic symbolism','represents relation of equality across contexts','symbolic equality','algebraic manipulation','equality relation','equations unify constraints, curves, models, and systems'),
('idea_function','Function','analysis','analytic geometry and calculus','represents dependence and mapping','f(x), mapping, rule, graph','composition, differentiation, integration','input-output dependence','functions connect formulas, curves, processes, algorithms, and random variables'),
('idea_derivative','Derivative','calculus','calculus','connects slope, velocity, sensitivity, and local change','rate of change','differentiation','local linear behavior','derivatives unify geometry and change'),
('idea_integral','Integral','calculus','calculus','connects area, accumulation, expectation, and measure','accumulation over domain','integration','total accumulated quantity','integration links geometry, analysis, probability, and physics'),
('idea_group','Group','algebra','structural mathematics','studies symmetry and operation structure','set with binary operation','homomorphism','operation law','group theory unifies numbers, symmetries, permutations, and transformations'),
('idea_graph','Graph','discrete mathematics','structural and computational mathematics','represents relations, networks, dependencies, and paths','nodes and edges','graph morphism or algorithm','adjacency or connectivity pattern','graphs unify discrete structure, computation, networks, and systems'),
('idea_probability','Probability','probability and statistics','modern mathematics of uncertainty','disciplines uncertainty, variation, evidence, and risk','probability space, distribution, conditional probability','conditioning, marginalization, expectation','measure of uncertainty under rules','probability links counting, measure, inference, data, and decisions'),
('idea_model','Model','applied mathematics','mathematical modeling','connects formal structure to target systems','formal structure plus interpretation','calibration, simulation, validation','selected relation between formal system and target system','model unity requires explicit assumptions and validation'),
('idea_category','Category','category theory','category-level abstraction','studies objects, morphisms, composition, and preservation','objects and arrows','functor and natural transformation','compositional structure','category theory unifies by transformation rather than by reducing all objects to one type'),
('idea_formal_verification','Formal verification','logic and computation','proof assistants and formal methods','connects proof, logic, type theory, and computation','formal statement and proof script','machine-checked derivation','derivability under formal rules','formal verification checks derivations but does not replace human interpretation');

INSERT INTO cross_field_connection VALUES
('conn_proportion_slope','proportion','slope','historical and conceptual generalization','ratio relation','slope as rise over run','slope includes direction and coordinate interpretation beyond simple proportion'),
('conn_geometry_algebra','curve','equation','representation translation','point relation','circle as equation','not every geometric intuition transfers cleanly into algebraic form'),
('conn_derivative_optimization','derivative','optimization','method migration','local change information','critical points','zero derivative is not sufficient for global optimality'),
('conn_group_symmetry','group','symmetry','structural identification','operation and inverse structure','rotations of a polygon','the meaning of symmetry depends on what transformations are allowed'),
('conn_graph_network','graph','network model','model interpretation','node-edge relation','roads, citations, dependency graphs','edges mean different things in different domains'),
('conn_integral_probability','integral','expectation','analytic unification','accumulation under measure','expected value as integral','probability interpretation and measure assumptions matter'),
('conn_logic_computation','formal logic','programming language theory','formal correspondence','syntax, rules, derivability','types and propositions','program behavior and proof meaning require interpretation'),
('conn_proof_verification','proof','formal verification','medium transformation','derivation under rules','proof assistant checking a theorem','verified formal statement may not match intended informal claim');

INSERT INTO transformation_invariant VALUES
('inv_geometry_rotation','geometry','rotation or reflection','distance and angle','rigid motion preserves shape','symmetries of a square'),
('inv_algebra_iso','algebra','isomorphism','operation structure','different representations can have the same algebraic structure','isomorphic groups'),
('inv_topology_deformation','topology','continuous deformation','connectedness and holes','topology preserves qualitative structure','coffee cup and torus analogy'),
('inv_analysis_change','analysis','differentiation or integration','controlled relation between local and global change','calculus links change and accumulation','fundamental theorem of calculus'),
('inv_graph_morphism','graph theory','graph morphism','adjacency or connectivity relation','relational structure is preserved under map','network abstraction'),
('inv_program_refactor','computer science','program refactoring','semantics or output behavior','implementation can change while specified behavior remains','equivalent algorithms'),
('inv_statistics_relabel','statistics','relabeling or reparameterization','inferential content under conditions','model meaning can be preserved under formal re-expression','equivalent parameterization'),
('inv_category_functor','category theory','functor','identity and composition structure','relationships between objects and maps are preserved','functor from groups to sets');

INSERT INTO proof_algorithm_model_connection VALUES
('pam_proof','proof','What follows from assumptions?','valid inference or formal derivation','treating proof as real-world adequacy','proof establishes a claim within assumptions'),
('pam_algorithm','algorithm','What procedure transforms input to output?','correctness, termination, complexity, specification satisfaction','treating working code as mathematical proof or ethical adequacy','algorithm is procedure and must be specified and validated'),
('pam_model','model','What formal structure represents a target system?','fit, validation, interpretability, domain assumptions','treating formal similarity as contextual sameness','model requires interpretation and validation'),
('pam_simulation','simulation','What behavior appears under modeled dynamics?','numerical stability, reproducibility, sensitivity checks','treating simulation output as proof','simulation is exploration under assumptions'),
('pam_formal_verification','formal verification','Does a formal derivation or system satisfy a specification?','machine-checked derivation or verified specification','treating specification correctness as real-world adequacy','verification depends on specification quality');

INSERT INTO responsible_generalization_warning VALUES
('warn_false_equivalence','formal similarity','Different systems may be treated as the same because their formal models resemble one another.','Ask what the structure preserves, what it omits, and what context changes.'),
('warn_metric_reduction','measurement','Complex realities may be compressed into narrow indicators.','Audit what cannot be measured, what is excluded, and who is affected.'),
('warn_optimization_harm','optimization','A formal objective may conflict with human or ecological values.','Interrogate objectives before solving and include ethical review.'),
('warn_model_migration','model transfer','A model may be transferred to a new domain without validating assumptions.','Revalidate data, assumptions, interpretation, and consequences in the new domain.'),
('warn_historical_flattening','history','Different mathematical traditions may be forced into one modern framework.','Preserve historical specificity while identifying shared ideas carefully.'),
('warn_computation_overconfidence','computation','Computational output may be mistaken for proof, meaning, or wisdom.','Distinguish computation, proof, model evidence, interpretation, and judgment.');
