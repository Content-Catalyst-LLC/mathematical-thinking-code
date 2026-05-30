# Recursion and Recursive Thinking

This companion folder supports the article **“Recursion and Recursive Thinking.”** It provides a reproducible mathematical-thinking scaffold for recursive definitions, recurrence relations, induction, structural recursion, tree traversal, divide-and-conquer algorithms, dynamic programming, memoization, formal grammar, Haskell algebraic data types, SQL schemas, and responsible interpretation of recursive systems.

The folder is designed for serious mathematical, computational, educational, and systems use: recursion pedagogy, proof-literacy demonstrations, recurrence workflows, recursive data-structure modeling, dynamic programming audits, grammar/syntax scaffolds, algorithm correctness documentation, recursive state-model validation, and risk documentation for feedback and self-reinforcing systems.

## Folder structure

```text
articles/recursion-recursive-thinking/
python/   recursive definitions, recurrence tables, tree traversal, grammar, memoization, model audits
r/        recurrence tables, growth audits, and dynamic-programming summaries
julia/    recursion, memoization, divide-and-conquer, recurrence, and tree examples
sql/      recursive-definition, recurrence, grammar, model-audit, and warning schemas
haskell/  algebraic data types for trees, expressions, grammars, recursive definitions, and audits
rust/     command-line recurrence and tree-audit scaffold
go/       recursive-model and warning metadata analysis scaffold
cpp/      efficient recurrence, tree, and divide-and-conquer examples
fortran/  recurrence tables and iterative dynamic-programming examples
c/        low-level factorial, Fibonacci, tree-array, and recurrence utilities
docs/     recursion notes, induction notes, tree notes, grammar notes, ethics notes, validation plan
data/     synthetic recursive definitions, recurrence cases, tree nodes, grammar rules, model updates, warnings
outputs/  generated tables, DOT files, and audit artifacts
```

## Mathematical themes

- base cases, recursive rules, stopping conditions, and termination measures
- recurrence relations and recursive sequence generation
- induction, strong induction, and structural induction
- trees, expression trees, proof trees, and nested structures
- self-similarity and iterative construction
- divide-and-conquer algorithms and recurrence costs
- dynamic programming and memoized recursion
- recursive grammar and formal languages
- Haskell typed modeling of recursive data
- recursive state models, feedback, error propagation, and responsible interpretation

## Suggested run order

From this article folder:

```bash
python3 python/recursive_structure_workflow.py
python3 python/recursive_model_audit.py

Rscript r/recurrence_growth_audit.R

julia julia/recursion_dynamic_demo.jl

sqlite3 outputs/tables/recursion_recursive_thinking.sqlite < sql/schema.sql
sqlite3 outputs/tables/recursion_recursive_thinking.sqlite < sql/analysis_queries.sql

cd haskell && make run
cd ../rust && cargo run -- ../data/raw/recursive_definitions.csv
cd ../go && go run .
cd ../cpp && make run
cd ../fortran && gfortran recurrence_audit.f90 -o recurrence_audit && ./recurrence_audit
cd ../c && cc -std=c11 recursion_utils.c -o recursion_utils && ./recursion_utils
```

## Interpretation

The generated outputs support reproducible audits of recursive definitions, recurrence tables, structural recursion, tree traversals, grammar derivations, memoization effects, recursive model updates, and recursion-risk warnings. They do not replace proof, formal verification, peer review, model validation, or domain-specific interpretation.
