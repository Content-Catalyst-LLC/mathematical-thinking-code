#!/usr/bin/env python3
"""
Graph, dynamic, and probabilistic pattern workflow.

This script supports the article's broad thesis:
mathematics studies patterns across relation, change, and uncertainty.

It generates:
- graph invariant summaries;
- dynamic-system iteration tables;
- deterministic pseudo-random probability experiment tables;
- Graphviz DOT files for graph structures.
"""

from __future__ import annotations

import csv
import random
from collections import Counter, defaultdict, deque
from pathlib import Path
from typing import Callable

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


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


def write_graph_outputs() -> None:
    graphs = load_graph_edges()
    with (OUT_TABLES / "graph_pattern_invariants.csv").open("w", newline="", encoding="utf-8") as handle:
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

            with (OUT_FIGURES / f"{graph_id}.dot").open("w", encoding="utf-8") as dot:
                dot.write(f"graph {graph_id} {{\n")
                dot.write('  graph [rankdir="LR"];\n')
                for a, b in edges:
                    dot.write(f'  "{a}" -- "{b}";\n')
                dot.write("}\n")


def iterate(rule: Callable[[float], float], x0: float, steps: int) -> list[float]:
    values = [x0]
    for _ in range(steps - 1):
        values.append(rule(values[-1]))
    return values


def write_dynamic_outputs() -> None:
    rows: list[dict[str, object]] = []
    with (DATA / "dynamic_systems.csv").open("r", encoding="utf-8") as handle:
        for item in csv.DictReader(handle):
            system_id = item["system_id"]
            x0 = float(item["initial_value"])
            parameter = float(item["parameter"])

            if system_id == "dyn_linear":
                rule = lambda x, p=parameter: p * x + 1.0
            else:
                rule = lambda x, p=parameter: p * x * (1.0 - x)

            values = iterate(rule, x0, 40)
            for step, value in enumerate(values):
                rows.append(
                    {
                        "system_id": system_id,
                        "step": step,
                        "value": value,
                        "interpretation": item["interpretation"],
                    }
                )

    with (OUT_TABLES / "dynamic_pattern_iterations.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["system_id", "step", "value", "interpretation"])
        writer.writeheader()
        writer.writerows(rows)


def write_probability_outputs() -> None:
    rng = random.Random(20260529)
    rows: list[dict[str, object]] = []

    with (DATA / "probability_experiments.csv").open("r", encoding="utf-8") as handle:
        for item in csv.DictReader(handle):
            trials = int(item["trials"])
            probability = float(item["probability"])
            successes = 0

            for trial in range(1, trials + 1):
                if rng.random() < probability:
                    successes += 1

                if trial in {10, 25, 50, 100, 250, 500, 1000} and trial <= trials:
                    rows.append(
                        {
                            "experiment_id": item["experiment_id"],
                            "trial": trial,
                            "successes": successes,
                            "observed_frequency": successes / trial,
                            "expected_probability": probability,
                            "interpretation": item["interpretation"],
                        }
                    )

    with (OUT_TABLES / "probabilistic_pattern_frequencies.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "experiment_id",
                "trial",
                "successes",
                "observed_frequency",
                "expected_probability",
                "interpretation",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    write_graph_outputs()
    write_dynamic_outputs()
    write_probability_outputs()

    print("Graph, dynamic, and probabilistic pattern workflow complete.")
    print(f"  {OUT_TABLES / 'graph_pattern_invariants.csv'}")
    print(f"  {OUT_TABLES / 'dynamic_pattern_iterations.csv'}")
    print(f"  {OUT_TABLES / 'probabilistic_pattern_frequencies.csv'}")
    print(f"  Graphviz DOT files: {OUT_FIGURES}")


if __name__ == "__main__":
    main()
