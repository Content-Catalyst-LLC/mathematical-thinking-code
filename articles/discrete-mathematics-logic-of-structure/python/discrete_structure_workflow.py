#!/usr/bin/env python3
"""
Discrete structure workflow for:
"Discrete Mathematics and the Logic of Structure"

This workflow demonstrates:
- graph traversal and degree audits;
- connected components;
- combinatorial counting;
- recurrence table generation;
- modular residue cycles.
"""

from __future__ import annotations

import csv
from collections import defaultdict, deque
from math import comb, factorial
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


Graph = dict[str, set[str]]


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def build_undirected_graph(graph_id: str) -> Graph:
    graph: Graph = defaultdict(set)
    for row in load_csv("graph_edges.csv"):
        if row["graph_id"] != graph_id:
            continue
        source = row["source"]
        target = row["target"]
        graph[source].add(target)
        if row["directed"].lower() == "false":
            graph[target].add(source)
    for row in load_csv("discrete_objects.csv"):
        if row["object_type"] == "vertex":
            graph.setdefault(row["name"].replace("Vertex ", ""), set())
    return dict(graph)


def connected_component(graph: Graph, start: str) -> set[str]:
    visited: set[str] = set()
    queue: deque[str] = deque([start])

    while queue:
        node = queue.popleft()
        if node in visited:
            continue
        visited.add(node)
        queue.extend(sorted(graph.get(node, set()) - visited))

    return visited


def write_graph_audit() -> None:
    graph = build_undirected_graph("graph_main")

    with (OUT_TABLES / "graph_degree_component_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["vertex", "degree", "component_from_vertex", "component_size", "interpretation"],
        )
        writer.writeheader()

        for vertex in sorted(graph):
            component = connected_component(graph, vertex)
            writer.writerow(
                {
                    "vertex": vertex,
                    "degree": len(graph[vertex]),
                    "component_from_vertex": " ".join(sorted(component)),
                    "component_size": len(component),
                    "interpretation": "graph structure is defined by vertices and edges, not by drawing layout",
                }
            )

    dot_path = OUT_FIGURES / "graph_main.dot"
    with dot_path.open("w", encoding="utf-8") as dot:
        dot.write("graph graph_main {\n")
        dot.write('  graph [rankdir="LR"];\n')
        for source, neighbors in sorted(graph.items()):
            if not neighbors:
                dot.write(f'  "{source}";\n')
            for target in sorted(neighbors):
                if source < target:
                    dot.write(f'  "{source}" -- "{target}";\n')
        dot.write('  note [shape=box, label="Graph layout is visual; adjacency is the discrete structure"];\n')
        dot.write("}\n")


def write_combinatorics_audit() -> None:
    with (OUT_TABLES / "combinatorics_counting_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["case_id", "name", "method", "computed_count", "interpretation"],
        )
        writer.writeheader()

        for row in load_csv("combinatorics_cases.csv"):
            method = row["method"]
            case_id = row["case_id"]
            n = int(row["n"])
            k_text = row["k"]

            if method == "combination":
                count = comb(n, int(k_text))
            elif method == "permutation":
                k = int(k_text)
                count = factorial(n) // factorial(n - k)
            elif method == "multiplication_principle":
                count = 2 ** n
            elif method == "inclusion_exclusion":
                count = n // 2 + n // 3 - n // 6
            else:
                count = -1

            writer.writerow(
                {
                    "case_id": case_id,
                    "name": row["name"],
                    "method": method,
                    "computed_count": count,
                    "interpretation": row["interpretation"],
                }
            )


def fibonacci_table(n_max: int) -> list[tuple[int, int]]:
    previous, current = 0, 1
    rows = [(0, previous), (1, current)]
    for n in range(2, n_max + 1):
        previous, current = current, previous + current
        rows.append((n, current))
    return rows


def write_recurrence_modular_audit() -> None:
    with (OUT_TABLES / "recurrence_modular_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["audit_type", "index", "value", "rule", "interpretation"],
        )
        writer.writeheader()

        for n, value in fibonacci_table(20):
            writer.writerow(
                {
                    "audit_type": "fibonacci",
                    "index": n,
                    "value": value,
                    "rule": "F_n=F_(n-1)+F_(n-2)",
                    "interpretation": "recurrence defines each term from earlier terms",
                }
            )

        for n in range(0, 30):
            writer.writerow(
                {
                    "audit_type": "residue_mod_7",
                    "index": n,
                    "value": n % 7,
                    "rule": "n mod 7",
                    "interpretation": "modular arithmetic formalizes cyclic discrete structure",
                }
            )


def main() -> None:
    write_graph_audit()
    write_combinatorics_audit()
    write_recurrence_modular_audit()

    print("Discrete structure workflow complete.")
    print(f"  {OUT_TABLES / 'graph_degree_component_audit.csv'}")
    print(f"  {OUT_TABLES / 'combinatorics_counting_audit.csv'}")
    print(f"  {OUT_TABLES / 'recurrence_modular_audit.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'graph_main.dot'}")


if __name__ == "__main__":
    main()
