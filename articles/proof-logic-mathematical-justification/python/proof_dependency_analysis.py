#!/usr/bin/env python3
"""
Proof dependency analysis for:
"Proof and the Logic of Mathematical Justification"

This workflow builds a proof dependency graph from metadata and exports:
- topological dependency order;
- dependency summary;
- cycle audit;
- Graphviz DOT file.
"""

from __future__ import annotations

import csv
from collections import defaultdict, deque
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


def load_claims() -> dict[str, dict[str, str]]:
    with (DATA / "claims.csv").open("r", encoding="utf-8") as handle:
        return {row["claim_id"]: row for row in csv.DictReader(handle)}


def load_edges() -> list[tuple[str, str, str, int]]:
    with (DATA / "proof_dependencies.csv").open("r", encoding="utf-8") as handle:
        return [
            (row["source"], row["target"], row["relation"], int(row["weight"]))
            for row in csv.DictReader(handle)
        ]


def build_graph(edges: list[tuple[str, str, str, int]]) -> dict[str, list[str]]:
    graph: dict[str, list[str]] = defaultdict(list)
    vertices: set[str] = set()
    for source, target, _, _ in edges:
        graph[source].append(target)
        vertices.add(source)
        vertices.add(target)
    for vertex in vertices:
        graph.setdefault(vertex, [])
    return dict(graph)


def topological_sort(graph: dict[str, list[str]]) -> tuple[list[str], bool]:
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

    has_cycle = len(order) != len(graph)
    return order, has_cycle


def transitive_reach(graph: dict[str, list[str]], start: str) -> set[str]:
    seen: set[str] = set()
    stack = list(graph.get(start, []))
    while stack:
        node = stack.pop()
        if node in seen:
            continue
        seen.add(node)
        stack.extend(graph.get(node, []))
    return seen


def write_outputs() -> None:
    claims = load_claims()
    edges = load_edges()
    graph = build_graph(edges)
    order, has_cycle = topological_sort(graph)

    with (OUT_TABLES / "proof_dependency_order.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["rank", "claim_id", "title", "claim_type", "proof_status"])
        writer.writeheader()
        for rank, claim_id in enumerate(order, start=1):
            item = claims.get(claim_id, {})
            writer.writerow(
                {
                    "rank": rank,
                    "claim_id": claim_id,
                    "title": item.get("title", ""),
                    "claim_type": item.get("claim_type", ""),
                    "proof_status": item.get("proof_status", ""),
                }
            )

    with (OUT_TABLES / "proof_dependency_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["claim_id", "direct_dependencies_out", "transitive_reach", "has_cycle_in_graph"])
        writer.writeheader()
        for claim_id in sorted(graph):
            writer.writerow(
                {
                    "claim_id": claim_id,
                    "direct_dependencies_out": len(graph[claim_id]),
                    "transitive_reach": len(transitive_reach(graph, claim_id)),
                    "has_cycle_in_graph": has_cycle,
                }
            )

    with (OUT_FIGURES / "proof_dependency_graph.dot").open("w", encoding="utf-8") as handle:
        handle.write("digraph proof_dependency_graph {\n")
        handle.write('  graph [rankdir="LR"];\n')
        handle.write('  node [shape="box"];\n')
        for source, target, relation, weight in edges:
            handle.write(f'  "{source}" -> "{target}" [label="{relation}:{weight}"];\n')
        handle.write("}\n")

    print("Proof dependency analysis complete.")
    print(f"  {OUT_TABLES / 'proof_dependency_order.csv'}")
    print(f"  {OUT_TABLES / 'proof_dependency_summary.csv'}")
    print(f"  {OUT_FIGURES / 'proof_dependency_graph.dot'}")


if __name__ == "__main__":
    write_outputs()
