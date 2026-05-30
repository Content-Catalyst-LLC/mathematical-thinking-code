PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS proof_status_taxonomy;
DROP TABLE IF EXISTS discovery_workflow;
DROP TABLE IF EXISTS human_interpretation_record;
DROP TABLE IF EXISTS discovery_risk;
DROP TABLE IF EXISTS verification_record;
DROP TABLE IF EXISTS evaluator_record;
DROP TABLE IF EXISTS discovery_candidate;

CREATE TABLE discovery_candidate (
  candidate_id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  output_type TEXT NOT NULL,
  generated_by TEXT NOT NULL,
  assumptions TEXT NOT NULL,
  current_status TEXT NOT NULL,
  interpretation_question TEXT NOT NULL
);

CREATE TABLE evaluator_record (
  evaluator_id TEXT PRIMARY KEY,
  candidate_id TEXT NOT NULL,
  evaluator_type TEXT NOT NULL,
  criterion TEXT NOT NULL,
  limitation TEXT NOT NULL
);

CREATE TABLE verification_record (
  verification_id TEXT PRIMARY KEY,
  candidate_id TEXT NOT NULL,
  verification_method TEXT NOT NULL,
  evidence_standard TEXT NOT NULL,
  result_summary TEXT NOT NULL,
  remaining_question TEXT NOT NULL
);

