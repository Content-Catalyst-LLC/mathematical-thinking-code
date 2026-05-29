# Schema Notes

The SQL schema models formal inference as structured metadata.

## Core tables

- `proposition`: statements and logical types.
- `inference_rule`: reusable formal inference patterns.
- `quantifier_pattern`: proof and refutation strategies for quantifier forms.
- `proof_system`: proof-system comparison records.
- `derivation_step`: ordered steps in derivations.
- `derivation_dependency`: directed edges among rules and derivation steps.
- `counterexample`: refutations linked to proposition records.

## Professional use cases

- logic education;
- proof-system comparison;
- proof-assistant planning;
- formal-methods documentation;
- theorem metadata;
- counterexample tracking;
- derivation graph analysis.
