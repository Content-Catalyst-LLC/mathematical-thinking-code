# Schema Notes

The SQL schema models discovery candidates, evaluators, verification records, discovery risks, human interpretation records, discovery workflows, and proof-status taxonomy.

## Core tables

- `discovery_candidate`: generated candidate and status.
- `evaluator_record`: evaluator type, criterion, limitation.
- `verification_record`: method, evidence standard, result summary, remaining question.
- `discovery_risk`: risk, mathematical problem, mitigation.
- `human_interpretation_record`: novelty, significance, proof status, workflow credit.
- `discovery_workflow`: AI role, evaluator role, human role across stages.
- `proof_status_taxonomy`: status meaning and promotion requirement.

## Professional use cases

- AI-assisted mathematical discovery audits;
- conjecture tracking;
- evaluator design review;
- program-search workflow documentation;
- proof-status classification;
- formalization review;
- responsible AI mathematics governance.
