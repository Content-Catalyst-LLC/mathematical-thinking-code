#!/usr/bin/env python3
"""
Equivalence, abstraction, and invariant analysis.

This script demonstrates:
- rational equivalence classes through normalization;
- graph degree-sequence invariants;
- the distinction between preserved structure and complete classification;
- reproducible tabular outputs for mathematical reasoning.
"""

from __future__ import annotations

import csv
import math
from collections import Counter, defaultdict, deque
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


@dataclass(frozen=True)
class FractionRecord:
    fraction_id: str
    numerator: int
    denominator: int
    note: str

    def normalized(self) -> tuple[int, int]:
        if self.denominator == 0:
            raise ValueError(f"{self.fraction_id} has zero denominator.")
        sign = -1 if self.denominator < 0 else 1
        n = self.numerator * sign
        d = self.denominator * sign
        g = math.gcd(abs(n), abs(d))
        return (n // g, d // g)


def load_fractions() -> list[FractionRecord]:
    with (DATA / "fractions.csv").open("r", encoding="utf-8") as handle:
        return [
            FractionRecord(
                fraction_id=row["fraction_id"],
                numerator=int(row["numerator"]),
                denominator=int(row["denominator"]),
                note=row["interpretive_note"],
            )
            for row in csv.DictReader(handle)
        ]


def write_fraction_classes(records: list[FractionRecord]) -> None:
    grouped: dict[tuple[int, int], list[FractionRecord]] = defaultdict(list)
    for record in records:
        grouped[record.normalized()].append(record)

    with (OUT_TABLES / "fraction_equivalence_classes.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "equivalence_class",
                "representative",
                "member_count",
                "members",
                "notes",
            ],
        )
        writer.writeheader()
        for representative, members in sorted(grouped.items()):
            writer.writerow(
                {
                    "equivalence_class": f"{representative[0]}/{representative[1]}",
                    "representative": representative,
                    "member_count": len(members),
                    "members": " ".join(member.fraction_id for member in members),
                    "notes": " | ".join(member.note for member in members),
                }
            )


def load_graph_edges() -> dict[str, list[tuple[str, str]]]:
    grouped: dict[str, list[tuple[str, str]]] = defaultdict(list)
    with (DATA / "graph_edges.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            grouped[row["graph_id"]].append((row["source"], row["target"]))
    return dict(grouped)


def vertices(edges: list[tuple[str, str]]) -> set[str]:
    result: set[str] = set()
    for a, b in edges:
        result.add(a)
        result.add(b)
    return result


def degree_sequence(edges: list[tuple[str, str]]) -> tuple[int, ...]:
    counts = Counter()
    for vertex in vertices(edges):
        counts[vertex] += 0
    for a, b in edges:
        counts[a] += 1
        counts[b] += 1
    return tuple(sorted(counts.values(), reverse=True))


def component_count(edges: list[tuple[str, str]]) -> int:
    verts = vertices(edges)
    adjacency = {v: set() for v in verts}
    for a, b in edges:
        adjacency[a].add(b)
        adjacency[b].add(a)

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


def write_graph_invariants(graphs: dict[str, list[tuple[str, str]]]) -> None:
    with (OUT_TABLES / "graph_invariant_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "graph_id",
                "vertex_count",
                "edge_count",
                "degree_sequence",
                "connected_components",
                "cycle_rank",
            ],
        )
        writer.writeheader()
        for graph_id, edges in sorted(graphs.items()):
            v_count = len(vertices(edges))
            e_count = len(edges)
            components = component_count(edges)
            writer.writerow(
                {
                    "graph_id": graph_id,
                    "vertex_count": v_count,
                    "edge_count": e_count,
                    "degree_sequence": " ".join(map(str, degree_sequence(edges))),
                    "connected_components": components,
                    "cycle_rank": e_count - v_count + components,
                }
            )


def write_graphviz(graphs: dict[str, list[tuple[str, str]]]) -> None:
    for graph_id, edges in graphs.items():
        with (OUT_FIGURES / f"{graph_id}.dot").open("w", encoding="utf-8") as handle:
            handle.write(f"graph {graph_id} {{\n")
            handle.write('  graph [rankdir="LR"];\n')
            for a, b in edges:
                handle.write(f'  "{a}" -- "{b}";\n')
            handle.write("}\n")


def main() -> None:
    fractions = load_fractions()
    write_fraction_classes(fractions)

    graphs = load_graph_edges()
    write_graph_invariants(graphs)
    write_graphviz(graphs)

    print("Equivalence and invariant analysis complete.")
    print(f"  {OUT_TABLES / 'fraction_equivalence_classes.csv'}")
    print(f"  {OUT_TABLES / 'graph_invariant_summary.csv'}")
    print(f"  Graphviz DOT files: {OUT_FIGURES}")


if __name__ == "__main__":
    main()
