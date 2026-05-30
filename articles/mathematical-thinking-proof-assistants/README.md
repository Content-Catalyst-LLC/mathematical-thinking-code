# Mathematical Thinking and Proof Assistants

This companion folder supports the article **“Mathematical Thinking and Proof Assistants.”** It provides a reproducible mathematical-thinking scaffold for proof-assistant literacy workflows, formalization metadata, theorem-statement audits, proof-layer schemas, trust-boundary reviews, AI-to-proof-assistant verification pipelines, Haskell typed proof models, SQL formalization records, and responsible verification checklists.

The folder is designed for serious mathematical, educational, computational, and formal-methods use: documenting formalization projects, reviewing theorem statements, tracking trusted components, comparing proof-assistant traditions, auditing definitions as design choices, separating machine checking from human interpretation, and making proof-assistant work legible as mathematical knowledge architecture.

## Folder structure

```text
articles/mathematical-thinking-proof-assistants/
python/   formalization workflows, theorem-statement audits, trust-boundary maps, proof-layer summaries
r/        proof-assistant literacy summaries, trust-boundary summaries, skill and system summaries
julia/    proof-layer and trust-boundary demos
sql/      formalization project, theorem audit, proof boundary, skill, system, and workflow schemas
haskell/  typed proof-assistant models for layers, boundaries, systems, roles, and risks
rust/     command-line formalization metadata audit scaffold
go/       proof-assistant risk and skill summary scaffold
cpp/      proof-layer and trust-boundary count examples
fortran/  define-state-prove-check-interpret matrix examples
c/        low-level formalization utility examples
docs/     formalization notes, trust notes, AI workflow notes, education notes, validation plan
data/     synthetic scholarly metadata for proof systems, projects, theorem audits, trust boundaries, skills, workflows
outputs/  generated tables, DOT files, and audit artifacts
```

## Mathematical themes

- proof assistants as a new medium of mathematical proof
- formal language, proof checker, library, and interactive proof state
- informal proof versus machine-checkable formal proof
- foundations: type theory, higher-order logic, set theory, constructive and classical reasoning
- definitions as design decisions
- proof as program, proof as object, proof as reusable infrastructure
- mathematical libraries, dependency graphs, naming conventions, and community maintenance
- automation inside proof assistants
- trust boundaries: formal statement, kernel, axioms, libraries, foundations, intended meaning
- AI-to-proof-assistant workflows where AI proposes, the proof assistant checks, and the human interprets
- responsible verification and mathematical authority

## Suggested run order

From this article folder:

```bash
python3 python/proof_assistant_workflow.py
python3 python/responsible_verification_audit.py

Rscript r/proof_assistant_summary.R

julia julia/proof_layer_demo.jl

sqlite3 outputs/tables/mathematical_thinking_proof_assistants.sqlite < sql/schema.sql
sqlite3 outputs/tables/mathematical_thinking_proof_assistants.sqlite < sql/analysis_queries.sql

cd haskell && make run
cd ../rust && cargo run -- ../data/raw/formalization_projects.csv
cd ../go && go run .
cd ../cpp && make run
cd ../fortran && gfortran proof_assistant_matrix.f90 -o proof_assistant_matrix && ./proof_assistant_matrix
cd ../c && cc -std=c11 formalization_index.c -o formalization_index && ./formalization_index
```

## Interpretation

The generated outputs support reproducible audits of proof-assistant work. They do not replace mathematical proof, expert formalization, proof-assistant checking, theorem-prover expertise, software verification, peer review, or ethical review.
