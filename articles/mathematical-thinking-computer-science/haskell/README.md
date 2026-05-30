# Haskell Companion Scaffold

This Haskell folder supports **Mathematical Thinking for Computer Science**.

Haskell is useful here because algebraic data types, pattern matching, pure functions, recursion, and typed interfaces make computational structure explicit.

## What this folder demonstrates

- algorithm specifications as typed records;
- complexity classes as algebraic data types;
- recursive trees and structural recursion;
- finite automata and explicit transition functions;
- success/failure as a sum type;
- graph reachability scaffold;
- CSV output for reproducible audit artifacts.

## Run

```bash
cd haskell
make run
```

This writes generated artifacts to:

```text
../outputs/tables/haskell_algorithm_spec_audit.csv
../outputs/tables/haskell_dfa_audit.csv
../outputs/tables/haskell_structure_audit.csv
```

## Professional note

These examples support computer-science foundations, type modeling, automata, recursion, algorithm reasoning, and audit documentation. They do not replace proof, formal verification, testing, security review, or responsible computing review.
