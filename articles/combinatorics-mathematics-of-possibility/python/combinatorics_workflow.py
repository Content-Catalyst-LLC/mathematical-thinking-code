#!/usr/bin/env python3
"""
Combinatorics workflow for:
"Combinatorics and the Mathematics of Possibility"

This workflow demonstrates:
- permutations and combinations;
- inclusion-exclusion;
- binomial and Pascal structure;
- recurrence counting;
- graph counting;
- integer partitions;
- search-space growth.
"""

from __future__ import annotations

import csv
from functools import lru_cache
from math import comb, factorial
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


def permutation_count(n: int, k: int) -> int:
    return factorial(n) // factorial(n - k)


def combination_count(n: int, k: int) -> int:
    return comb(n, k)


def simple_labeled_graph_count(n: int) -> int:
    return 2 ** comb(n, 2)


def cayley_tree_count(n: int) -> int:
    return n ** (n - 2) if n >= 2 else 1


@lru_cache(maxsize=None)
def integer_partitions(n: int, max_part: int | None = None) -> int:
    if max_part is None:
        max_part = n
    if n == 0:
        return 1
    if n < 0 or max_part == 0:
        return 0
    return integer_partitions(n, max_part - 1) + integer_partitions(n - max_part, max_part)


def fibonacci_tilings(n: int) -> int:
    if n in (0, 1):
        return 1
    previous, current = 1, 1
    for _ in range(2, n + 1):
        previous, current = current, previous + current
    return current


def write_counting_method_audit() -> None:
    rows = load_csv("combinatorial_problems.csv")

    with (OUT_TABLES / "counting_method_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "problem_id",
                "name",
                "computed_count",
                "counting_interpretation",
                "assumption_summary",
                "validation_note",
            ],
        )
        writer.writeheader()

        for row in rows:
            problem_id = row["problem_id"]
            n = int(row["object_count"])
            k_text = row["selected_count"]

            if problem_id == "prob_committee":
                count = combination_count(n, int(k_text))
                note = "combination because order does not matter and repetition is not allowed"
            elif problem_id == "prob_ranked_finalists":
                count = permutation_count(n, int(k_text))
                note = "permutation because rank order matters"
            elif problem_id == "prob_binary_string_8":
                count = 2 ** n
                note = "multiplication principle with two symbols per position"
            elif problem_id == "prob_password_6":
                count = n ** int(k_text)
                note = "multiplication principle with repetition allowed"
            elif problem_id == "prob_no_repeat_code":
                count = permutation_count(n, int(k_text))
                note = "ordered selection without repetition"
            elif problem_id == "prob_graph_simple_6":
                count = simple_labeled_graph_count(n)
                note = "each possible undirected edge is present or absent"
            elif problem_id == "prob_multiples_2_or_3":
                count = n // 2 + n // 3 - n // 6
                note = "inclusion-exclusion subtracts overlap"
            elif problem_id == "prob_fibonacci_tilings":
                count = fibonacci_tilings(n)
                note = "recursive counting by first tile choice"
            elif problem_id == "prob_integer_partitions":
                count = integer_partitions(n)
                note = "unordered integer partitions"
            elif problem_id == "prob_feature_selection":
                count = 2 ** n
                note = "power set of possible feature subsets"
            else:
                count = -1
                note = "no method assigned"

            writer.writerow(
                {
                    "problem_id": problem_id,
                    "name": row["name"],
                    "computed_count": count,
                    "counting_interpretation": note,
                    "assumption_summary": f"order_matters={row['order_matters']}; repetition_allowed={row['repetition_allowed']}",
                    "validation_note": "count is meaningful only under the stated combinatorial assumptions",
                }
            )


def write_pascal_binomial_audit() -> None:
    with (OUT_TABLES / "pascal_binomial_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["n", "k", "binomial", "row_sum", "expected_power_of_two", "row_sum_agrees", "interpretation"],
        )
        writer.writeheader()

        for n in range(0, 13):
            row_sum = sum(comb(n, k) for k in range(0, n + 1))
            for k in range(0, n + 1):
                writer.writerow(
                    {
                        "n": n,
                        "k": k,
                        "binomial": comb(n, k),
                        "row_sum": row_sum,
                        "expected_power_of_two": 2 ** n,
                        "row_sum_agrees": row_sum == 2 ** n,
                        "interpretation": "binomial coefficients count k-element subsets; row sum counts all subsets",
                    }
                )


