PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS interpretation_warning;
DROP TABLE IF EXISTS cultural_practice;
DROP TABLE IF EXISTS pattern_record;
DROP TABLE IF EXISTS representation_practice;
DROP TABLE IF EXISTS mathematical_origin;

CREATE TABLE mathematical_origin (
  origin_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  origin_type TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE representation_practice (
  practice_id TEXT PRIMARY KEY,
  origin_id TEXT NOT NULL,
  representation_type TEXT NOT NULL,
  example TEXT NOT NULL,
  preserved_structure TEXT NOT NULL,
  omitted_detail TEXT NOT NULL,
  FOREIGN KEY (origin_id) REFERENCES mathematical_origin(origin_id)
);

CREATE TABLE pattern_record (
  pattern_id TEXT PRIMARY KEY,
  pattern_type TEXT NOT NULL,
  example TEXT NOT NULL,
  possible_rule TEXT NOT NULL,
  proof_status TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE cultural_practice (
  practice_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  mathematical_form TEXT NOT NULL,
  embedded_knowledge TEXT NOT NULL
);

CREATE TABLE interpretation_warning (
  warning_id TEXT PRIMARY KEY,
  pattern_id TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL,
  FOREIGN KEY (pattern_id) REFERENCES pattern_record(pattern_id)
);

INSERT INTO mathematical_origin VALUES
('origin_number_sense','Number sense','cognitive','Approximate quantity comparison and small-number recognition before formal counting.'),
('origin_counting','Counting','practice','Exact quantity through ordered count words or marks and one-to-one correspondence.'),
('origin_pattern','Pattern recognition','cognitive_practice','Recognition of repetition, growth, symmetry, recurrence, and order.'),
('origin_geometry','Spatial reasoning','cognitive_practice','Reasoning about shape, boundary, distance, orientation, and construction.'),
('origin_symbol','Symbolic representation','cultural_tool','External marks, tokens, numerals, diagrams, and formulas that stabilize thought.'),
('origin_computation','Computation','formal_tool','Executable procedures for counting, transforming, searching, and testing patterns.');

INSERT INTO representation_practice VALUES
('rep_tally','origin_counting','tally_mark','||||','one-to-one count','object identity and context'),
('rep_token','origin_counting','token','grain token','unit equivalence','individual variation'),
('rep_numeral','origin_number_sense','numeral','7','quantity name','collection context'),
('rep_diagram','origin_geometry','diagram','triangle drawing','spatial relation','exact proof and scale'),
('rep_formula','origin_pattern','formula','a_n=n(n+1)/2','general relation','derivation and proof history'),
('rep_code','origin_computation','program','mod(n,7)','executable recurrence or cycle','human meaning and cultural context');

INSERT INTO pattern_record VALUES
('pat_tally','correspondence','stone_a -> |, stone_b -> |','one mark per object','structural_principle','one-to-one correspondence supports exact quantity'),
('pat_even','sequence','2 4 6 8 10','a_n=2n','proved','definition of even number explains pattern'),
('pat_triangular','sequence','1 3 6 10 15','a_n=n(n+1)/2','proved','finite differences suggest formula; induction proves it'),
('pat_rhythm','cycle','0 1 2 3 0 1 2 3','n mod 4','proved_by_definition','modular arithmetic formalizes repeated rhythm'),
('pat_visual','spatial_pattern','ABABAB border','period-two repetition','conjectural_representation','requires defined motif and transformation rule'),
('pat_false','finite_pattern','1 2 4 8 16 31','powers of two until failure','refuted','finite prefix can mislead without proof-status discipline');

INSERT INTO cultural_practice VALUES
('practice_trade','Trade','counting arithmetic accounting','quantity exchange debt and equivalence'),
('practice_craft','Craft','pattern symmetry proportion','material intelligence design and repetition'),
('practice_agriculture','Agriculture','calendar measurement cycles','seasonal timing and resource planning'),
('practice_navigation','Navigation','geometry astronomy direction','spatial orientation and celestial pattern recognition'),
('practice_music','Music','rhythm grouping periodicity','temporal structure repetition and subdivision'),
('practice_building','Building','measurement geometry proportion','length angle area and structural arrangement');

INSERT INTO interpretation_warning VALUES
('warn_finite_evidence','pat_triangular','Finite agreement suggests a rule but does not prove it.','Use induction or another proof strategy.'),
('warn_false_prefix','pat_false','A finite prefix may imitate a familiar sequence before failing.','Search for counterexamples and state proof status.'),
('warn_context_loss','pat_tally','Counting preserves quantity but may omit object differences and context.','Document what is counted and what is excluded.'),
('warn_spurious_pattern','pat_visual','A visual or statistical pattern may be accidental or overinterpreted.','Define the rule and test against alternatives.'),
('warn_cycle_assumption','pat_rhythm','A cycle may be imposed by representation rather than observed structure.','State period, starting point, and evidence.');
