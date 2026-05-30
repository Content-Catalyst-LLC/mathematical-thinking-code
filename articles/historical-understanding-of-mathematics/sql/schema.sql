PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS canon_risk;
DROP TABLE IF EXISTS proof_style;
DROP TABLE IF EXISTS notation_history;
DROP TABLE IF EXISTS mathematical_transmission;
DROP TABLE IF EXISTS historiographic_risk;
DROP TABLE IF EXISTS historical_practice;

CREATE TABLE historical_practice (
  practice_id TEXT PRIMARY KEY,
  practice_name TEXT NOT NULL,
  object_of_thought TEXT NOT NULL,
  medium TEXT NOT NULL,
  method TEXT NOT NULL,
  meaning TEXT NOT NULL,
  caution TEXT NOT NULL
);

CREATE TABLE historiographic_risk (
  risk_id TEXT PRIMARY KEY,
  risk_name TEXT NOT NULL,
  problem TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE mathematical_transmission (
  transmission_id TEXT PRIMARY KEY,
  source_context TEXT NOT NULL,
  target_context TEXT NOT NULL,
  preserved_content TEXT NOT NULL,
  transformed_content TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE notation_history (
  notation_id TEXT PRIMARY KEY,
  notation_or_medium TEXT NOT NULL,
  mathematical_function TEXT NOT NULL,
  historical_effect TEXT NOT NULL,
  anachronism_warning TEXT NOT NULL
);

CREATE TABLE proof_style (
  proof_style_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  historical_context TEXT NOT NULL,
  authority_basis TEXT NOT NULL,
  limitation_or_caution TEXT NOT NULL
);

CREATE TABLE canon_risk (
  canon_risk_id TEXT PRIMARY KEY,
  risk TEXT NOT NULL,
  problem TEXT NOT NULL,
  responsible_response TEXT NOT NULL
);

INSERT INTO historical_practice VALUES
('practice_scribal_calculation','Scribal calculation','quantity, reciprocal relation, measure, tabular pattern','clay tablet, table, worked example','procedure, lookup, transformation','administrative and computational reliability','do not judge procedural mathematics only by later proof standards'),
('practice_measurement_geometry','Measurement geometry','length, area, volume, proportion','papyrus, diagram, rule, unit system','measurement rule and approximation','land, construction, allocation, and administration','surviving practical texts are partial evidence of broader practice'),
('practice_euclidean_geometry','Euclidean geometry','space, figure, relation, construction','diagram, definition, postulate, proposition','deductive demonstration','necessity under assumptions','distinguish diagrammatic reasoning from later formal proof'),
('practice_symbolic_algebra','Symbolic algebra','unknowns, equations, operations, symbolic form','notation, printed text, equation, manipulation rule','symbolic transformation','generalization across problem families','modern notation can distort older rhetorical or syncopated practice'),
('practice_proof_assistant','Proof assistant formalization','formal theorem, definition, proof object, library dependency','proof script, type system, formal library','machine-checked derivation','verified formal mathematical infrastructure','formal statement must match intended meaning and assumptions');

INSERT INTO historiographic_risk VALUES
('risk_presentism','Presentism','Older mathematics is judged only by modern notation, proof standards, or disciplinary categories.','Interpret practices within their own media, institutions, purposes, and evidence standards.'),
('risk_eurocentrism','Eurocentrism','Mathematics is narrated mainly as a Greek-to-European sequence.','Include multiple global traditions and transmission networks where supported by evidence.'),
('risk_notation_anachronism','Notation anachronism','Modern notation is mistaken for original mathematical practice.','Distinguish historical expression from modern reconstruction.'),
('risk_textual_bias','Textual bias','Surviving written texts are treated as the whole record of mathematical practice.','Consider oral, material, craft, architectural, navigational, pedagogical, and institutional mathematics.'),
('risk_formal_overconfidence','Formal overconfidence','Formal proof or verification is treated as full interpretation or social adequacy.','Separate proof, specification, model, consequence, and use.');

INSERT INTO mathematical_transmission VALUES
('trans_greek_arabic','Greek mathematical texts','Arabic-speaking scholarly worlds','geometric propositions, astronomical models, logical methods','terminology, commentary, synthesis with algebra and astronomy','translation was active interpretation and scholarly transformation'),
('trans_indian_numerals','Indian numeral and place-value traditions','Islamic and European mathematical cultures','decimal place value and zero as computational infrastructure','notation, pedagogy, commercial arithmetic, printed standardization','numeral transmission changed the scale of arithmetic practice'),
('trans_islamic_algebra','Islamic algebraic and astronomical traditions','Latin and European mathematical cultures','algebraic methods, trigonometry, translated sources, astronomical tables','notation, university curriculum, commercial arithmetic, symbolic algebra','transmission was creative, not merely preservational'),
('trans_digital_formal','journal mathematics and informal proof','formal libraries and proof assistants','theorems, definitions, proof strategies','machine-checkable statements, dependencies, tactics, libraries','digital formalization makes proof infrastructural and versioned');

INSERT INTO notation_history VALUES
('not_table','Tables','organize repeated values, procedures, and predictions','enabled computational and astronomical reliability','table-based reasoning should not be dismissed because it is not formula-based'),
('not_diagram','Diagrams','make spatial relations visible','supported construction, geometric proof, and visual reasoning','diagrams are not merely illustrations in all historical contexts'),
('not_place_value','Place-value numerals','represent magnitude compactly by position','made arithmetic scalable and portable','do not treat modern decimal notation as historically universal'),
('not_algebra','Algebraic notation','represent unknowns, operations, equations, parameters','enabled symbolic manipulation and generalization','modern equations can distort rhetorical or syncopated algebra'),
('not_code','Code and proof scripts','make procedures executable and derivations checkable','turned mathematics into reusable computational infrastructure','machine-checkability does not remove the need for interpretation');

INSERT INTO proof_style VALUES
('proof_diagrammatic','Diagrammatic demonstration','classical geometry and visual construction','relations made visible and reasoned through construction','diagrams may hide generality or implicit assumptions'),
('proof_procedural','Procedural verification','scribal, algorithmic, commercial, and computational traditions','repeatable successful method','procedure may require separate proof of correctness'),
('proof_algebraic','Algebraic transformation','algebraic and symbolic traditions','equivalence preserved under valid transformations','domain assumptions can be hidden'),
('proof_limit','Limit proof','analysis and calculus foundations','quantified control of approximation','formal rigor can obscure intuition for learners'),
('proof_formal','Formal derivation','logic, type theory, proof assistants','machine-checkable derivation under formal rules','formal statement may not match informal intention');

INSERT INTO canon_risk VALUES
('canon_eurocentric_sequence','Eurocentric sequence','A Greek-to-European storyline is treated as the whole history of mathematics.','Teach global mathematical traditions and transmission networks.'),
('canon_elite_texts','Elite textual survival','Elite written texts are treated as the whole record.','Attend to practical, oral, material, craft, and institutional mathematics.'),
('canon_named_individuals','Named-individual overfocus','Teachers, translators, commentators, and communities disappear.','Document collective intellectual labor and institutional conditions.'),
('canon_gender_exclusion','Gender exclusion','Women mathematical labor and barriers are minimized.','Recover excluded labor, institutional constraints, and access barriers.'),
('canon_modern_notation','Modern notation dominance','Modern symbolic reconstruction replaces historical practice.','Present original media and modern reconstructions as distinct layers.');
