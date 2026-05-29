# Validation Plan

## Sequence classification

- Verify finite difference calculations manually on small sequences.
- Treat arithmetic, quadratic, geometric, and periodic classifications as heuristics unless tied to formulas or proof.
- Include deliberately misleading examples to prevent overconfidence.

## Graph invariants

- Confirm vertex, edge, degree-sequence, component, and cycle-rank outputs.
- Treat degree sequence as a partial invariant, not a complete graph-isomorphism classifier.

## Dynamic systems

- Record update rules and parameters explicitly.
- Treat finite iterations as sampled behavior, not exhaustive analysis.
- Separate qualitative interpretation from proven stability or chaos claims.

## Probabilistic experiments

- Use fixed seeds for reproducibility.
- Distinguish observed frequencies from theoretical probabilities.
- Avoid interpreting random streaks as meaningful structure without justification.

## Proof status

- Track whether a pattern is conjectural, empirically supported, proved under assumptions, parameter-dependent, or refuted.
