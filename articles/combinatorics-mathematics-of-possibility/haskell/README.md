# Haskell Companion Scaffold

This Haskell folder supports **Combinatorics and the Mathematics of Possibility**.

Haskell is useful here because choice rules, repetition rules, counting problems, counting methods, and validation notes can be represented explicitly with algebraic data types.

## What this folder demonstrates

- typed combinatorial problem definitions;
- distinction between order and membership;
- distinction between repetition allowed and not allowed;
- permutation and combination counts;
- Pascal rows and binomial coefficients;
- search-space growth;
- simple graph counts;
- Fibonacci-style tiling counts;
- structured CSV output for possibility-space audits.

## Run

```bash
cd haskell
make run
```

This writes generated artifacts to:

```text
../outputs/tables/haskell_counting_problem_audit.csv
../outputs/tables/haskell_pascal_audit.csv
../outputs/tables/haskell_search_growth_audit.csv
```

## Professional note

These examples support combinatorics pedagogy, enumeration workflows, search-space audits, and typed modeling of counting assumptions. They do not replace proof, formal verification, model validation, or domain expertise.
