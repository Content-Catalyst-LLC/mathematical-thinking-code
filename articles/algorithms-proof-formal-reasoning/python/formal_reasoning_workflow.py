#!/usr/bin/env python3
"""
Formal reasoning workflow for:
"Algorithms, Proof, and Formal Reasoning"

This workflow demonstrates:
- algorithm specification audits;
- insertion-sort invariant checks;
- binary-search termination/correctness checks;
- complexity growth tables;
- graph traversal proof metadata;
- Graphviz DOT export for proof obligations.
"""

from __future__ import annotations

import csv
from collections import Counter, deque
from dataclasses import dataclass
from math import log2
from pathlib import Path
from typing import Sequence

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def is_sorted(values: Sequence[int]) -> bool:
    return all(values[i] <= values[i + 1] for i in range(len(values) - 1))


def same_multiset(left: Sequence[int], right: Sequence[int]) -> bool:
    return Counter(left) == Counter(right)


@dataclass(frozen=True)
class SortAuditStep:
    step: int
    prefix_end: int
    prefix_sorted: bool
    full_state: tuple[int, ...]
    invariant_note: str


def insertion_sort_with_audit(values: list[int]) -> tuple[list[int], list[SortAuditStep]]:
    result = values[:]
    steps = [
        SortAuditStep(
            step=0,
            prefix_end=1 if result else 0,
            prefix_sorted=is_sorted(result[:1]),
            full_state=tuple(result),
            invariant_note="initial prefix is sorted",
        )
    ]

    for i in range(1, len(result)):
        key = result[i]
        j = i - 1

        while j >= 0 and result[j] > key:
            result[j + 1] = result[j]
            j -= 1

        result[j + 1] = key
        steps.append(
            SortAuditStep(
                step=i,
                prefix_end=i + 1,
                prefix_sorted=is_sorted(result[: i + 1]),
                full_state=tuple(result),
                invariant_note="processed prefix remains sorted after insertion",
            )
        )

    return result, steps


def binary_search_with_trace(values: Sequence[int], target: int) -> tuple[int | None, list[dict[str, str | int]]]:
    low = 0
    high = len(values) - 1
    trace: list[dict[str, str | int]] = []
    step = 0

    while low <= high:
        interval_length = high - low + 1
        mid = low + (high - low) // 2
        trace.append(
            {
                "step": step,
                "low": low,
                "high": high,
                "mid": mid,
                "mid_value": values[mid],
                "interval_length": interval_length,
                "invariant_note": "target if present remains in active interval",
            }
        )

        if values[mid] == target:
            return mid, trace
        if values[mid] < target:
            low = mid + 1
        else:
            high = mid - 1
        step += 1

    trace.append(
        {
            "step": step,
            "low": low,
            "high": high,
            "mid": -1,
            "mid_value": "missing",
            "interval_length": 0,
            "invariant_note": "empty interval means target absent",
        }
    )
    return None, trace


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


def write_algorithm_spec_audit() -> None:
    with (OUT_TABLES / "algorithm_specification_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "algorithm_id",
            "name",
            "input_domain",
            "precondition",
            "postcondition",
            "termination_measure",
            "complexity_note",
            "responsible_use_note",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("algorithm_specifications.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "Are specification, proof obligation, termination measure, complexity claim, and responsible-use context explicit?",
                }
            )


def write_insertion_sort_audit() -> None:
    values = [5, 2, 8, 1, 3, 2]
    output, steps = insertion_sort_with_audit(values)

    with (OUT_TABLES / "insertion_sort_invariant_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "step",
            "prefix_end",
            "prefix_sorted",
            "full_state",
            "same_multiset_as_input",
            "invariant_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for step in steps:
            writer.writerow(
                {
                    "step": step.step,
                    "prefix_end": step.prefix_end,
                    "prefix_sorted": step.prefix_sorted,
                    "full_state": " ".join(map(str, step.full_state)),
                    "same_multiset_as_input": same_multiset(values, step.full_state),
                    "invariant_note": step.invariant_note,
                }
            )

    with (OUT_TABLES / "insertion_sort_postcondition_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["input", "output", "is_sorted", "same_multiset", "postcondition_holds"])
        writer.writeheader()
        writer.writerow(
            {
                "input": " ".join(map(str, values)),
                "output": " ".join(map(str, output)),
                "is_sorted": is_sorted(output),
                "same_multiset": same_multiset(values, output),
                "postcondition_holds": is_sorted(output) and same_multiset(values, output),
            }
        )


def write_binary_search_audit() -> None:
    values = [1, 2, 3, 5, 8, 13, 21, 34]
    target = 13
    index, trace = binary_search_with_trace(values, target)

    with (OUT_TABLES / "binary_search_trace_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["step", "low", "high", "mid", "mid_value", "interval_length", "invariant_note", "target", "result_index"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in trace:
            writer.writerow({**row, "target": target, "result_index": index if index is not None else "missing"})


def write_complexity_growth() -> None:
    with (OUT_TABLES / "complexity_growth_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["n", "log2_n", "linear_n", "n_log2_n", "quadratic_n2", "exponential_2n", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
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
                    "interpretation": "complexity analysis compares growth under an abstract cost model",
                }
            )


def write_bfs_audit() -> None:
    graph = {
        "A": {"B", "C"},
        "B": {"A", "D"},
        "C": {"A"},
        "D": {"B", "E"},
        "E": {"D"},
    }
    distances = bfs_distances(graph, "A")

    with (OUT_TABLES / "bfs_distance_proof_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["start", "node", "distance", "algorithm_assumption", "proof_obligation", "interpretive_warning"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for node, distance in sorted(distances.items()):
            writer.writerow(
                {
                    "start": "A",
                    "node": node,
                    "distance": distance,
                    "algorithm_assumption": "unweighted graph",
                    "proof_obligation": "BFS discovers vertices by nondecreasing distance layers",
                    "interpretive_warning": "edge count is not automatically time, cost, risk, or social distance",
                }
            )


def write_proof_dot() -> None:
    proof_rows = load_csv("proof_obligations.csv")
    with (OUT_FIGURES / "proof_obligation_graph.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph proof_obligations {\n")
        dot.write('  graph [rankdir="LR"];\n')
        for row in proof_rows:
            algorithm = row["algorithm_id"]
            proof = row["proof_id"]
            proof_type = row["proof_type"]
            dot.write(f'  "{algorithm}" [shape=box];\n')
            dot.write(f'  "{proof}" [label="{proof}\\n{proof_type}"];\n')
            dot.write(f'  "{algorithm}" -> "{proof}";\n')
        dot.write('  note [shape=note, label="Proof graph links algorithms to proof obligations; formal proof still requires full argument."];\n')
        dot.write("}\n")


def main() -> None:
    write_algorithm_spec_audit()
    write_insertion_sort_audit()
    write_binary_search_audit()
    write_complexity_growth()
    write_bfs_audit()
    write_proof_dot()

    print("Formal reasoning workflow complete.")
    print(f"  {OUT_TABLES / 'algorithm_specification_audit.csv'}")
    print(f"  {OUT_TABLES / 'insertion_sort_invariant_audit.csv'}")
    print(f"  {OUT_TABLES / 'insertion_sort_postcondition_audit.csv'}")
    print(f"  {OUT_TABLES / 'binary_search_trace_audit.csv'}")
    print(f"  {OUT_TABLES / 'complexity_growth_audit.csv'}")
    print(f"  {OUT_TABLES / 'bfs_distance_proof_audit.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'proof_obligation_graph.dot'}")


if __name__ == "__main__":
    main()
