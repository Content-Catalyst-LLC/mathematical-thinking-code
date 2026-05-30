#!/usr/bin/env python3
"""
Computer science foundations workflow for:
"Mathematical Thinking for Computer Science"

This workflow demonstrates:
- algorithm specifications and invariant metadata;
- complexity growth tables;
- graph traversal and reachability;
- finite automaton simulation;
- modular arithmetic examples;
- Graphviz DOT export for a dependency graph.
"""

from __future__ import annotations

import csv
from collections import defaultdict, deque
from math import log2
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def write_concept_audit() -> None:
    with (OUT_TABLES / "computational_concept_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "concept_id",
                "name",
                "concept_type",
                "mathematical_structure",
                "computer_science_use",
                "interpretation",
                "audit_question",
            ],
        )
        writer.writeheader()

        for row in load_csv("computational_concepts.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "What structure is represented, what assumptions are required, and what should not be inferred?",
                }
            )


def write_algorithm_spec_audit() -> None:
    with (OUT_TABLES / "algorithm_specification_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "algorithm_id",
                "name",
                "input_domain",
                "output_specification",
                "invariant_note",
                "complexity_note",
                "correctness_note",
                "responsible_use_note",
                "review_question",
            ],
        )
        writer.writeheader()

        for row in load_csv("algorithm_specifications.csv"):
            writer.writerow(
                {
                    **row,
                    "review_question": "Are the precondition, postcondition, invariant, complexity claim, and downstream interpretation explicit?",
                }
            )


def write_complexity_growth() -> None:
    with (OUT_TABLES / "complexity_growth_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["n", "log2_n", "linear_n", "n_log2_n", "quadratic_n2", "exponential_2n", "interpretation"],
        )
        writer.writeheader()

        for n in range(1, 31):
            writer.writerow(
                {
                    "n": n,
                    "log2_n": round(log2(n), 6),
                    "linear_n": n,
                    "n_log2_n": round(n * log2(n), 6),
                    "quadratic_n2": n * n,
                    "exponential_2n": 2 ** n,
                    "interpretation": "growth rate shapes scalability and feasibility",
                }
            )


def build_graph(graph_id: str, directed: bool = False) -> dict[str, set[str]]:
    graph: dict[str, set[str]] = defaultdict(set)

    for row in load_csv("graph_edges.csv"):
        if row["graph_id"] != graph_id:
            continue
        source = row["source"]
        target = row["target"]
        graph[source].add(target)
        graph.setdefault(target, set())
        if not directed and row["directed"].lower() == "false":
            graph[target].add(source)

    return dict(graph)


def bfs_distances(graph: dict[str, set[str]], start: str) -> dict[str, int]:
    distances = {start: 0}
    queue: deque[str] = deque([start])

    while queue:
        node = queue.popleft()
        for neighbor in sorted(graph.get(node, set())):
            if neighbor not in distances:
                distances[neighbor] = distances[node] + 1
                queue.append(neighbor)

    return distances


def write_graph_audit() -> None:
    graph = build_graph("cs_graph", directed=False)

    with (OUT_TABLES / "graph_reachability_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["start_node", "reachable_nodes", "distances", "degree", "interpretation"],
        )
        writer.writeheader()

        for node in sorted(graph):
            distances = bfs_distances(graph, node)
            writer.writerow(
                {
                    "start_node": node,
                    "reachable_nodes": " ".join(sorted(distances)),
                    "distances": "; ".join(f"{k}:{v}" for k, v in sorted(distances.items())),
                    "degree": len(graph[node]),
                    "interpretation": "graph traversal formalizes reachability over discrete relationships",
                }
            )

    dependency = build_graph("cs_dependency", directed=True)
    with (OUT_FIGURES / "cs_dependency_graph.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph cs_dependency {\n")
        dot.write('  graph [rankdir="LR"];\n')
        for source, targets in sorted(dependency.items()):
            if not targets:
                dot.write(f'  "{source}";\n')
            for target in sorted(targets):
                dot.write(f'  "{source}" -> "{target}";\n')
        dot.write("}\n")


def simulate_even_ones(value: str) -> tuple[bool, str]:
    state = "even"
    for char in value:
        if char not in {"0", "1"}:
            raise ValueError("input must be a binary string")
        if char == "1":
            state = "odd" if state == "even" else "even"
    return state == "even", state


def write_automata_audit() -> None:
    examples = ["", "0", "1", "11", "101", "1011", "1111", "10010"]
    with (OUT_TABLES / "finite_automata_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["automaton_id", "input", "final_state", "accepted", "interpretation"])
        writer.writeheader()

        for value in examples:
            accepted, final_state = simulate_even_ones(value)
            writer.writerow(
                {
                    "automaton_id": "dfa_even_ones",
                    "input": value or "epsilon",
                    "final_state": final_state,
                    "accepted": accepted,
                    "interpretation": "finite-state memory tracks parity of 1 symbols",
                }
            )


def write_modular_audit() -> None:
    with (OUT_TABLES / "modular_arithmetic_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["n", "mod_7", "mod_10", "mod_97", "interpretation"])
        writer.writeheader()

        for n in range(0, 51):
            writer.writerow(
                {
                    "n": n,
                    "mod_7": n % 7,
                    "mod_10": n % 10,
                    "mod_97": n % 97,
                    "interpretation": "modular arithmetic maps values into finite residue classes",
                }
            )


def main() -> None:
    write_concept_audit()
    write_algorithm_spec_audit()
    write_complexity_growth()
    write_graph_audit()
    write_automata_audit()
    write_modular_audit()

    print("Computer science foundations workflow complete.")
    print(f"  {OUT_TABLES / 'computational_concept_audit.csv'}")
    print(f"  {OUT_TABLES / 'algorithm_specification_audit.csv'}")
    print(f"  {OUT_TABLES / 'complexity_growth_audit.csv'}")
    print(f"  {OUT_TABLES / 'graph_reachability_audit.csv'}")
    print(f"  {OUT_TABLES / 'finite_automata_audit.csv'}")
    print(f"  {OUT_TABLES / 'modular_arithmetic_audit.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'cs_dependency_graph.dot'}")


if __name__ == "__main__":
    main()
