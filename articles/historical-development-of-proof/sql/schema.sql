PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS historiographic_warning;
DROP TABLE IF EXISTS proposition_dependency;
DROP TABLE IF EXISTS proof_medium;
DROP TABLE IF EXISTS proof_milestone;
DROP TABLE IF EXISTS proof_tradition;
DROP TABLE IF EXISTS proof_style;

CREATE TABLE proof_style (
  style_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  typical_medium TEXT NOT NULL,
  accepted_ground TEXT NOT NULL,
  strength TEXT NOT NULL,
  limitation_note TEXT NOT NULL
);

CREATE TABLE proof_tradition (
  tradition_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  period TEXT NOT NULL,
  region_or_language_context TEXT NOT NULL,
  dominant_proof_style TEXT NOT NULL,
  interpretation_note TEXT NOT NULL
);

CREATE TABLE proof_milestone (
  milestone_id TEXT PRIMARY KEY,
  tradition_id TEXT NOT NULL,
  figure_or_text TEXT NOT NULL,
  approximate_period TEXT NOT NULL,
  proof_style_id TEXT NOT NULL,
  contribution TEXT NOT NULL,
  proof_historical_significance TEXT NOT NULL,
  FOREIGN KEY (tradition_id) REFERENCES proof_tradition(tradition_id),
  FOREIGN KEY (proof_style_id) REFERENCES proof_style(style_id)
);

CREATE TABLE proof_medium (
  medium_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  historical_context TEXT NOT NULL,
  proof_effect TEXT NOT NULL,
  interpretation_risk TEXT NOT NULL
);

