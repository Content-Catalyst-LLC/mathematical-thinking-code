#!/usr/bin/env python3
"""
Truth tables and inference-rule audits for:
"Logic and the Structure of Formal Inference"

Outputs:
- implication and contrapositive truth table;
- common connective truth table;
- finite-domain implication audit;
- inference-rule catalog copied into normalized tabular output.
"""

from __future__ import annotations

import csv
from itertools import product
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


def implies(p: bool, q: bool) -> bool:
    return (not p) or q


def equivalent(p: bool, q: bool) -> bool:
    return p == q


def write_truth_tables() -> None:
    with (OUT / "truth_table_implication_contrapositive.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "P",
                "Q",
                "not_P",
                "not_Q",
                "P_implies_Q",
                "Q_implies_P_converse",
                "not_Q_implies_not_P_contrapositive",
                "contrapositive_equivalent_to_original",
            ],
        )
        writer.writeheader()
        for p, q in product([False, True], repeat=2):
            original = implies(p, q)
            contrapositive = implies(not q, not p)
            writer.writerow(
                {
                    "P": p,
                    "Q": q,
                    "not_P": not p,
                    "not_Q": not q,
                    "P_implies_Q": original,
                    "Q_implies_P_converse": implies(q, p),
                    "not_Q_implies_not_P_contrapositive": contrapositive,
                    "contrapositive_equivalent_to_original": equivalent(original, contrapositive),
                }
            )

    with (OUT / "truth_table_connectives.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["P", "Q", "P_and_Q", "P_or_Q", "not_P", "P_implies_Q", "P_iff_Q"])
        writer.writeheader()
        for p, q in product([False, True], repeat=2):
            writer.writerow(
                {
                    "P": p,
                    "Q": q,
                    "P_and_Q": p and q,
                    "P_or_Q": p or q,
                    "not_P": not p,
                    "P_implies_Q": implies(p, q),
                    "P_iff_Q": equivalent(p, q),
                }
            )


def is_even(n: int) -> bool:
    return n % 2 == 0


def square_is_even(n: int) -> bool:
    return (n * n) % 2 == 0


def write_finite_implication_audit() -> None:
    with (OUT / "finite_domain_implication_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["n", "premise_even", "conclusion_square_even", "implication_holds", "interpretation"],
        )
        writer.writeheader()
        for n in range(-50, 51):
            premise = is_even(n)
            conclusion = square_is_even(n)
            writer.writerow(
                {
                    "n": n,
                    "premise_even": premise,
                    "conclusion_square_even": conclusion,
                    "implication_holds": implies(premise, conclusion),
                    "interpretation": "finite audit supports but does not replace proof for arbitrary n",
                }
            )


def write_rule_catalog() -> None:
    with (DATA / "inference_rules.csv").open("r", encoding="utf-8") as src, (OUT / "inference_rule_catalog.csv").open("w", newline="", encoding="utf-8") as dst:
        reader = csv.DictReader(src)
        writer = csv.DictWriter(dst, fieldnames=["rule_id", "name", "formal_pattern", "description", "accepted_context"])
        writer.writeheader()
        for row in reader:
            writer.writerow(row)


def main() -> None:
    write_truth_tables()
    write_finite_implication_audit()
    write_rule_catalog()
    print("Truth table and inference-rule workflow complete.")
    print(f"  {OUT / 'truth_table_implication_contrapositive.csv'}")
    print(f"  {OUT / 'truth_table_connectives.csv'}")
    print(f"  {OUT / 'finite_domain_implication_audit.csv'}")
    print(f"  {OUT / 'inference_rule_catalog.csv'}")


if __name__ == "__main__":
    main()