def write_recurrence_graph_partition_audit() -> None:
    with (OUT_TABLES / "recurrence_graph_partition_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["audit_type", "n", "value", "formula_or_rule", "interpretation"],
        )
        writer.writeheader()

        for n in range(0, 21):
            writer.writerow(
                {
                    "audit_type": "fibonacci_tilings",
                    "n": n,
                    "value": fibonacci_tilings(n),
                    "formula_or_rule": "a_n=a_(n-1)+a_(n-2)",
                    "interpretation": "tilings by first tile of size 1 or 2",
                }
            )

        for n in range(1, 16):
            writer.writerow(
                {
                    "audit_type": "integer_partitions",
                    "n": n,
                    "value": integer_partitions(n),
                    "formula_or_rule": "dynamic partition recurrence",
                    "interpretation": "unordered decompositions of integer n",
                }
            )

        for n in range(1, 9):
            writer.writerow(
                {
                    "audit_type": "simple_labeled_graphs",
                    "n": n,
                    "value": simple_labeled_graph_count(n),
                    "formula_or_rule": "2^C(n,2)",
                    "interpretation": "each possible edge is present or absent",
                }
            )

        for n in range(2, 9):
            writer.writerow(
                {
                    "audit_type": "labeled_trees",
                    "n": n,
                    "value": cayley_tree_count(n),
                    "formula_or_rule": "n^(n-2)",
                    "interpretation": "Cayley formula for labeled trees",
                }
            )


def write_search_space_growth_audit() -> None:
    with (OUT_TABLES / "search_space_growth_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["n", "subsets_2_power_n", "permutations_n_factorial", "simple_graphs_2_choose_edges", "interpretation"],
        )
        writer.writeheader()

        for n in range(1, 21):
            writer.writerow(
                {
                    "n": n,
                    "subsets_2_power_n": 2 ** n,
                    "permutations_n_factorial": factorial(n),
                    "simple_graphs_2_choose_edges": simple_labeled_graph_count(n),
                    "interpretation": "combinatorial spaces grow rapidly under simple rules",
                }
            )


def write_graph_count_dot() -> None:
    dot_path = OUT_FIGURES / "counting_decision_tree.dot"
    with dot_path.open("w", encoding="utf-8") as dot:
        dot.write("digraph counting_decision_tree {\n")
        dot.write('  graph [rankdir="TB"];\n')
        dot.write('  start [label="What is being counted?"];\n')
        dot.write('  order [label="Does order matter?"];\n')
        dot.write('  repetition [label="Is repetition allowed?"];\n')
        dot.write('  overlap [label="Do cases overlap?"];\n')
        dot.write('  symmetry [label="Are symmetries identified?"];\n')
        dot.write('  method [label="Choose method: permutation, combination, recurrence, inclusion-exclusion, generating function"];\n')
        dot.write("  start -> order;\n")
        dot.write("  order -> repetition;\n")
        dot.write("  repetition -> overlap;\n")
        dot.write("  overlap -> symmetry;\n")
        dot.write("  symmetry -> method;\n")
        dot.write("}\n")


def main() -> None:
    write_counting_method_audit()
    write_pascal_binomial_audit()
    write_recurrence_graph_partition_audit()
    write_search_space_growth_audit()
    write_graph_count_dot()

    print("Combinatorics workflow complete.")
    print(f"  {OUT_TABLES / 'counting_method_audit.csv'}")
    print(f"  {OUT_TABLES / 'pascal_binomial_audit.csv'}")
    print(f"  {OUT_TABLES / 'recurrence_graph_partition_audit.csv'}")
    print(f"  {OUT_TABLES / 'search_space_growth_audit.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'counting_decision_tree.dot'}")


if __name__ == "__main__":
    main()
