# Validation Plan

## Proof metadata

- Confirm every proof step links to an existing claim.
- Confirm every assumption links to an existing claim.
- Confirm every dependency edge has valid source and target records.
- Check that proof-step order is positive and unique within each claim where required.

## Dependency graph

- Detect cycles where acyclic proof support is expected.
- Export a topological order when possible.
- Identify high-dependency claims and reusable lemmas.
- Distinguish background inference rules from theorem-specific lemmas.

## Induction audits

- Treat finite checks as illustrative only.
- Record base case and inductive step separately in proof notes.
- Avoid presenting finite agreement as proof.

## Counterexample workflows

- Link every counterexample to the exact claim it refutes or refines.
- Record the failure mode and mathematical lesson.
- Preserve the distinction between refuting a theorem and refining a hypothesis.

## Formalization readiness

- Identify definitions needed in a target proof assistant.
- Break informal arguments into formalizable obligations.
- Record assumptions explicitly before formal translation.
