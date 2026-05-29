# Proof Graph Schema

A proof graph is represented as a directed graph:

```text
G = (V, E)
```

where:

- `V` contains concepts, definitions, lemmas, theorems, examples, and proof steps.
- `E` contains directed dependency relations.
- edge labels describe the dependency relation, such as `supports`, `motivates`, `defines_context`, or `requires`.

## Minimal CSV edge schema

```text
source,target,relation,weight
```

## Interpretation

An edge from `A` to `B` means that `A` contributes to the justification, motivation, or interpretation of `B`.

## Professional uses

- proof-library planning;
- theorem dependency analysis;
- mathematical curriculum architecture;
- formalization roadmaps;
- proof-assistant migration planning;
- search and retrieval across mathematical knowledge bases.
