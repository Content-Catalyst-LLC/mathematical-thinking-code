#!/usr/bin/env python3
"""
Conjecture and evidence workflow for:
"Conjecture, Creativity, and Mathematical Discovery"

This workflow demonstrates:
- finite evidence audits;
- proof-status summaries;
- counterexample search;
- sequence pattern heuristics;
- separation of evidence, conjecture, and proof.
"""

from __future__ import annotations

import csv
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


def finite_differences(values: list[int]) -> list[int]:
    return [b - a for a, b in zip(values, values[1:])]


def classify_sequence(values: list[int]) -> str:
    if len(values) < 3:
        return "insufficient finite evidence"
    d1 = finite_differences(values)
    d2 = finite_differences(d1)
    if len(set(d1)) == 1:
        return "arithmetic"
    if d2 and len(set(d2)) == 1:
        return "quadratic"
    if all(v != 0 for v in values[:-1]):
        ratios = [b / a for a, b in zip(values, values[1:])]
        if len({round(r, 10) for r in ratios}) == 1:
            return "geometric"
    return "undetermined finite pattern"


def parse_terms(text: str) -> list[int]:
    return [int(part) for part in text.split() if part.strip()]


def is_even(n: int) -> bool:
    return n % 2 == 0


def even_square_claim(n: int) -> bool:
    return (not is_even(n)) or is_even(n * n)


def sum_first_n(n: int) -> int:
    return sum(range(1, n + 1))


def formula_sum_first_n(n: int) -> int:
    return n * (n + 1) // 2


def write_finite_evidence_audits() -> None:
    with (OUT / "finite_evidence_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "audit_id",
                "input_value",
                "computed_value",
                "expected_or_property",
                "agrees",
                "evidence_status",
                "proof_note",
            ],
        )
        writer.writeheader()

        for n in range(-100, 101):
            writer.writerow(
                {
                    "audit_id": "even_square",
                    "input_value": n,
                    "computed_value": n * n,
                    "expected_or_property": "if n even then n^2 even",
                    "agrees": even_square_claim(n),
                    "evidence_status": "finite evidence",
                    "proof_note": "direct proof handles arbitrary integer n",
                }
            )

        for n in range(1, 101):
            computed = sum_first_n(n)
            formula = formula_sum_first_n(n)
            writer.writerow(
                {
                    "audit_id": "sum_first_n",
                    "input_value": n,
                    "computed_value": computed,
                    "expected_or_property": formula,
                    "agrees": computed == formula,
                    "evidence_status": "finite evidence",
                    "proof_note": "induction proves universal statement",
                }
            )


def write_sequence_discovery() -> None:
    with (DATA / "sequence_terms.csv").open("r", encoding="utf-8") as src, (OUT / "sequence_conjecture_audit.csv").open("w", newline="", encoding="utf-8") as dst:
        reader = csv.DictReader(src)
        writer = csv.DictWriter(
            dst,
            fieldnames=[
                "sequence_id",
                "name",
                "terms",
                "expected_pattern",
                "heuristic_classification",
                "classification_matches_expected",
                "first_differences",
                "second_differences",
                "conjectured_rule",
                "proof_status",
                "interpretation",
            ],
        )
        writer.writeheader()

        for row in reader:
            terms = parse_terms(row["terms"])
            classification = classify_sequence(terms)
            d1 = finite_differences(terms)
            d2 = finite_differences(d1)
            writer.writerow(
                {
                    "sequence_id": row["sequence_id"],
                    "name": row["name"],
                    "terms": row["terms"],
                    "expected_pattern": row["expected_pattern"],
                    "heuristic_classification": classification,
                    "classification_matches_expected": classification == row["expected_pattern"],
                    "first_differences": " ".join(map(str, d1)),
                    "second_differences": " ".join(map(str, d2)),
                    "conjectured_rule": row["conjectured_rule"],
                    "proof_status": row["proof_status"],
                    "interpretation": "finite pattern detection can suggest conjectures but must be proof-status labeled",
                }
            )


def write_proof_status_summary() -> None:
    evidence_count: dict[str, int] = defaultdict(int)
    counterexample_count: dict[str, int] = defaultdict(int)
    proof_attempt_count: dict[str, int] = defaultdict(int)
    successful_attempt_count: dict[str, int] = defaultdict(int)

    with (DATA / "evidence_records.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            evidence_count[row["conjecture_id"]] += 1

    with (DATA / "counterexamples.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            counterexample_count[row["conjecture_id"]] += 1

    with (DATA / "proof_attempts.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            cid = row["conjecture_id"]
            proof_attempt_count[cid] += 1
            if row["status"].startswith("successful"):
                successful_attempt_count[cid] += 1

    with (DATA / "conjectures.csv").open("r", encoding="utf-8") as src, (OUT / "conjecture_status_summary.csv").open("w", newline="", encoding="utf-8") as dst:
        reader = csv.DictReader(src)
        writer = csv.DictWriter(
            dst,
            fieldnames=[
                "conjecture_id",
                "statement",
                "mathematical_area",
                "proof_status",
                "evidence_records",
                "counterexample_records",
                "proof_attempts",
                "successful_attempts",
                "status_interpretation",
            ],
        )
        writer.writeheader()

        for row in reader:
            cid = row["conjecture_id"]
            if counterexample_count[cid]:
                interpretation = "counterexample evidence requires refutation or refinement"
            elif row["proof_status"].startswith("proved"):
                interpretation = "proved under stated assumptions; finite evidence remains illustrative"
            else:
                interpretation = "requires additional proof-status review"

            writer.writerow(
                {
                    "conjecture_id": cid,
                    "statement": row["statement"],
                    "mathematical_area": row["mathematical_area"],
                    "proof_status": row["proof_status"],
                    "evidence_records": evidence_count[cid],
                    "counterexample_records": counterexample_count[cid],
                    "proof_attempts": proof_attempt_count[cid],
                    "successful_attempts": successful_attempt_count[cid],
                    "status_interpretation": interpretation,
                }
            )


def write_counterexample_trace() -> None:
    with (OUT / "bounded_sequence_counterexample_trace.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["index", "value", "bounded", "convergence_note"])
        writer.writeheader()
        for n in range(0, 50):
            value = (-1) ** n
            writer.writerow(
                {
                    "index": n,
                    "value": value,
                    "bounded": abs(value) <= 1,
                    "convergence_note": "alternating sequence remains bounded but does not converge",
                }
            )


def main() -> None:
    write_finite_evidence_audits()
    write_sequence_discovery()
    write_proof_status_summary()
    write_counterexample_trace()

    print("Conjecture evidence workflow complete.")
    print(f"  {OUT / 'finite_evidence_audit.csv'}")
    print(f"  {OUT / 'sequence_conjecture_audit.csv'}")
    print(f"  {OUT / 'conjecture_status_summary.csv'}")
    print(f"  {OUT / 'bounded_sequence_counterexample_trace.csv'}")


if __name__ == "__main__":
    main()
