# Validation Plan

## Recursive definitions

- Confirm base case exists.
- Confirm recursive rule exists.
- Confirm each recursive step reduces a size or structural measure.
- Confirm the interpretation matches the domain.

## Recurrence relations

- Verify initial values.
- Generate finite audit tables.
- Label proof status separately from finite evidence.
- Compare iterative, memoized, and recursive implementations where useful.

## Trees and grammars

- Confirm all parent references are valid.
- Confirm leaves terminate recursion.
- Export DOT files for visual inspection.
- Distinguish grammar base rules from recursive productions.

## Algorithms

- Document base case, reduction, combination, complexity, and correctness argument.
- Identify overlapping subproblems.
- Use memoization or tabulation where applicable.
- Use visited sets for graph traversal.

## Recursive models

- Document initial state, update rule, stopping condition, and risk note.
- Audit error propagation and feedback effects.
- Validate against external observations where possible.

## Responsible-use note

Synthetic examples in this repository are for methods demonstration. Applied use requires proof, formal verification, model validation, stakeholder review, and consequences analysis.