CREATE TABLE proposition_dependency (
  dependency_id TEXT PRIMARY KEY,
  system_id TEXT NOT NULL,
  source_claim TEXT NOT NULL,
  target_claim TEXT NOT NULL,
  relationship TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE historiographic_warning (
  warning_id TEXT PRIMARY KEY,
  topic TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO proof_style VALUES
('style_procedural','Procedural','recipe, algorithm, worked example','reliable method and repeated use','excellent for computation and transmission','may not state general proof explicitly'),
('style_diagrammatic','Diagrammatic','geometric figure, dissection, configuration','visible spatial relation','makes structure and construction visible','diagram can mislead if treated as one special case'),
('style_deductive','Deductive','definition, axiom, proposition, demonstration','valid derivation from accepted assumptions','supports general necessity and cumulative theory','depends on accepted axioms and implicit diagrammatic assumptions'),
('style_algebraic','Algebraic','symbolic equation and transformation','equivalence-preserving manipulation','supports general symbolic reasoning','domain assumptions can be hidden'),
('style_analytic','Analytic','limits, inequalities, quantifiers','precise definitions of limiting behavior','controls infinite processes and pathologies','high abstraction can obscure intuition'),
('style_formal','Formal-logical','formal language, axioms, inference rules','derivability in a formal system','makes proof steps explicit and inspectable','formal system itself has limits and assumptions'),
('style_machine','Machine-checked','proof assistant script or certificate','kernel-checked formal derivation','reduces hidden proof gaps','requires trust in formalization, tooling, and interpretation');

INSERT INTO proof_tradition VALUES
('trad_mesopotamian','Mesopotamian scribal mathematics','ancient','Akkadian/Sumerian cuneiform context','procedural worked examples','rule-based calculation and problem-type mastery'),
('trad_egyptian','Egyptian mathematical papyri','ancient','hieratic papyrus context','rule-based measurement and arithmetic','practical arithmetic, area, volume, and administrative calculation'),
('trad_greek','Greek deductive geometry','classical and Hellenistic','Greek-language mathematical texts','deductive geometric demonstration','axiomatic proposition-proof architecture'),
('trad_indian','Indian mathematical astronomy and algorithmic traditions','classical to early modern','Sanskrit and related scholarly contexts','algorithmic, astronomical, and explanatory justification','rules, examples, derivations, upapatti, and computational astronomy'),
('trad_chinese','Chinese mathematical commentary and procedure','classical to medieval','Chinese textual and rod-calculation contexts','procedural and configurational verification','procedures, configurations, dissection, and commentarial explanation'),
('trad_islamic','Islamic algebraic and geometric synthesis','medieval','Arabic, Persian, and multilingual scholarly contexts','algebraic-geometric justification','translation, transformation, algebra, geometry, astronomy, and trigonometry'),
('trad_analysis','Nineteenth-century rigorous analysis','modern','European professional mathematics','epsilon-delta and arithmetized rigor','limits, real numbers, functions, convergence, and formal rigor'),
('trad_foundations','Foundations and mathematical logic','late nineteenth and twentieth century','international mathematical logic','formal systems and metamathematics','proof becomes an object of mathematical study'),
('trad_computer','Computer-assisted and machine-checked proof','contemporary','global computational proof communities','machine-checked formal verification','proof becomes code, artifact, certificate, and infrastructure');

INSERT INTO proof_milestone VALUES
('ms_babylonian','trad_mesopotamian','Babylonian mathematical tablets','second millennium BCE','style_procedural','worked numerical procedures and quadratic problem forms','advanced rule-based mathematics before axiomatic proof'),
('ms_rhind','trad_egyptian','Rhind Mathematical Papyrus','c. 1650 BCE copy of older material','style_procedural','arithmetic, fractions, measurement, practical problems','procedural authority and scribal mathematical training'),
('ms_euclid','trad_greek','Euclid, Elements','c. 300 BCE','style_deductive','axiomatic organization of geometry','canonical model of proposition-proof architecture'),
('ms_archimedes','trad_greek','Archimedes','third century BCE','style_diagrammatic','method of exhaustion and rigorous geometric bounds','early limiting reasoning and geometric rigor'),
('ms_liu_hui','trad_chinese','Liu Hui commentary on The Nine Chapters','third century CE','style_procedural','procedure, dissection, and configurational explanation','verification through transformation and commentary'),
('ms_al_khwarizmi','trad_islamic','al-Khwarizmi algebraic works','ninth century CE','style_algebraic','systematic equation-solving procedures','algebraic method tied to geometric and procedural justification'),
('ms_madhava','trad_indian','Kerala school series traditions','fourteenth to sixteenth centuries','style_analytic','infinite series, trigonometric approximation, astronomical computation','advanced reasoning about approximation and infinite processes'),
('ms_cauchy_weierstrass','trad_analysis','Cauchy and Weierstrass','nineteenth century','style_analytic','rigorization of limits and continuity','precise quantified foundations for analysis'),
('ms_non_euclidean','trad_foundations','Non-Euclidean geometry','nineteenth century','style_deductive','alternative consistent geometries','axioms become structural assumptions rather than obvious spatial truths'),
('ms_godel','trad_foundations','Gödel incompleteness theorems','1931','style_formal','limits of formal provability in sufficiently strong systems','distinguished truth, consistency, and formal derivability'),
('ms_four_color','trad_computer','Four Color Theorem computer-assisted proof','1976 and later refinements','style_machine','large finite case verification by computer','challenged human-inspection norms of proof'),
('ms_proof_assistants','trad_computer','Coq, Lean, Isabelle, HOL systems','late twentieth century to present','style_machine','machine-checked formal proof scripts','proof becomes formal artifact checked by computational kernel');

INSERT INTO proof_medium VALUES
('med_tablet','Clay tablet','scribal mathematics','preserves procedures and worked examples','may be judged unfairly by later deductive standards'),
('med_papyrus','Papyrus','administrative and pedagogical mathematics','records rules and practical problem solving','survival bias shapes what is known'),
('med_diagram','Diagram','geometric traditions','makes spatial relation and construction visible','single figure may be mistaken for general proof'),
('med_commentary','Commentary','scholarly transmission','explains, extends, and justifies inherited methods','commentarial originality may be undervalued'),
('med_print','Printed textbook','standardized education','stabilizes sequence, notation, and canon','can narrow what counts as legitimate tradition'),
('med_journal','Journal article','professional mathematics','creates peer-reviewed proof communication','institutional gatekeeping shapes canon'),
('med_code','Proof assistant script','formal verification','turns proof into machine-checkable artifact','formal script may obscure human interpretive choices');

INSERT INTO proposition_dependency VALUES
('dep_def_axiom','euclidean_model','definitions_and_postulates','proposition_1','grounds','first proposition depends on accepted starting points'),
('dep_p1_p5','euclidean_model','proposition_1','proposition_5','prior_result','later propositions may depend on earlier constructions'),
('dep_p5_p32','euclidean_model','proposition_5','proposition_32','prior_result','proof architecture becomes cumulative'),
('dep_limits_derivative','analysis_model','epsilon_delta_limit','derivative_definition','foundation','calculus is stabilized by rigorous limit concepts'),
('dep_axioms_theorem','formal_model','formal_axioms','formal_theorem','derivation','formal theorem follows by inference rules'),
('dep_script_certificate','machine_model','proof_script','checked_certificate','verification','machine checking verifies formal derivation steps');

INSERT INTO historiographic_warning VALUES
('warn_eurocentrism','canon formation','Proof history can be reduced to a Greek-European story.','Include Mesopotamian, Egyptian, Indian, Chinese, Islamic, and other mathematical traditions.'),
('warn_presentism','historical judgment','Past mathematical practices can be judged only by modern formal standards.','Interpret proof practices within their own media, institutions, languages, and purposes.'),
('warn_flattening','cross-cultural comparison','Different forms of justification can be treated as identical.','Compare traditions carefully while preserving real differences in style and authority.'),
('warn_canon_bias','source survival','Famous texts and surviving manuscripts can be mistaken for the whole history.','Attend to pedagogy, commentary, craft, oral transmission, and institutional power.'),
('warn_tech_triumph','machine proof','Machine-checked proof can be treated as the end of human proof.','Recognize human choices in formalization, theorem selection, interpretation, and tool trust.'),
('warn_translation','language and transmission','Translation can erase terms, genres, and local meanings of justification.','Preserve historical terminology and cite specialist scholarship when possible.');
