#!/usr/bin/env python3
"""
Graph invariant workflow.

This script supports the article's core movement:
pattern -> structure -> invariant.

It computes simple graph invariants from edge-list data:
- vertex count
- edge count
- degree sequence
- connected component count
- cycle-rank proxy for undirected graphs: m - n + c
"""

from __future__ import annotations

import csv
from collections import Counter, defaultdict, deque
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OBJECTS = ROOT / "data" / "raw" / "graph_objects.csv"
EDGES = ROOT / "data" / "raw" / "graph_edges.csv"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


def load_objects() -> dict[str, dict[str, str]]:
    with OBJECTS.open("r", encoding="utf-8") as handle:
        return {row["object_id"]: row for row in csv.DictReader(handle)}


def load_edges() -> dict[str, list[tuple[str, str]]]:
    grouped: dict[str, list[tuple[str, str]]] = defaultdict(list)
    with EDGES.open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            grouped[row["object_id"]].append((row["source"], row["target"]))
    return dict(grouped)


def vertices_from_edges(edges: list[tuple[str, str]]) -> set[str]:
    vertices: set[str] = set()
    for a, b in edges:
        vertices.add(a)
        vertices.add(b)
    return vertices


def degree_sequence(edges: list[tuple[str, str]]) -> tuple[int, ...]:
    counts = Counter()
    vertices = vertices_from_edges(edges)
    for v in vertices:
        counts[v] += 0
    for a, b in edges:
        counts[a] += 1
        counts[b] += 1
    return tuple(sorted(counts.values(), reverse=True))


def component_count(edges: list[tuple[str, str]]) -> int:
    vertices = vertices_from_edges(edges)
    adjacency: dict[str, set[str]] = {v: set() for v in vertices}
    for a, b in edges:
        adjacency[a].add(b)
        adjacency[b].add(a)

    seen: set[str] = set()
    count = 0

    for start in sorted(vertices):
        if start in seen:
            continue
        count += 1
        queue = deque([start])
        seen.add(start)
        while queue:
            node = queue.popleft()
            for neighbor in adjacency[node]:
                if neighbor not in seen:
                    seen.add(neighbor)
                    queue.append(neighbor)
    return count


def write_graphviz(object_id: str, edges: list[tuple[str, str]]) -> None:
    path = OUT_FIGURES / f"{object_id}.dot"
    with path.open("w", encoding="utf-8") as handle:
        handle.write(f"graph {object_id} {{\n")
        handle.write('  graph [layout="neato"];\n')
        for a, b in edges:
            handle.write(f'  "{a}" -- "{b}";\n')
        handle.write("}\n")


def main() -> None:
    objects = load_objects()
    grouped_edges = load_edges()

    rows: list[dict[str, object]] = []

    for object_id, item in objects.items():
        edges = grouped_edges.get(object_id, [])
        vertices = vertices_from_edges(edges)
        components = component_count(edges) if vertices else 0
        cycle_rank = len(edges) - len(vertices) + components

        rows.append(
            {
                "object_id": object_id,
                "name": item["name"],
                "vertex_count": len(vertices),
                "edge_count": len(edges),
                "degree_sequence": " ".join(map(str, degree_sequence(edges))),
                "connected_components": components,
                "cycle_rank": cycle_rank,
            }
        )

        write_graphviz(object_id, edges)

    with (OUT_TABLES / "graph_invariant_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "object_id",
                "name",
                "vertex_count",
                "edge_count",
                "degree_sequence",
                "connected_components",
                "cycle_rank",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)

    print("Wrote graph invariant summary:")
    print(f"  {OUT_TABLES / 'graph_invariant_summary.csv'}")
    print(f"Graphviz DOT files written to: {OUT_FIGURES}")


if __name__ == "__main__":
    main()
