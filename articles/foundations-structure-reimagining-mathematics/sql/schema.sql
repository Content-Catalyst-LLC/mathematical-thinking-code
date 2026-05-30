PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS abstraction_warning;
DROP TABLE IF EXISTS proof_assistant_layer;
DROP TABLE IF EXISTS model_interpretation;
DROP TABLE IF EXISTS transformation_map;
DROP TABLE IF EXISTS formal_system;
DROP TABLE IF EXISTS mathematical_structure;
DROP TABLE IF EXISTS foundation_view;

CREATE TABLE foundation_view (
  view_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  central_question TEXT NOT NULL,
  mathematical_strength TEXT NOT NULL,
  limitation_note TEXT NOT NULL,
  responsible_interpretation TEXT NOT NULL
);

CREATE TABLE mathematical_structure (
  structure_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  objects TEXT NOT NULL,
  relations_or_operations TEXT NOT NULL,
  laws_or_axioms TEXT NOT NULL,
  preserved_by TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE formal_system (
  system_id TEXT PRIMARY KEY,
  language TEXT NOT NULL,
  axioms TEXT NOT NULL,
  inference_rules TEXT NOT NULL,
  intended_use TEXT NOT NULL,
  limitation_note TEXT NOT NULL
);

CREATE TABLE transformation_map (
  map_id TEXT PRIMARY KEY,
  source_structure TEXT NOT NULL,
  target_structure TEXT NOT NULL,
  map_type TEXT NOT NULL,
  what_is_preserved TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE model_interpretation (
  model_id TEXT PRIMARY KEY,
  formal_structure TEXT NOT NULL,
  possible_interpretations TEXT NOT NULL,
  assumption_risk TEXT NOT NULL,
  responsible_question TEXT NOT NULL
);

CREATE TABLE proof_assistant_layer (
  layer_id TEXT PRIMARY KEY,
  layer_name TEXT NOT NULL,
  human_role TEXT NOT NULL,
  machine_role TEXT NOT NULL,
  risk_or_limitation TEXT NOT NULL
);

CREATE TABLE abstraction_warning (
  warning_id TEXT PRIMARY KEY,
  topic TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO foundation_view VALUES
('view_set_theoretic','Set-theoretic','Can mathematics be built from sets and membership?','provides a broad common language for modern mathematics','membership language may not reflect everyday mathematical practice','distinguish foundational coding from mathematical meaning and use'),
('view_logical','Logical','Can mathematics be grounded in logic?','clarifies inference, definition, and derivation','logic may not capture all mathematical practice or ontology','distinguish logical derivation from interpretation and application'),
('view_formalist','Formalist','Can mathematics be secured through formal systems?','makes axioms, syntax, and proof rules explicit','syntax can be mistaken for meaning','distinguish formal manipulation from mathematical explanation'),
('view_intuitionist','Intuitionistic','What mathematics can be constructed?','emphasizes constructive content and proof-as-method','classical results may not transfer directly','state whether existence is constructive or non-constructive'),
('view_structural','Structural','What relations and operations define mathematical objects?','reveals sameness beneath different representations','abstraction can detach from examples and access','connect structures to examples, maps, and assumptions'),
('view_computational','Computational','What can be computed, checked, simulated, or verified?','makes procedures executable and proofs checkable','computation can be mistaken for proof, interpretation, or wisdom','distinguish algorithm, model, proof, evidence, and consequence');

INSERT INTO mathematical_structure VALUES
('struct_group','Group','elements such as symmetries, permutations, transformations, or numbers','one binary operation','closure, associativity, identity, inverses','group homomorphism','the structure is defined by operation laws, not by the visual appearance of elements'),
('struct_vector_space','Vector space','vectors, functions, signals, states, or data points','vector addition and scalar multiplication','linear combination laws over a field','linear map','linear structure appears across geometry, analysis, physics, economics, and data science'),
('struct_topological_space','Topological space','points and open sets','openness, continuity, nearness, deformation','open set axioms','continuous map','topology studies qualitative structure rather than exact measurement'),
('struct_graph','Graph','vertices and edges','adjacency, incidence, paths, connectivity','relation structure between nodes','graph morphism','graphs model relations but the meaning of an edge depends on context'),
('struct_category','Category','objects and morphisms','composition and identity morphisms','associativity of composition and identity laws','functor','category-level thinking centers transformations and their preservation'),
('struct_formal_system','Formal system','symbols, formulas, axioms, proofs','inference rules and derivability','syntax, axioms, and proof rules','formal translation or interpretation','formal systems make proof inspectable but depend on chosen language and axioms');

INSERT INTO formal_system VALUES
('sys_euclidean','geometric definitions, postulates, diagrams, propositions','geometric postulates and common notions','geometric construction and deductive reasoning','organizing geometry as demonstration','diagrammatic assumptions may remain implicit'),
('sys_set_theory','membership, equality, logical formulas','axioms governing sets and membership','first-order logical inference','broad foundational language for mathematics','foundation does not automatically explain mathematical practice'),
('sys_arithmetic','numbers, successor, addition, multiplication, quantifiers','Peano-style axioms or related arithmetic systems','logical inference plus induction','formal study of arithmetic','sufficiently strong systems raise incompleteness issues'),
('sys_type_theory','types, terms, functions, propositions-as-types','type formation, introduction, elimination, computation rules','type checking and derivation rules','constructive mathematics and proof assistants','formalization choices shape the resulting mathematics'),
('sys_proof_assistant','formal statements, definitions, tactics, libraries','kernel foundations and imported library assumptions','machine-checked derivation rules','formal verification of mathematical proofs','verified derivation does not replace interpretation of why the theorem matters');

INSERT INTO transformation_map VALUES
('map_group_hom','Group','Group','homomorphism','group operation','structure-preserving maps let different group representations be compared'),
('map_linear','Vector space','Vector space','linear map','addition and scalar multiplication','linear maps preserve linear combination structure'),
('map_continuous','Topological space','Topological space','continuous map','topological nearness and open-set behavior','continuity preserves qualitative spatial structure'),
('map_graph','Graph','Graph','graph morphism','adjacency or incidence structure','graph maps preserve relation patterns depending on definition'),
('map_functor','Category','Category','functor','objects, morphisms, identities, composition','functors compare whole structured mathematical worlds'),
('map_formal_translation','Formal system','Formal system','formal translation','derivability or interpretation conditions','formal translations reveal relationships between systems of proof');

INSERT INTO model_interpretation VALUES
('model_graph','graph','social network, road network, citation network, dependency graph, neural architecture','edges may not mean the same thing across domains','What does an edge mean, and what relation is omitted?'),
('model_differential_equation','differential equation','motion, population growth, infection spread, chemical reaction, climate process','variables and parameters may omit important causal factors','Which dynamics are included, simplified, or excluded?'),
('model_probability','probability distribution','frequency, uncertainty, risk, belief, noise, variation','probability interpretation may be ambiguous','What kind of uncertainty is being modeled?'),
('model_optimization','optimization problem','efficiency, cost, welfare, loss, performance, allocation','objective function may encode narrow or harmful priorities','Should this objective be optimized at all?'),
('model_matrix','matrix','linear transformation, dataset, adjacency matrix, covariance matrix, constraint system','rows, columns, dimensions, and entries require context','What do entries represent, and what assumptions govern operations?');

INSERT INTO proof_assistant_layer VALUES
('layer_concept','Concept','decide what idea matters','no independent mathematical intention','important questions may be formalized poorly or not at all'),
('layer_definition','Definition','choose formal objects and assumptions','check syntax and type correctness','bad definitions can make a proof correct but unhelpful'),
('layer_theorem','Theorem','state the claim precisely','represent the proposition formally','formal statement may not match intended informal meaning'),
('layer_proof','Proof','guide proof strategy and construction','verify inference steps','machine verification does not explain importance'),
('layer_interpretation','Interpretation','explain why the result matters','no social, scientific, or philosophical judgment','formal correctness can be overextended into unwarranted authority');

INSERT INTO abstraction_warning VALUES
('warn_hidden_assumptions','modeling','Formal clarity can conceal modeling choices and exclusions.','State assumptions, domains, constraints, and omitted variables explicitly.'),
('warn_metric_reduction','measurement','Complex values can be reduced to narrow measurable proxies.','Audit what the metric omits and who is affected by the reduction.'),
('warn_optimization_harm','optimization','A mathematically solved system can optimize the wrong objective.','Interrogate objectives before solving and include ethical review.'),
('warn_formal_overconfidence','proof and verification','Proof or verification can be mistaken for full adequacy.','Distinguish specification, proof, interpretation, and consequence.'),
('warn_access_barrier','education and access','Abstraction can exclude learners or marginalized communities.','Teach examples, history, notation, meaning, and applications alongside form.'),
('warn_category_opacity','high abstraction','Category-level abstraction can become opaque without motivating examples.','Connect objects and morphisms to concrete cases before generalizing.');
