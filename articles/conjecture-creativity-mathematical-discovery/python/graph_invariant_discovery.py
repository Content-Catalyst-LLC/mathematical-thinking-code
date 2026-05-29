#!/usr/bin/env python3
"""
Graph invariant discovery workflow.

This workflow demonstrates how computation can suggest conjectures
and identify incomplete invariants.
"""

from __future__ import annotations

import csv
from collections import Counter, defaultdict, deque
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


def load_graphs() -> dict[str, list[tuple[str, str]]]:
    grouped: dict[str, list[tuple[str, str]]] = defaultdict(list)
    with (DATA / "graph_edges.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            grouped[row["graph_id"]].append((row["source"], row["target"]))
    return dict(grouped)


def vertices(edges: list[tuple[str, str]]) -> set[str]:
    result: set[str] = set()
    for source, target in edges:
        result.add(source)
        result.add(target)
    return result


def degree_sequence(edges: list[tuple[str, str]]) -> tuple[int, ...]:
    counts = Counter()
    for vertex in vertices(edges):
        counts[vertex] += 0
    for source, target in edges:
        counts[source] += 1
        counts[target] += 1
    return tuple(sorted(counts.values(), reverse=True))


def component_count(edges: list[tuple[str, str]]) -> int:
    verts = vertices(edges)
    adjacency = {v: set() for v in verts}
    for source, target in edges:
        adjacency[source].add(target)
        adjacency[target].add(source)

    seen: set[str] = set()
    components = 0
    for start in sorted(verts):
        if start in seen:
            continue
        components += 1
        queue = deque([start])
        seen.add(start)
        while queue:
            node = queue.popleft()
            for neighbor in adjacency[node]:
                if neighbor not in seen:
                    seen.add(neighbor)
                    queue.append(neighbor)
    return components


def write_graph_outputs() -> None:
    graphs = load_graphs()
    degree_classes: dict[tuple[int, ...], list[str]] = defaultdict(list)

    with (OUT_TABLES / "graph_invariant_discovery.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "graph_id",
                "vertex_count",
                "edge_count",
                "degree_sequence",
                "component_count",
                "cycle_rank",
                "candidate_conjecture_note",
            ],
        )
        writer.writeheader()

        for graph_id, edges in sorted(graphs.items()):
            verts = vertices(edges)
            v_count = len(verts)
            e_count = len(edges)
            components = component_count(edges)
            cycle_rank = e_count - v_count + components
            deg_seq = degree_sequence(edges)
            degree_classes[deg_seq].append(graph_id)

            writer.writerow(
                {
                    "graph_id": graph_id,
                    "vertex_count": v_count,
                    "edge_count": e_count,
                    "degree_sequence": " ".join(map(str, deg_seq)),
                    "component_count": components,
                    "cycle_rank": cycle_rank,
                    "candidate_conjecture_note": "cycle rank m-n+c is nonnegative for these examples",
                }
            )

            with (OUT_FIGURES / f"{graph_id}.dot").open("w", encoding="utf-8") as dot:
                dot.write("graph " + graph_id + " {\n")
                dot.write('  graph [rankdir="LR"];\n')
                for source, target in edges:
                    dot.write(f'  "{source}" -- "{target}";\n')
                dot.write("}\n")

    with (OUT_TABLES / "degree_sequence_collision_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["degree_sequence", "graph_ids", "collision_count", "interpretation"])
        writer.writeheader()

        for deg_seq, graph_ids in sorted(degree_classes.items()):
            writer.writerow(
                {
                    "degree_sequence": " ".join(map(str, deg_seq)),
                    "graph_ids": " ".join(sorted(graph_ids)),
                    "collision_count": len(graph_ids),
                    "interpretation": "shared degree sequence may suggest but does not guarantee isomorphism",
                }
            )


def main() -> None:
    write_graph_outputs()
    print("Graph invariant discovery workflow complete.")
    print(f"  {OUT_TABLES / 'graph_invariant_discovery.csv'}")
    print(f"  {OUT_TABLES / 'degree_sequence_collision_audit.csv'}")
    print(f"  Graphviz DOT files: {OUT_FIGURES}")


if __name__ == "__main__":
    main()
