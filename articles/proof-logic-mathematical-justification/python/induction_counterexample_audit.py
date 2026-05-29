#!/usr/bin/env python3
"""
Induction and counterexample audit.

This workflow separates:
- finite evidence;
- induction mechanism;
- counterexample records;
- proof-status summaries.
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


def even_square_property(n: int) -> bool:
    if n % 2 != 0:
        return True
    return (n * n) % 2 == 0


def write_finite_audit(max_n: int = 100) -> None:
    with (OUT / "finite_evidence_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "test_type",
                "index_or_value",
                "computed_value",
                "formula_or_property_value",
                "agrees",
                "interpretation",
            ],
        )
        writer.writeheader()

        for n in range(1, max_n + 1):
            computed = sum_first_n(n)
            formula = formula_sum_first_n(n)
            writer.writerow(
                {
                    "test_type": "sum_first_n",
                    "index_or_value": n,
                    "computed_value": computed,
                    "formula_or_property_value": formula,
                    "agrees": computed == formula,
                    "interpretation": "finite evidence; induction proves the theorem",
                }
            )

        for n in range(-50, 51):
            writer.writerow(
                {
                    "test_type": "even_square_property",
                    "index_or_value": n,
                    "computed_value": n * n,
                    "formula_or_property_value": "even square property",
                    "agrees": even_square_property(n),
                    "interpretation": "finite evidence; direct proof establishes the lemma",
                }
            )


def write_counterexample_traces(length: int = 40) -> None:
    with (OUT / "counterexample_traces.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["claim_id", "object_name", "index", "value", "bounded", "convergent_interpretation"],
        )
        writer.writeheader()
        for n in range(length):
            value = (-1) ** n
            writer.writerow(
                {
                    "claim_id": "claim_bounded_converges",
                    "object_name": "alternating_sequence",
                    "index": n,
                    "value": value,
                    "bounded": abs(value) <= 1,
                    "convergent_interpretation": "oscillates; boundedness alone does not imply convergence",
                }
            )


def write_proof_status_summary() -> None:
    counterexample_count: dict[str, int] = {}
    with (DATA / "counterexamples.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            counterexample_count[row["claim_id"]] = counterexample_count.get(row["claim_id"], 0) + 1

    finite_evidence_count: dict[str, int] = {}
    with (DATA / "finite_evidence.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            finite_evidence_count[row["claim_id"]] = finite_evidence_count.get(row["claim_id"], 0) + 1

    with (DATA / "claims.csv").open("r", encoding="utf-8") as claims, (OUT / "proof_status_summary.csv").open("w", newline="", encoding="utf-8") as out:
        reader = csv.DictReader(claims)
        writer = csv.DictWriter(
            out,
            fieldnames=[
                "claim_id",
                "title",
                "claim_type",
                "proof_status",
                "finite_evidence_records",
                "counterexample_records",
                "interpretation",
            ],
        )
        writer.writeheader()

        for row in reader:
            cid = row["claim_id"]
            ce = counterexample_count.get(cid, 0)
            ev = finite_evidence_count.get(cid, 0)
            if ce:
                interpretation = "refuted or refined by counterexample"
            elif row["proof_status"].startswith("proved"):
                interpretation = "proved; finite evidence may illustrate but does not justify alone"
            elif row["claim_type"] == "inference_rule":
                interpretation = "inference rule or accepted proof principle"
            else:
                interpretation = "requires proof-status review"

            writer.writerow(
                {
                    "claim_id": cid,
                    "title": row["title"],
                    "claim_type": row["claim_type"],
                    "proof_status": row["proof_status"],
                    "finite_evidence_records": ev,
                    "counterexample_records": ce,
                    "interpretation": interpretation,
                }
            )


def main() -> None:
    write_finite_audit()
    write_counterexample_traces()
    write_proof_status_summary()

    print("Induction and counterexample audit complete.")
    print(f"  {OUT / 'finite_evidence_audit.csv'}")
    print(f"  {OUT / 'counterexample_traces.csv'}")
    print(f"  {OUT / 'proof_status_summary.csv'}")


if __name__ == "__main__":
    main()