CREATE TABLE discovery_risk (
  risk_id TEXT PRIMARY KEY,
  risk_name TEXT NOT NULL,
  mathematical_problem TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE human_interpretation_record (
  interpretation_id TEXT PRIMARY KEY,
  candidate_id TEXT NOT NULL,
  novelty_review TEXT NOT NULL,
  significance_review TEXT NOT NULL,
  proof_status TEXT NOT NULL,
  credit_and_workflow_note TEXT NOT NULL
);

CREATE TABLE discovery_workflow (
  workflow_id TEXT PRIMARY KEY,
  stage TEXT NOT NULL,
  ai_role TEXT NOT NULL,
  evaluator_role TEXT NOT NULL,
  human_role TEXT NOT NULL,
  risk TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE proof_status_taxonomy (
  status_id TEXT PRIMARY KEY,
  status_name TEXT NOT NULL,
  meaning TEXT NOT NULL,
  promotion_requirement TEXT NOT NULL
);

INSERT INTO discovery_candidate VALUES
('cand_graph_invariant','Possible graph invariant bound','conjecture','AI-assisted pattern search','simple undirected graphs within finite search range','tested_on_examples','Does the pattern generalize beyond the finite search space?'),
('cand_combinatorial_program','Candidate combinatorial construction','program','program-search loop','evaluator captures the intended combinatorial objective','tested_on_examples','Can the construction be explained or proved?'),
('cand_proof_outline','AI-generated proof outline','proof_sketch','language model','definitions and lemmas are correctly cited','untested','Does every inference follow?'),
('cand_formal_statement','Formalized lemma candidate','formal_statement','AI formalization assistant','formal statement matches intended informal claim','untested','Does the formal statement prove the intended theorem?'),
('cand_geometry_auxiliary','Auxiliary construction for geometry problem','example','geometry reasoning system','diagram representation and geometry rules are correct','tested_on_examples','Is the auxiliary construction necessary, sufficient, and explainable?'),
('cand_formal_script','Generated formal proof script','formal_proof_script','AI proof assistant workflow','proof assistant environment, imports, and theorem statement are correct','machine_check_required','Does the checked script establish the intended theorem?');

INSERT INTO evaluator_record VALUES
('eval_graph_counterexamples','cand_graph_invariant','finite counterexample search','no counterexample among generated finite graphs','finite search does not prove universal truth'),
('eval_program_score','cand_combinatorial_program','programmatic objective evaluator','constraint satisfaction and improved objective score','may overfit evaluator rather than reveal structure'),
('eval_human_proof_review','cand_proof_outline','human proof review','each inference follows from definitions and accepted lemmas','review depends on expertise and time'),
('eval_lean_typecheck','cand_formal_statement','proof assistant parser and type checker','formal statement parses and type-checks','type-checking a statement is not proof of the theorem'),
('eval_geometry_engine','cand_geometry_auxiliary','symbolic geometry engine','construction and relations satisfy accepted geometry rules','symbolic validity may not produce explanatory proof'),
('eval_proof_assistant_acceptance','cand_formal_script','proof assistant checking','proof script accepted under formal rules','formal statement may not match intended informal claim');

INSERT INTO verification_record VALUES
('ver_graph','cand_graph_invariant','counterexample search plus proof attempt','finite evidence until theorem is proved','no counterexample in tested range','what theorem and hypotheses would make the pattern true?'),
('ver_program','cand_combinatorial_program','code review, tests, and mathematical explanation','program correctness plus mathematical proof of construction','candidate improves objective in synthetic tests','can the program behavior be converted into a theorem?'),
('ver_outline','cand_proof_outline','line-by-line proof check','valid inference under definitions and lemmas','requires independent verification','which steps are gaps?'),
('ver_formal_statement','cand_formal_statement','formal statement review and proof assistant workflow','formal proof required for theorem status','statement candidate requires proof','does the statement match the intended theorem?'),
('ver_geometry','cand_geometry_auxiliary','symbolic derivation plus human geometric explanation','derivable relation and readable proof','auxiliary construction candidate passes symbolic checks','can the construction be explained elegantly?'),
('ver_formal_script','cand_formal_script','proof assistant acceptance plus theorem statement audit','machine-checked derivation and intended-meaning review','requires local proof assistant check','what axioms, imports, and formal statement were used?');

INSERT INTO discovery_risk VALUES
('risk_fluent_falsehood','Fluent falsehood','generated explanation sounds correct but contains invalid reasoning','check every inference against definitions, examples, and proof obligations'),
('risk_false_conjecture','False conjecture','pattern fails outside tested examples','search for counterexamples, refine hypotheses, and prove or disprove'),
('risk_evaluator_overfitting','Evaluator overfitting','system optimizes a narrow metric rather than the mathematical problem','use multiple evaluators, held-out cases, human interpretation, and theoretical analysis'),
('risk_formal_mismatch','Formal mismatch','formal statement differs from intended theorem','translate formal statement back into prose and review hypotheses'),
('risk_false_novelty','False novelty','known result appears new because literature was not checked','perform literature search, terminology review, and expert consultation'),
('risk_credit_distortion','Credit distortion','human, community, library, or dataset labor is obscured','document tools, prompts, datasets, evaluators, formal libraries, proof labor, and human roles'),
('risk_uninterpretable_candidate','Uninterpretable candidate','candidate improves a score but does not reveal mathematical structure','require explanation, proof attempt, ablation, simplification, or structural analysis');

INSERT INTO human_interpretation_record VALUES
('interp_graph','cand_graph_invariant','requires literature review in graph theory and invariant bounds','possibly useful if it generalizes and connects to known invariants','not proved','record prompts, search space, evaluator, and human refinement'),
('interp_program','cand_combinatorial_program','requires comparison against known constructions','significant only if construction is explainable and general','tested but not proved','record generated code, evaluator, tests, and human analysis'),
('interp_outline','cand_proof_outline','not a discovery unless proof strategy is genuinely useful','useful as heuristic only','unverified','identify AI role as proposal generation'),
('interp_formal_statement','cand_formal_statement','requires theorem database and literature review','depends on theorem scope and relation to existing formal library','statement only','record formal environment and human statement review'),
('interp_geometry','cand_geometry_auxiliary','compare with known olympiad geometry solution methods','valuable if it reveals a transferable construction pattern','symbolically checked candidate','record diagram encoding, generated construction, and checked derivation'),
('interp_script','cand_formal_script','requires checking whether theorem already exists in library','depends on theorem importance and proof maintainability','machine check required','record model, prompt, proof assistant version, imports, and human review');

INSERT INTO discovery_workflow VALUES
('wf_generate','Generate','generate candidate examples, conjectures, code, proof sketches, or formal statements','none or preliminary filter','frame search space and define what counts as relevant','irrelevant or fluent but false output','classify output type and do not treat it as proof'),
('wf_test','Test','suggest tests or write test code','run finite checks, objective scoring, symbolic checks, or counterexample search','design meaningful edge cases and interpret results','overfitting to narrow evaluator','use multiple evaluators and held-out cases'),
('wf_prove','Prove','suggest lemmas, proof strategies, or formal proof scripts','proof assistant, theorem prover, or expert proof review','verify each inference and review formal statement','proof gap or formal mismatch','formalize or independently prove each step'),
('wf_interpret','Interpret','summarize, compare, or explain candidate results','literature review, expert review, and reproducibility review','judge significance, novelty, credit, and scope','generated novelty without mathematical significance','document workflow and place result within existing mathematics');

INSERT INTO proof_status_taxonomy VALUES
('status_untested','untested','generated candidate has not been checked','definition check, examples, tests, or proof attempt'),
('status_tested','tested_on_examples','candidate survived finite or computational tests','counterexample search, proof, or formal verification'),
('status_counterexample','counterexample_found','candidate fails under at least one valid case','reject or refine hypotheses'),
('status_informal_proof','proved_informally','human-readable proof has been produced','expert review or formalization where appropriate'),
('status_machine_checked','machine_checked','formal derivation accepted by proof assistant','formal statement review and interpretation'),
('status_rejected','rejected','candidate is false, irrelevant, or unsupported','document reason for rejection');
