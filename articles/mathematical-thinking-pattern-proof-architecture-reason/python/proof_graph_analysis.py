#!/usr/bin/env python3
"""
Proof dependency graph analysis for mathematical-thinking workflows.

This script intentionally uses the Python standard library so the example
is portable on a clean machine. It supports:
- dependency loading from CSV
- adjacency-list construction
- cycle detection
- topological ordering
- transitive dependency summaries
- Graphviz DOT export
"""

from __future__ import annotations

import csv
from collections import defaultdict, deque
from pathlib import Path
from typing import DefaultDict

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw" / "proof_dependencies.csv"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


def load_edges() -> list[tuple[str, str, str, int]]:
    with DATA.open("r", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        return [
            (row["source"], row["target"], row["relation"], int(row["weight"]))
            for row in reader
        ]


def build_graph(edges: list[tuple[str, str, str, int]]) -> dict[str, list[str]]:
    graph: DefaultDict[str, list[str]] = defaultdict(list)
    vertices = set()
    for source, target, _, _ in edges:
        graph[source].append(target)
        vertices.add(source)
        vertices.add(target)
    for vertex in vertices:
        graph.setdefault(vertex, [])
    return dict(graph)


def topological_sort(graph: dict[str, list[str]]) -> list[str]:
    indegree = {node: 0 for node in graph}
    for targets in graph.values():
        for target in targets:
            indegree[target] += 1

    queue = deque(sorted(node for node, degree in indegree.items() if degree == 0))
    order: list[str] = []

    while queue:
        node = queue.popleft()
        order.append(node)
        for target in sorted(graph[node]):
            indegree[target] -= 1
            if indegree[target] == 0:
                queue.append(target)

    if len(order) != len(graph):
        raise ValueError("The dependency graph contains a cycle.")

    return order


def transitive_dependencies(graph: dict[str, list[str]], node: str) -> set[str]:
    seen: set[str] = set()
    stack = list(graph.get(node, []))
    while stack:
        current = stack.pop()
        if current in seen:
            continue
        seen.add(current)
        stack.extend(graph.get(current, []))
    return seen


def write_topological_order(order: list[str]) -> None:
    with (OUT_TABLES / "proof_graph_topological_order.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["rank", "node"])
        writer.writeheader()
        writer.writerows({"rank": i + 1, "node": node} for i, node in enumerate(order))


def write_dependency_summary(graph: dict[str, list[str]]) -> None:
    with (OUT_TABLES / "proof_graph_dependency_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["node", "direct_out_degree", "transitive_reach"])
        writer.writeheader()
        for node in sorted(graph):
            writer.writerow(
                {
                    "node": node,
                    "direct_out_degree": len(graph[node]),
                    "transitive_reach": len(transitive_dependencies(graph, node)),
                }
            )


def write_graphviz(edges: list[tuple[str, str, str, int]]) -> None:
    with (OUT_FIGURES / "proof_dependency_graph.dot").open("w", encoding="utf-8") as handle:
        handle.write("digraph proof_dependency_graph {\n")
        handle.write('  graph [rankdir="LR"];\n')
        handle.write('  node [shape="box"];\n')
        for source, target, relation, weight in edges:
            handle.write(f'  "{source}" -> "{target}" [label="{relation}:{weight}"];\n')
        handle.write("}\n")


def main() -> None:
    edges = load_edges()
    graph = build_graph(edges)
    order = topological_sort(graph)
    write_topological_order(order)
    write_dependency_summary(graph)
    write_graphviz(edges)

    print("Proof graph analysis complete.")
    print(f"Topological order: {OUT_TABLES / 'proof_graph_topological_order.csv'}")
    print(f"Dependency summary: {OUT_TABLES / 'proof_graph_dependency_summary.csv'}")
    print(f"Graphviz DOT file: {OUT_FIGURES / 'proof_dependency_graph.dot'}")


if __name__ == "__main__":
    main()
