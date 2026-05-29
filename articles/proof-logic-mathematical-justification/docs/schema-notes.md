# Schema Notes

The SQL schema models proof architecture.

## Core tables

- `claim`: definitions, lemmas, theorems, false conjectures, and inference rules.
- `assumption`: hypotheses, premises, and domain conditions.
- `proof_step`: ordered proof steps and justifications.
- `proof_dependency`: directed support relations among claims.
- `inference_rule`: reusable proof-pattern metadata.
- `counterexample`: refutation records and lessons.

## Professional use cases

- theorem-library planning;
- proof-assistant formalization preparation;
- proof literacy education;
- mathematical knowledge architecture;
- dependency audits;
- counterexample documentation;
- separation of finite evidence from proof.
