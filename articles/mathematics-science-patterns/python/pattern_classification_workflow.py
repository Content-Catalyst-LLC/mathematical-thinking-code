#!/usr/bin/env python3
"""
Pattern classification workflow for:
"Mathematics as the Science of Patterns"

This workflow demonstrates:
- finite difference analysis;
- arithmetic / quadratic / geometric / periodic heuristics;
- proof-status caution;
- counterexample-aware pattern classification.
"""

from __future__ import annotations

import csv
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw" / "sequence_patterns.csv"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


@dataclass(frozen=True)
class SequenceRecord:
    sequence_id: str
    name: str
    terms: list[int]
    expected_pattern: str
    mathematical_structure: str
    proof_note: str


def parse_terms(text: str) -> list[int]:
    return [int(part) for part in text.split() if part.strip()]


def finite_differences(values: list[int]) -> list[int]:
    return [b - a for a, b in zip(values, values[1:])]


def ratio_pattern(values: list[int]) -> bool:
    if len(values) < 3 or any(value == 0 for value in values[:-1]):
        return False
    ratios: list[float] = []
    for a, b in zip(values, values[1:]):
        ratios.append(b / a)
    return len({round(r, 10) for r in ratios}) == 1


def observed_period(values: list[int]) -> int | None:
    if not values:
        return None
    for period in range(1, max(1, len(values) // 2) + 1):
        if all(values[i] == values[i + period] for i in range(len(values) - period)):
            return period
    return None


def classify_sequence(values: list[int]) -> str:
    if len(values) < 3:
        return "insufficient finite evidence"

    d1 = finite_differences(values)
    d2 = finite_differences(d1)

    if len(set(d1)) == 1:
        return "arithmetic"
    if len(d2) > 0 and len(set(d2)) == 1:
        return "quadratic"
    if ratio_pattern(values):
        return "geometric"
    if observed_period(values) is not None:
        return "periodic"
    return "undetermined finite pattern"


def load_sequences() -> list[SequenceRecord]:
    with DATA.open("r", encoding="utf-8") as handle:
        return [
            SequenceRecord(
                sequence_id=row["sequence_id"],
                name=row["name"],
                terms=parse_terms(row["terms"]),
                expected_pattern=row["expected_pattern"],
                mathematical_structure=row["mathematical_structure"],
                proof_note=row["proof_note"],
            )
            for row in csv.DictReader(handle)
        ]


def main() -> None:
    records = load_sequences()
    rows: list[dict[str, object]] = []

    for record in records:
        d1 = finite_differences(record.terms)
        d2 = finite_differences(d1)
        classification = classify_sequence(record.terms)
        rows.append(
            {
                "sequence_id": record.sequence_id,
                "name": record.name,
                "terms": " ".join(map(str, record.terms)),
                "expected_pattern": record.expected_pattern,
                "heuristic_classification": classification,
                "classification_matches_expected": classification == record.expected_pattern,
                "first_differences": " ".join(map(str, d1)),
                "second_differences": " ".join(map(str, d2)),
                "observed_period": observed_period(record.terms),
                "mathematical_structure": record.mathematical_structure,
                "proof_note": record.proof_note,
            }
        )

    with (OUT / "sequence_pattern_classification.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "sequence_id",
                "name",
                "terms",
                "expected_pattern",
                "heuristic_classification",
                "classification_matches_expected",
                "first_differences",
                "second_differences",
                "observed_period",
                "mathematical_structure",
                "proof_note",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)

    print("Pattern classification workflow complete.")
    print(f"  {OUT / 'sequence_pattern_classification.csv'}")


if __name__ == "__main__":
    main()
