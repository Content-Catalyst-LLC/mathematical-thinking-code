# Haskell Companion Scaffold

This Haskell folder supports **The Evolution of Algebraic Notation**.

Haskell is useful here because algebraic expressions can be represented naturally as algebraic data types. This makes the history of algebraic notation computationally inspectable: symbols become trees, transformations become functions, and notation styles become typed alternatives.

## What this folder demonstrates

- typed algebraic expression trees;
- pretty-printing of symbolic expressions;
- node-count and depth metrics;
- polynomial identity checks;
- notation-style alternatives;
- symbol-context records;
- CSV output for reproducible audit artifacts.

## Run

```bash
cd haskell
make run
```

This writes generated artifacts to:

```text
../outputs/tables/haskell_expression_tree_audit.csv
../outputs/tables/haskell_polynomial_identity_audit.csv
../outputs/tables/haskell_symbol_context_audit.csv
```

## Professional note

These examples support notation-history pedagogy, symbolic expression modeling, computer-algebra literacy, and responsible notation interpretation. They do not replace historical scholarship, formal proof, symbolic algebra systems, or expert mathematical review.
