# Validation Plan

## Symbolic expressions

- Confirm expression trees render correctly.
- Confirm evaluation uses explicitly supplied environments.
- Confirm unbound variables are treated as errors.
- Track symbolic transformation separately from numerical evaluation.

## Representation translation

- Confirm every representation has an associated mathematical object.
- Confirm translation rules state their validity conditions.
- Check that graph-to-matrix translation fixes vertex order.
- Distinguish sampled equality from proof of full-domain equality.

## Notation audit

- Identify overloaded symbols.
- Record hidden domains and assumptions.
- Clarify exact equality, equivalence, congruence, isomorphism, and approximation.
- Document what the representation preserves and omits.

## Formalization readiness

- Translate prose statements into formal claim structures.
- Define predicates and domains explicitly.
- Check that formal statements match intended mathematical meaning.
