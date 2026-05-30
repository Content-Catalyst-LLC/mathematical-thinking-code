#!/usr/bin/env python3
"""
Recursive structure workflow for:
"Recursion and Recursive Thinking"

This workflow demonstrates:
- recursive definition audits;
- recurrence table generation;
- tree traversal and structural recursion;
- memoization effects;
- Graphviz DOT export for recursive trees.
"""

from __future__ import annotations

import csv
from dataclasses import dataclass
from functools import lru_cache
from pathlib import Path
from typing import Iterable

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def factorial(n: int) -> int:
    if n < 0:
        raise ValueError("factorial requires nonnegative input")
    if n == 0:
        return 1
    return n * factorial(n - 1)


@lru_cache(maxsize=None)
def fibonacci_memo(n: int) -> int:
    if n < 0:
        raise ValueError("fibonacci requires nonnegative input")
    if n in (0, 1):
        return n
    return fibonacci_memo(n - 1) + fibonacci_memo(n - 2)


def fibonacci_iterative(n: int) -> int:
    if n < 0:
        raise ValueError("fibonacci requires nonnegative input")
    if n in (0, 1):
        return n
    previous, current = 0, 1
    for _ in range(2, n + 1):
        previous, current = current, previous + current
    return current


def arithmetic(n: int, start: int = 3, step: int = 5) -> int:
    if n == 0:
        return start
    return arithmetic(n - 1, start, step) + step


def geometric(n: int, start: int = 2, ratio: int = 3) -> int:
    if n == 0:
        return start
    return ratio * geometric(n - 1, start, ratio)


def merge_sort_cost(n: int) -> int:
    if n <= 1:
        return 1
    return 2 * merge_sort_cost(n // 2) + n


@dataclass(frozen=True)
class Node:
    node_id: str
    parent_id: str
    label: str
    node_type: str
    interpretation: str


def build_children(nodes: Iterable[Node]) -> dict[str, list[Node]]:
    children: dict[str, list[Node]] = {}
    for node in nodes:
        children.setdefault(node.parent_id, []).append(node)
    return children


def node_size(node: Node, children: dict[str, list[Node]]) -> int:
    return 1 + sum(node_size(child, children) for child in children.get(node.node_id, []))


def node_depth(node: Node, children: dict[str, list[Node]]) -> int:
    child_nodes = children.get(node.node_id, [])
    if not child_nodes:
        return 1
    return 1 + max(node_depth(child, children) for child in child_nodes)


def write_definition_audit() -> None:
    with (OUT_TABLES / "recursive_definition_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "definition_id",
                "name",
                "base_case",
                "recursive_rule",
                "termination_measure",
                "has_base_case",
                "has_recursive_rule",
                "has_termination_measure",
                "interpretation",
            ],
        )
        writer.writeheader()

        for row in load_csv("recursive_definitions.csv"):
            writer.writerow(
                {
                    **row,
                    "has_base_case": bool(row["base_case"].strip()),
                    "has_recursive_rule": bool(row["recursive_rule"].strip()),
                    "has_termination_measure": bool(row["termination_measure"].strip()),
                }
            )


def write_recurrence_values() -> None:
    with (OUT_TABLES / "recurrence_value_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["sequence", "n", "value", "rule", "interpretation"],
        )
        writer.writeheader()

        for n in range(0, 16):
            writer.writerow({"sequence": "factorial", "n": n, "value": factorial(n), "rule": "n! = n*(n-1)!", "interpretation": "recursive product from base case"})
            writer.writerow({"sequence": "fibonacci_memo", "n": n, "value": fibonacci_memo(n), "rule": "F_n = F_(n-1)+F_(n-2)", "interpretation": "memoized two-branch recurrence"})
            writer.writerow({"sequence": "arithmetic", "n": n, "value": arithmetic(n), "rule": "a_n=a_(n-1)+5", "interpretation": "additive recurrence"})
            writer.writerow({"sequence": "geometric", "n": n, "value": geometric(n), "rule": "a_n=3*a_(n-1)", "interpretation": "multiplicative recurrence"})

        for n in [1, 2, 4, 8, 16, 32, 64]:
            writer.writerow({"sequence": "merge_sort_cost", "n": n, "value": merge_sort_cost(n), "rule": "T(n)=2T(n/2)+n", "interpretation": "divide-and-conquer cost recurrence"})


def write_tree_audit() -> None:
    nodes = [
        Node(
            node_id=row["node_id"],
            parent_id=row["parent_id"],
            label=row["label"],
            node_type=row["node_type"],
            interpretation=row["interpretation"],
        )
        for row in load_csv("tree_nodes.csv")
    ]
    children = build_children(nodes)

    with (OUT_TABLES / "tree_structure_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["node_id", "parent_id", "label", "node_type", "subtree_size", "subtree_depth", "interpretation"],
        )
        writer.writeheader()

        for node in nodes:
            writer.writerow(
                {
                    "node_id": node.node_id,
                    "parent_id": node.parent_id,
                    "label": node.label,
                    "node_type": node.node_type,
                    "subtree_size": node_size(node, children),
                    "subtree_depth": node_depth(node, children),
                    "interpretation": node.interpretation,
                }
            )

    dot_path = OUT_FIGURES / "recursive_tree_examples.dot"
    with dot_path.open("w", encoding="utf-8") as dot:
        dot.write("digraph recursive_tree_examples {\n")
        dot.write('  graph [rankdir="TB"];\n')
        for node in nodes:
            label = f"{node.label}\\n{node.node_type}"
            dot.write(f'  "{node.node_id}" [label="{label}"];\n')
            if node.parent_id:
                dot.write(f'  "{node.parent_id}" -> "{node.node_id}";\n')
        dot.write("}\n")


def write_memoization_audit() -> None:
    naive_calls: dict[int, int] = {}

    def fib_naive_counted(n: int) -> int:
        naive_calls[n] = naive_calls.get(n, 0) + 1
        if n in (0, 1):
            return n
        return fib_naive_counted(n - 1) + fib_naive_counted(n - 2)

    rows = []
    for n in range(0, 11):
        naive_calls.clear()
        value = fib_naive_counted(n)
        rows.append(
            {
                "n": n,
                "fibonacci_value": value,
                "naive_call_count": sum(naive_calls.values()),
                "unique_subproblems": len(naive_calls),
                "interpretation": "memoization stores overlapping subproblems instead of recomputing them",
            }
        )

    with (OUT_TABLES / "memoization_effect_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    write_definition_audit()
    write_recurrence_values()
    write_tree_audit()
    write_memoization_audit()

    print("Recursive structure workflow complete.")
    print(f"  {OUT_TABLES / 'recursive_definition_audit.csv'}")
    print(f"  {OUT_TABLES / 'recurrence_value_audit.csv'}")
    print(f"  {OUT_TABLES / 'tree_structure_audit.csv'}")
    print(f"  {OUT_TABLES / 'memoization_effect_audit.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'recursive_tree_examples.dot'}")


if __name__ == "__main__":
    main()
