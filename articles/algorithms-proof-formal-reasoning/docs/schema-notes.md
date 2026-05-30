# Schema Notes

The SQL schema models algorithm specifications, proof obligations, invariants, termination arguments, complexity cases, graph-algorithm assumptions, evidence types, and formal-reasoning warnings.

## Core tables

- `algorithm_specification`: input domain, precondition, postcondition, termination measure, complexity, and responsible-use note.
- `proof_obligation`: proof type, claim, invariant or measure, status, and risk note.
- `invariant_case`: initialization, preservation, and termination-use notes.
- `termination_argument`: decreasing measure, lower bound, termination claim, and failure mode.
- `complexity_case`: growth class and dominant source.
- `graph_algorithm_assumption`: graph-type assumptions and interpretive warnings.
- `evidence_type`: evidence strengths and limitations.
- `formal_reasoning_warning`: risks and mitigations.

## Professional use cases

- algorithm review;
- proof-obligation tracking;
- formal reasoning pedagogy;
- audit documentation;
- safety-critical systems review;
- responsible computing governance.
