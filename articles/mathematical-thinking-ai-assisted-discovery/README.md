# Mathematical Thinking and AI-Assisted Discovery

This companion folder supports the article **“Mathematical Thinking and AI-Assisted Discovery.”** It provides a reproducible mathematical-thinking scaffold for AI-assisted discovery audits, conjecture-generation records, evaluator design notes, candidate-program testing workflows, formalization review tables, proof-status classification, Haskell typed discovery models, SQL discovery schemas, and responsible AI-mathematics checklists.

The folder is designed for serious mathematical, computational, educational, and AI-governance use: classifying AI-generated mathematical outputs, separating suggestion from proof, documenting evaluator design, tracking conjecture status, testing candidate programs, reviewing formal statements, recording proof status, auditing discovery risks, and preserving human mathematical judgment in AI-assisted workflows.

## Folder structure

```text
articles/mathematical-thinking-ai-assisted-discovery/
python/   discovery candidate audits, evaluator workflows, proof-status summaries, responsible AI review
r/        discovery-risk summaries, candidate-status tables, evaluator and human-review summaries
julia/    generate-test-prove-interpret demo workflows
sql/      discovery candidate, evaluator, verification, risk, interpretation, and workflow schemas
haskell/  typed discovery models for candidate types, evidence statuses, stages, risks, and responsibilities
rust/     command-line discovery-candidate metadata audit scaffold
go/       discovery-risk and human-review summary scaffold
cpp/      evidence-status and candidate-type count examples
fortran/  generate-test-prove-interpret matrix examples
c/        low-level discovery candidate utility examples
docs/     AI discovery notes, evaluator notes, proof-status notes, ethics notes, validation plan
data/     synthetic scholarly metadata for candidates, evaluators, verification records, risks, interpretation, workflows
outputs/  generated tables, DOT files, and audit artifacts
```

## Mathematical themes

- AI as discovery amplifier rather than mathematical authority
- generated examples, conjectures, programs, proof sketches, formal statements, and proof scripts
- generation-evaluation loops and evaluator design
- program search as an auditable discovery method
- counterexample search, finite testing, proof, and formal verification
- proof assistants as verification infrastructure for AI-generated formal work
- human mathematical roles: framing, representation choice, proof literacy, formalization literacy, interpretation, and taste
- risks: fluent falsehood, false conjecture, evaluator overfitting, formal mismatch, false novelty, and credit distortion
- responsible documentation of tools, prompts, evaluators, proof labor, and human interpretation

## Suggested run order

From this article folder:

```bash
python3 python/ai_discovery_workflow.py
python3 python/responsible_ai_discovery_audit.py

Rscript r/ai_discovery_summary.R

julia julia/generate_test_prove_interpret_demo.jl

sqlite3 outputs/tables/mathematical_thinking_ai_discovery.sqlite < sql/schema.sql
sqlite3 outputs/tables/mathematical_thinking_ai_discovery.sqlite < sql/analysis_queries.sql

cd haskell && make run
cd ../rust && cargo run -- ../data/raw/discovery_candidates.csv
cd ../go && go run .
cd ../cpp && make run
cd ../fortran && gfortran ai_discovery_matrix.f90 -o ai_discovery_matrix && ./ai_discovery_matrix
cd ../c && cc -std=c11 discovery_candidate_index.c -o discovery_candidate_index && ./discovery_candidate_index
```

## Interpretation

The generated outputs support reproducible audits of AI-assisted mathematical discovery workflows. They do not replace mathematical proof, formal verification, expert review, literature review, theorem-prover checking, numerical validation, software testing, or ethical review.
