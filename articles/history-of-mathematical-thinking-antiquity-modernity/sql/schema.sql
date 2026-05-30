PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS historiographic_warning;
DROP TABLE IF EXISTS computational_milestone;
DROP TABLE IF EXISTS structural_abstraction;
DROP TABLE IF EXISTS representation_form;
DROP TABLE IF EXISTS mathematical_milestone;
DROP TABLE IF EXISTS thinking_mode;
DROP TABLE IF EXISTS mathematical_tradition;
DROP TABLE IF EXISTS historical_period;

CREATE TABLE historical_period (
  period_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  approximate_range TEXT NOT NULL,
  dominant_mathematical_mode TEXT NOT NULL,
  representation_forms TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE mathematical_tradition (
  tradition_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  region_or_language_context TEXT NOT NULL,
  primary_media TEXT NOT NULL,
  dominant_thinking_mode TEXT NOT NULL,
  historiographic_caution TEXT NOT NULL
);

CREATE TABLE thinking_mode (
  mode_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  typical_representation TEXT NOT NULL,
  risk_if_overgeneralized TEXT NOT NULL
);

CREATE TABLE mathematical_milestone (
  milestone_id TEXT PRIMARY KEY,
  period_id TEXT NOT NULL,
  tradition_id TEXT NOT NULL,
  mode_id TEXT NOT NULL,
  contribution TEXT NOT NULL,
  representation_form TEXT NOT NULL,
  long_term_significance TEXT NOT NULL,
  responsible_interpretation_note TEXT NOT NULL,
  FOREIGN KEY (period_id) REFERENCES historical_period(period_id),
  FOREIGN KEY (tradition_id) REFERENCES mathematical_tradition(tradition_id),
  FOREIGN KEY (mode_id) REFERENCES thinking_mode(mode_id)
);

CREATE TABLE representation_form (
  representation_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  historical_layer TEXT NOT NULL,
  mathematical_function TEXT NOT NULL,
  interpretation_risk TEXT NOT NULL
);

CREATE TABLE structural_abstraction (
  structure_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  objects TEXT NOT NULL,
  relations_or_operations TEXT NOT NULL,
  thinking_shift TEXT NOT NULL,
  example_use TEXT NOT NULL
);

CREATE TABLE computational_milestone (
  computation_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  period TEXT NOT NULL,
  mathematical_role TEXT NOT NULL,
  representation TEXT NOT NULL,
  interpretation_warning TEXT NOT NULL
);

CREATE TABLE historiographic_warning (
  warning_id TEXT PRIMARY KEY,
  topic TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO historical_period VALUES
('period_antiquity','Antiquity','early recorded mathematics to c. 500 CE','procedure, measurement, table, diagram','numerals, units, tables, diagrams, worked examples','mathematical thinking grows from counting, measurement, administration, astronomy, and construction'),
('period_classical','Classical deductive traditions','c. 600 BCE to c. 300 CE','deductive geometry and demonstration','diagrams, definitions, postulates, propositions','proof becomes a central form of mathematical authority'),
('period_classical_medieval','Classical to medieval global traditions','c. 200 CE to c. 1500 CE','algorithm, astronomy, commentary, configuration, algebra','rules, tables, commentaries, diagrams, positional numeration','mathematical traditions develop across Indian, Chinese, Islamic, and other scholarly worlds'),
('period_medieval','Medieval mathematical cultures','c. 500 CE to c. 1500 CE','logic, computation, translation, scholastic order','manuscripts, tables, diagrams, disputation, equation classifications','mathematics is preserved, translated, taught, applied, and reorganized'),
('period_renaissance','Renaissance mathematics','c. 1400 CE to c. 1650 CE','symbol, perspective, commerce, technique','printed texts, cossic notation, diagrams, technical manuals','mathematics becomes more portable through print, symbol, commerce, navigation, perspective, and engineering'),
('period_early_modern','Early modern mathematics','c. 1600 CE to c. 1800 CE','coordinates, calculus, probability, mathematical modeling','equations, functions, differentials, integrals, coordinates','mathematics becomes a central language of natural science and change'),
('period_nineteenth','Nineteenth-century rigor and foundations','c. 1800 CE to c. 1900 CE','rigor, analysis, infinity, non-Euclidean geometry','quantifiers, limits, sets, functions, axioms','definitions, rigor, foundations, and alternative axiom systems transform mathematical thought'),
('period_twentieth','Twentieth-century structure and computation','c. 1900 CE to c. 2000 CE','structure, logic, algorithms, computability','formal languages, structures, graphs, matrices, algorithms','mathematics increasingly studies structures, formal systems, and computational procedures'),
('period_contemporary','Contemporary computational and formal mathematics','c. 2000 CE to present','formal verification, computation, data, simulation, proof assistants','code, proof scripts, formal libraries, data structures, models','mathematics becomes executable, machine-checkable, and infrastructural while remaining humanly interpreted');

INSERT INTO mathematical_tradition VALUES
('trad_mesopotamian','Mesopotamian scribal mathematics','Akkadian/Sumerian cuneiform and scribal schools','clay tablets, tables, worked examples','procedural computation and tabular calculation','do not judge procedural mathematics only by later proof standards'),
('trad_egyptian','Egyptian mathematical papyri','hieratic papyrus and administrative contexts','papyrus, measurement rules, worked problems','measurement, fractions, administrative arithmetic','surviving papyri are partial evidence of broader practice'),
('trad_greek','Greek deductive mathematics','Greek-language mathematical and philosophical cultures','diagrams, propositions, manuscripts','deductive proof and geometric demonstration','Greek proof is central but not the only historical form of mathematical reasoning'),
('trad_indian','Indian mathematical astronomy and arithmetic','Sanskrit and related scholarly traditions','verse, rules, commentary, tables','algorithmic arithmetic, astronomy, algebra, trigonometry','avoid forcing all justification into Euclidean proof categories'),
('trad_chinese','Chinese procedural and configurational mathematics','Chinese textual, rod-calculation, and commentarial contexts','counting rods, tables, diagrams, commentaries','procedure, configuration, systems, dissection','procedural verification and commentary deserve serious mathematical interpretation'),
('trad_islamic','Islamic algebraic, geometric, and astronomical synthesis','Arabic, Persian, and multilingual scholarly worlds','manuscripts, tables, commentaries, instruments','algebra, trigonometry, translation, astronomy','transmission was also creative transformation, not passive preservation'),
('trad_european_modern','Early modern and modern European mathematics','Latin and vernacular print cultures, academies, universities','printed books, journals, symbolic notation','symbolic algebra, calculus, rigor, structural abstraction','avoid presenting modern European mathematics as the whole history of mathematics'),
('trad_international_modern','International modern mathematics','global research communities, journals, conferences, software','papers, code, proof libraries, data repositories','structure, computation, formalization, modeling','formalization and computation remain shaped by human institutions and values');

INSERT INTO thinking_mode VALUES
('mode_procedural','Procedural','mathematics as repeatable method or algorithm','rule, recipe, table, worked example','may be misread as lacking theory'),
('mode_diagrammatic','Diagrammatic','mathematics through visible spatial relation','diagram, dissection, construction','may mistake one figure for a general proof'),
('mode_deductive','Deductive','mathematics as proof from definitions and assumptions','axiom, theorem, proposition, demonstration','may erase non-Euclidean or non-propositional forms of justification'),
('mode_algebraic','Algebraic','mathematics through symbols, unknowns, equations, and transformations','equation, variable, parameter, operation','may hide domain assumptions and historical notation differences'),
('mode_analytic','Analytic','mathematics of limits, functions, change, continuity, and approximation','functions, limits, series, inequalities','may overprivilege modern rigor over earlier successful methods'),
('mode_structural','Structural','mathematics as study of objects, relations, operations, and laws','groups, spaces, graphs, categories, formal systems','abstraction may detach from examples, history, and access'),
('mode_computational','Computational','mathematics through algorithms, simulation, complexity, and executable procedures','program, model, algorithm, data structure','computation may be mistaken for proof or interpretation'),
('mode_formal_verified','Formal-verified','mathematics encoded in formal systems and checked by machines','proof script, formal library, verification certificate','formal correctness can hide inadequate specifications or meanings');

INSERT INTO mathematical_milestone VALUES
('ms_mesopotamian_tables','period_antiquity','trad_mesopotamian','mode_procedural','sexagesimal place-value computation, reciprocal tables, worked problem forms','clay tablets and numerical tables','reliable calculation through trained procedural systems','modern algebraic reconstruction should not be confused with original notation'),
('ms_egyptian_measurement','period_antiquity','trad_egyptian','mode_procedural','fraction methods, area and volume rules, administrative arithmetic','papyrus problem texts','mathematics as measurement, distribution, and practical record','surviving texts are partial and practical rather than a full theory archive'),
('ms_greek_deduction','period_classical','trad_greek','mode_deductive','axiomatic geometry and proposition-proof architecture','definitions, postulates, diagrams, proofs','proof becomes a central mathematical ideal','deductive proof should not be treated as the only form of mathematical thinking'),
('ms_archimedean_exhaustion','period_classical','trad_greek','mode_analytic','method of exhaustion, geometric bounds, areas and volumes','geometric diagrams and bounding arguments','early rigorous limiting reasoning','do not collapse ancient exhaustion into modern epsilon-delta analysis'),
('ms_indian_place_value','period_classical_medieval','trad_indian','mode_algebraic','zero, decimal place value, algorithmic arithmetic, astronomy, trigonometry','numerals, rules, tables, verse, commentary','scalable arithmetic and algorithmic calculation','recognize both computational power and distinct genres of justification'),
('ms_chinese_systems','period_classical_medieval','trad_chinese','mode_procedural','linear systems, rod calculation, dissection, configurational reasoning','counting rods, tables, diagrams, commentary','systemic and algorithmic mathematical reasoning','procedural verification should not be dismissed as mere calculation'),
('ms_islamic_algebra','period_medieval','trad_islamic','mode_algebraic','algebra, trigonometry, equation classification, translation, astronomy','manuscripts, equation types, tables, geometric justification','global synthesis and transformation of algebraic and geometric reasoning','transmission was an active intellectual achievement'),
('ms_renaissance_symbol','period_renaissance','trad_european_modern','mode_algebraic','symbolic notation, cossic algebra, perspective, technical mathematics','printed books, symbols, diagrams','portable symbolic methods and technical applications','print standardizes but also filters mathematical authority'),
('ms_calculus_coordinates','period_early_modern','trad_european_modern','mode_analytic','analytic geometry, calculus, mechanics, probability','coordinates, equations, functions, differentials, integrals','mathematics becomes a language of natural science and change','mathematical models require interpretation and assumptions'),
('ms_nineteenth_rigor','period_nineteenth','trad_european_modern','mode_analytic','epsilon-delta rigor, real numbers, functions, convergence, infinity','quantifiers, inequalities, sets, functions','definitions and rigor reshape mathematical standards','rigor is historically developed, not timelessly fixed'),
('ms_non_euclidean','period_nineteenth','trad_european_modern','mode_structural','non-Euclidean geometry and alternative axiom systems','axioms, models, geometric systems','axioms become structural assumptions','mathematical truth becomes conditional on systems'),
('ms_foundations_logic','period_twentieth','trad_international_modern','mode_formal_verified','set theory, symbolic logic, formal systems, incompleteness, computability','formal languages, axioms, proof systems, algorithms','mathematics studies proof and computation themselves','truth, proof, consistency, and computability must be distinguished'),
('ms_structural_modern','period_twentieth','trad_international_modern','mode_structural','groups, rings, fields, topology, functional analysis, categories, graphs','structures, morphisms, spaces, operations, diagrams','mathematics becomes the study of structure','abstraction should remain connected to examples and access'),
('ms_computer_age','period_twentieth','trad_international_modern','mode_computational','algorithms, complexity, simulation, numerical methods, computer algebra','programs, data structures, algorithms, matrices, graphs','mathematics becomes computational and executable','computation is evidence and exploration but not automatically proof or wisdom'),
('ms_proof_assistants','period_contemporary','trad_international_modern','mode_formal_verified','proof assistants, formal verification, machine-checked libraries','proof scripts, formal libraries, certificates','proof becomes a computational artifact','formal verification depends on human definitions, specifications, and interpretation');

INSERT INTO representation_form VALUES
('rep_numerals','Numerals and place value','ancient and classical arithmetic','make quantity portable and scalable','number systems are often treated as neutral rather than historical technologies'),
('rep_table','Tables','scribal, astronomical, and computational traditions','organize repeated values and procedures','table-based reasoning may be undervalued relative to formulas'),
('rep_diagram','Diagrams','geometry, dissection, proof, configuration','make spatial relation visible','visual evidence may be overtrusted or undercredited'),
('rep_symbol','Algebraic symbols','medieval to modern algebra','compress unknowns, parameters, operations, and transformations','modern notation can distort older mathematical practice'),
('rep_function','Function notation','early modern to modern analysis','represent dependence, transformation, and mapping','domain and codomain assumptions can be hidden'),
('rep_set','Set and logical notation','modern foundations','formalize collections, quantification, membership, and inference','symbol density can obscure meaning and access'),
('rep_matrix','Matrices and vectors','modern linear algebra and data systems','compress systems, transformations, and data','dimension, interpretation, and data assumptions can be hidden'),
('rep_code','Code and proof scripts','contemporary computation and verification','make procedures executable and proofs checkable','formal correctness can be mistaken for complete meaning or responsibility');

INSERT INTO structural_abstraction VALUES
('struct_group','Group','elements such as symmetries or transformations','one associative operation with identity and inverses','from objects to operation laws','symmetry, algebra, geometry, cryptography'),
('struct_vector_space','Vector space','vectors, functions, signals, or data points','addition and scalar multiplication','from individual quantities to linear structure','linear algebra, physics, statistics, machine learning'),
('struct_topology','Topological space','points and open sets','nearness, continuity, deformation','from measurement to qualitative structure','analysis, geometry, data shape, dynamics'),
('struct_graph','Graph','vertices and edges','adjacency, connectivity, paths','from quantities to relations','networks, algorithms, infrastructure, dependency systems'),
('struct_category','Category','objects and morphisms','composition and identity morphisms','from structures to structure-preserving maps','algebra, topology, logic, computer science'),
('struct_formal_system','Formal system','symbols, formulas, axioms, proofs','inference rules and derivations','from using proof to studying proof','logic, foundations, proof assistants');

INSERT INTO computational_milestone VALUES
('comp_algorithm','Algorithmic procedure','ancient to contemporary','repeatable transformation of inputs into outputs','rule, recipe, program','a working procedure still requires specification and validation'),
('comp_computability','Computability theory','twentieth century','formalizes what can be computed by mechanical procedure','Turing machines, lambda calculus, recursive functions','computability is not the same as practical feasibility'),
('comp_complexity','Complexity theory','twentieth century','studies resources required by algorithms','growth bounds, reductions, classes','asymptotic analysis abstracts away many implementation details'),
('comp_simulation','Simulation','twentieth century to present','explores systems too complex for closed-form solution','numerical model and generated trajectories','simulation depends on model assumptions and numerical stability'),
('comp_cas','Computer algebra','twentieth century to present','manipulates symbolic expressions computationally','expression trees and rewrite rules','symbolic simplification depends on domains and assumptions'),
('comp_proof_assistant','Proof assistant','late twentieth century to present','checks formal proof scripts against inference rules','formal language, libraries, proof kernel','verified proof of a statement does not validate the statement social or modeling meaning');

INSERT INTO historiographic_warning VALUES
('warn_eurocentrism','canon formation','Mathematical history can be reduced to a Greek-European sequence.','Include Mesopotamian, Egyptian, Indian, Chinese, Islamic, African, Indigenous, and other traditions where relevant and well-sourced.'),
('warn_presentism','historical judgment','Older mathematics can be judged only by modern notation, proof, or rigor standards.','Interpret mathematical practices within their own media, genres, institutions, and purposes.'),
('warn_textual_bias','source survival','Surviving written texts can be mistaken for the whole history of mathematical thinking.','Attend to oral, material, craft, architectural, navigational, commercial, and pedagogical practices.'),
('warn_canon_bias','credit and authority','Famous individuals and elite texts can obscure collective labor, commentary, teaching, translation, and institutions.','Document transmission, commentary, pedagogy, tools, and communities of practice.'),
('warn_colonial_hierarchy','power and classification','Non-European mathematics can be appropriated, minimized, or forced into European categories.','Preserve historical specificity and avoid treating European forms as the only standard of mathematical maturity.'),
('warn_tech_triumph','modern computation','Formalization, computation, and proof assistants can be treated as the inevitable final form of mathematics.','Recognize computation as a powerful medium that remains dependent on human choice, meaning, and responsibility.');
