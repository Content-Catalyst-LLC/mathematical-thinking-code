#!/usr/bin/env python3
"""
Number and pattern workflow for:
"Number, Pattern, and the Origins of Mathematical Thought"

This workflow demonstrates:
- one-to-one tally correspondence;
- finite-difference sequence classification;
- cyclic pattern detection;
- finite evidence versus proof-status discipline.
"""

from __future__ import annotations

import csv
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


@dataclass(frozen=True)
class TallyRecord:
    collection_id: str
    object_id: str
    mark: str
    correspondence_note: str


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def parse_values(text: str) -> list[int]:
    return [int(part) for part in text.split() if part.strip()]


def finite_differences(values: list[int]) -> list[int]:
    return [b - a for a, b in zip(values, values[1:])]


def ratios(values: list[int]) -> list[float]:
    result = []
    for a, b in zip(values, values[1:]):
        if a == 0:
            return []
        result.append(b / a)
    return result


def classify_sequence(values: list[int]) -> str:
    if len(values) < 3:
        return "insufficient finite evidence"

    d1 = finite_differences(values)
    d2 = finite_differences(d1)

    if d1 and len(set(d1)) == 1:
        return "arithmetic"
    if d2 and len(set(d2)) == 1:
        return "quadratic"

    r = ratios(values)
    if r and len({round(x, 10) for x in r}) == 1:
        return "geometric"

    if len(values) >= 6 and len(set(values)) < len(values):
        return "cyclic_or_repeating"

    return "undetermined finite pattern"


def write_tally_correspondence() -> None:
    rows = load_csv("counting_objects.csv")

    with (OUT / "tally_correspondence_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "collection_id",
                "object_id",
                "mark",
                "one_to_one_index",
                "correspondence_note",
            ],
        )
        writer.writeheader()

        counters: dict[str, int] = {}
        for row in rows:
            collection = row["collection_id"]
            counters[collection] = counters.get(collection, 0) + 1
            record = TallyRecord(
                collection_id=collection,
                object_id=row["object_id"],
                mark="|",
                correspondence_note="one object corresponds to one mark",
            )
            writer.writerow(
                {
                    "collection_id": record.collection_id,
                    "object_id": record.object_id,
                    "mark": record.mark,
                    "one_to_one_index": counters[collection],
                    "correspondence_note": record.correspondence_note,
                }
            )


def write_sequence_pattern_audit() -> None:
    rows = load_csv("sequences.csv")

    with (OUT / "sequence_pattern_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "sequence_id",
                "name",
                "values",
                "expected_pattern",
                "heuristic_classification",
                "classification_matches_expected",
                "first_differences",
                "second_differences",
                "possible_rule",
                "proof_status",
                "interpretation",
            ],
        )
        writer.writeheader()

        for row in rows:
            values = parse_values(row["values"])
            d1 = finite_differences(values)
            d2 = finite_differences(d1)
            classification = classify_sequence(values)

            if row["expected_pattern"] == "cyclic" and classification == "cyclic_or_repeating":
                matches = True
            else:
                matches = classification == row["expected_pattern"]

            writer.writerow(
                {
                    "sequence_id": row["sequence_id"],
                    "name": row["name"],
                    "values": row["values"],
                    "expected_pattern": row["expected_pattern"],
                    "heuristic_classification": classification,
                    "classification_matches_expected": matches,
                    "first_differences": " ".join(map(str, d1)),
                    "second_differences": " ".join(map(str, d2)),
                    "possible_rule": row["possible_rule"],
                    "proof_status": row["proof_status"],
                    "interpretation": "finite pattern detection suggests structure but must be proof-status labeled",
                }
            )


def write_triangular_number_audit() -> None:
    with (OUT / "triangular_number_finite_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["n", "computed_sum", "formula_value", "agrees", "evidence_status"],
        )
        writer.writeheader()

        for n in range(1, 101):
            computed = sum(range(1, n + 1))
            formula = n * (n + 1) // 2
            writer.writerow(
                {
                    "n": n,
                    "computed_sum": computed,
                    "formula_value": formula,
                    "agrees": computed == formula,
                    "evidence_status": "finite agreement; induction proves general rule",
                }
            )


def main() -> None:
    write_tally_correspondence()
    write_sequence_pattern_audit()
    write_triangular_number_audit()

    print("Number and pattern workflow complete.")
    print(f"  {OUT / 'tally_correspondence_audit.csv'}")
    print(f"  {OUT / 'sequence_pattern_audit.csv'}")
    print(f"  {OUT / 'triangular_number_finite_audit.csv'}")


if __name__ == "__main__":
    main()
