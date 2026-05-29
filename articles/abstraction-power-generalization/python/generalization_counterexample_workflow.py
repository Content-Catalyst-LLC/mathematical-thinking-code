#!/usr/bin/env python3
"""
Generalization and counterexample workflow.

This script treats mathematical generalizations as records with:
- claim
- domain
- assumptions
- proof status
- counterexample links

It also demonstrates finite-case testing as evidence for conjecture, not proof.
"""

from __future__ import annotations

import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


def sum_first_n(n: int) -> int:
    return sum(range(1, n + 1))


def formula_sum_first_n(n: int) -> int:
    return n * (n + 1) // 2


def alternating_sequence(n: int) -> list[int]:
    return [(-1) ** k for k in range(n)]


def write_finite_case_audit(max_n: int = 100) -> None:
    with (OUT / "finite_case_generalization_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["n", "computed_sum", "formula_value", "agrees", "interpretation"],
        )
        writer.writeheader()
        for n in range(1, max_n + 1):
            computed = sum_first_n(n)
            formula = formula_sum_first_n(n)
            writer.writerow(
                {
                    "n": n,
                    "computed_sum": computed,
                    "formula_value": formula,
                    "agrees": computed == formula,
                    "interpretation": "supporting finite evidence, not a substitute for proof",
                }
            )


def write_bounded_nonconvergent_counterexample(n: int = 40) -> None:
    values = alternating_sequence(n)
    with (OUT / "bounded_nonconvergent_sequence.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["index", "value", "absolute_value"])
        writer.writeheader()
        for index, value in enumerate(values):
            writer.writerow({"index": index, "value": value, "absolute_value": abs(value)})


def summarize_generalizations() -> None:
    counterexamples: dict[str, list[str]] = {}
    with (DATA / "counterexamples.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            counterexamples.setdefault(row["generalization_id"], []).append(row["counterexample_id"])

    rows: list[dict[str, object]] = []
    with (DATA / "generalizations.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            linked = counterexamples.get(row["generalization_id"], [])
            rows.append(
                {
                    **row,
                    "counterexample_count": len(linked),
                    "counterexamples": " ".join(linked),
                    "status_interpretation": "refined_or_refuted" if linked else "requires proof record or accepted proof",
                }
            )

    with (OUT / "generalization_counterexample_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "generalization_id",
                "abstraction_id",
                "claim",
                "domain",
                "required_assumptions",
                "proof_status",
                "counterexample_count",
                "counterexamples",
                "status_interpretation",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    write_finite_case_audit()
    write_bounded_nonconvergent_counterexample()
    summarize_generalizations()

    print("Generalization and counterexample workflow complete.")
    print(f"  {OUT / 'finite_case_generalization_audit.csv'}")
    print(f"  {OUT / 'bounded_nonconvergent_sequence.csv'}")
    print(f"  {OUT / 'generalization_counterexample_summary.csv'}")


if __name__ == "__main__":
    main()
