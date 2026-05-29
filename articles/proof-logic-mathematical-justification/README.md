# Proof and the Logic of Mathematical Justification

This companion folder supports the article **“Proof and the Logic of Mathematical Justification.”** It provides a reproducible mathematical reasoning scaffold for proof metadata, theorem dependencies, inference rules, induction audits, counterexample workflows, proof-status tracking, and formalization planning.

The folder is designed for professional mathematical use: proof literacy, mathematical education, theorem-library planning, formalization preparation, proof-assistant workflows, reproducible documentation, and dependency-aware mathematical knowledge architecture.

## Folder structure

```text
articles/proof-logic-mathematical-justification/
python/   proof dependency graphs, inference audits, induction checks, and counterexample workflows
r/        finite evidence vs proof-status audits and induction-summary workflows
julia/    induction-style property tests and inference-rule demonstrations
sql/      claim, assumption, proof-step, dependency, theorem, and counterexample schemas
haskell/  algebraic data types, formal inference, proof trees, recursion, type-structured examples
rust/     command-line proof-dependency and inference-rule utility scaffold
go/       proof graph and dependency analysis scaffold
cpp/      efficient proof-graph and induction examples
fortran/  induction-style sequence verification examples
c/        low-level finite-proof-audit and counterexample utility examples
docs/     proof-model notes, formalization notes, validation plan, schema notes
data/     synthetic mathematical proof datasets
outputs/  generated tables and graph artifacts
```

## Mathematical themes

- Proof as accountable justification
- Direct proof, contradiction, induction, construction, and counterexample
- Claim, assumption, inference, conclusion structure
- Proof dependency graphs and theorem architecture
- Finite evidence versus proof
- Inference-rule metadata and proof-status tracking
- Counterexample discipline and theorem refinement
- Formalization planning for proof assistants
- Computation as support for proof literacy, not a replacement for proof

## Suggested run order

From this article folder:

```bash
python3 python/proof_dependency_analysis.py
python3 python/induction_counterexample_audit.py

Rscript r/proof_status_audit.R

julia julia/induction_inference_demo.jl

sqlite3 outputs/tables/proof_logic.sqlite < sql/schema.sql
sqlite3 outputs/tables/proof_logic.sqlite < sql/analysis_queries.sql

cd rust && cargo run -- ../data/raw/proof_dependencies.csv
cd ../go && go run .
cd ../cpp && make run
cd ../fortran && gfortran induction_audit.f90 -o induction_audit && ./induction_audit
cd ../c && cc -std=c11 proof_audit.c -o proof_audit && ./proof_audit
```

## Interpretation

The generated artifacts help organize claims, proof steps, dependencies, finite evidence, and counterexamples. They do not replace proof, formal verification, peer review, or expert mathematical judgment.
