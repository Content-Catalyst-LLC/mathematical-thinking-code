# Haskell Companion Scaffold

This Haskell folder supports **Algorithms, Proof, and Formal Reasoning**.

Haskell is useful here because typed records, algebraic data types, pattern matching, and pure functions make specifications, alternatives, and structural claims explicit.

## What this folder demonstrates

- algorithm specifications as typed records;
- proof methods as algebraic data types;
- complexity classes as algebraic data types;
- success/failure as a sum type;
- sortedness and multiset postcondition checks;
- CSV output for reproducible audit artifacts.

## Run

```bash
cd haskell
make run
```

This writes generated artifacts to:

```text
../outputs/tables/haskell_algorithm_spec_audit.csv
../outputs/tables/haskell_sort_postcondition_audit.csv
../outputs/tables/haskell_result_type_audit.csv
```

## Professional note

These examples support algorithmic proof literacy, typed specification modeling, correctness-audit documentation, and formal reasoning pedagogy. They do not replace formal proof, verification, testing, security review, or responsible computing review.
