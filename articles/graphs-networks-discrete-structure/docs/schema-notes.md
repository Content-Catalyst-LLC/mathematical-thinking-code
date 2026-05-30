# Schema Notes

The SQL schema models graph nodes, graph edges, bipartite edges, centrality cases, algorithm assumptions, and graph-model warnings.

## Core tables

- `graph_node`: node identifiers, labels, types, and interpretation.
- `graph_edge`: source, target, graph ID, directed flag, weights, relation type, evidence note, and interpretation.
- `bipartite_edge`: two-mode affiliation or assignment structure.
- `centrality_case`: centrality examples, interpretation risks, and mitigations.
- `graph_algorithm_audit`: graph algorithm assumptions and outputs.
- `graph_model_warning`: warnings for layout, edge meaning, centrality, weight, direction, and graph-based inference.

## Professional use cases

- graph theory instruction;
- network science demonstrations;
- knowledge graph provenance review;
- infrastructure dependency modeling;
- graph-based AI auditing;
- data-system graph schema design.
