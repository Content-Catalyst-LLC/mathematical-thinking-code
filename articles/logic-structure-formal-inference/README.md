# Logic and the Structure of Formal Inference

This companion folder supports the article **“Logic and the Structure of Formal Inference.”** It provides a reproducible mathematical logic scaffold for truth tables, propositional inference, quantifier patterns, derivation graphs, inference-rule metadata, proof-system comparison, counterexample audits, and formalization planning.

The folder is designed for serious mathematical and computational use: logic education, proof literacy, formal-methods preparation, theorem-library planning, proof-assistant workflows, programming-language reasoning, and reproducible mathematical documentation.

## Folder structure

```text
articles/logic-structure-formal-inference/
python/   truth tables, inference-rule audits, derivation graphs, and quantifier examples
r/        finite-domain quantifier audits and implication/counterexample checks
julia/    formal inference demonstrations and truth-functional equivalence checks
sql/      proposition, inference-rule, derivation, proof-system, and counterexample schemas
haskell/  algebraic data types, formal inference, proof trees, recursion, type-structured examples
rust/     command-line inference-rule and truth-table utility scaffold
go/       derivation graph and inference metadata analysis scaffold
cpp/      efficient truth-table and derivation examples
fortran/  propositional truth-table demonstrations
c/        low-level logic connective and implication utilities
docs/     model notes, proof-system notes, validation plan, schema notes
data/     synthetic formal-logic datasets
outputs/  generated tables and graph artifacts
```

## Mathematical themes

- Logic as the structure of valid inference
- Propositions, predicates, truth conditions, and quantifiers
- Logical connectives and truth-functional equivalence
- Implication, converse, inverse, and contrapositive
- Formal inference rules and derivation steps
- Validity, soundness, completeness, and consistency
- Proof trees, proof graphs, and proof-system metadata
- Counterexamples as refutations of universal claims
- Formal verification and proof-assistant readiness

## Suggested run order

From this article folder:

```bash
python3 python/truth_table_inference.py
python3 python/derivation_graph_analysis.py

Rscript r/quantifier_counterexample_audit.R

julia julia/formal_inference_demo.jl

sqlite3 outputs/tables/formal_inference.sqlite < sql/schema.sql
sqlite3 outputs/tables/formal_inference.sqlite < sql/analysis_queries.sql

cd rust && cargo run -- ../data/raw/inference_rules.csv
cd ../go && go run .
cd ../cpp && make run
cd ../fortran && gfortran truth_tables.f90 -o truth_tables && ./truth_tables
cd ../c && cc -std=c11 logic_connectives.c -o logic_connectives && ./logic_connectives
```

## Interpretation

The generated outputs support logic education, formal inference inspection, proof-system planning, and reproducible reasoning. They do not replace mathematical proof, proof-assistant checking, peer review, or expert judgment about whether a formalization matches its intended meaning.
