# Schema Notes

The SQL schema models scientific model records, assumptions, variables and parameters, calibration, validation, uncertainty, sensitivity, risks, and responsible modeling checks.

## Core tables

- `scientific_model_record`: type, purpose, target system, intended use, scope.
- `model_assumption`: assumption type and failure consequence.
- `variable_parameter_record`: role, unit, and uncertainty note.
- `calibration_record`: method, data used, risk, review question.
- `validation_record`: validation type, evidence, limitation, credibility note.
- `uncertainty_source`: source type, description, mitigation.
- `sensitivity_record`: tested factor, method, finding, decision relevance.
- `model_risk`: risk, problem, mitigation.
- `responsible_modeling_check`: represent-relate-test-revise-responsibility workflow.

## Professional use cases

- scientific model audits;
- validation planning;
- uncertainty source tracking;
- sensitivity analysis documentation;
- policy-facing model governance;
- AI-assisted scientific modeling review.
