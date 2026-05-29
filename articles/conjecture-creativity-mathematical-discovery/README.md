# Conjecture, Creativity, and Mathematical Discovery

This companion folder supports the article **“Conjecture, Creativity, and Mathematical Discovery.”** It provides a reproducible mathematical-thinking scaffold for conjecture generation, finite-evidence audits, counterexample search, proof-status tracking, graph-invariant exploration, sequence-pattern discovery, experimental mathematics, and structured documentation of discovery workflows.

The folder is designed for serious mathematical and computational use: mathematical education, exploratory research, theorem metadata, proof-status documentation, counterexample catalogs, graph search, computational experimentation, formalization planning, and reproducible mathematical knowledge architecture.

## Folder structure

```text
articles/conjecture-creativity-mathematical-discovery/
python/   conjecture metadata, finite audits, counterexample search, graph-invariant discovery
r/        finite evidence audits, sequence conjecture workflows, and counterexample summaries
julia/    dynamic exploration, sequence testing, and computational discovery examples
sql/      conjecture, evidence, counterexample, proof-attempt, method, and status schemas
haskell/  algebraic data types for conjectures, evidence, proof status, and counterexample search
rust/     command-line conjecture and finite-audit utility scaffold
go/       graph invariant and conjecture metadata analysis scaffold
cpp/      efficient sequence and graph-discovery examples
fortran/  finite evidence and numerical conjecture tables
c/        low-level sequence and counterexample-search utilities
docs/     discovery notes, proof-status notes, validation plan, schema notes
data/     synthetic mathematical discovery datasets
outputs/  generated tables and graph artifacts
```

## Mathematical themes

- conjecture as disciplined mathematical imagination
- examples, special cases, and finite evidence
- sequence pattern discovery and false-pattern discipline
- counterexamples as mathematical discovery
- graph invariants and structural testing
- computational experimentation and proof-status tracking
- Haskell algebraic data types for conjecture metadata
- proof attempts, failed strategies, and refinement
- responsible use of AI and computation in mathematical discovery

## Suggested run order

From this article folder:

```bash
python3 python/conjecture_evidence_workflow.py
python3 python/graph_invariant_discovery.py

Rscript r/conjecture_finite_evidence_audit.R

julia julia/discovery_exploration.jl

sqlite3 outputs/tables/conjecture_discovery.sqlite < sql/schema.sql
sqlite3 outputs/tables/conjecture_discovery.sqlite < sql/analysis_queries.sql

cd haskell && make run
cd ../rust && cargo run -- ../data/raw/conjectures.csv
cd ../go && go run .
cd ../cpp && make run
cd ../fortran && gfortran finite_evidence.f90 -o finite_evidence && ./finite_evidence
cd ../c && cc -std=c11 counterexample_search.c -o counterexample_search && ./counterexample_search
```

## Interpretation

The generated outputs support mathematical exploration and reproducible discovery documentation. Finite evidence, simulations, and computational searches can suggest conjectures and identify counterexamples. They do not replace proof, formal verification, peer review, or expert mathematical interpretation.
