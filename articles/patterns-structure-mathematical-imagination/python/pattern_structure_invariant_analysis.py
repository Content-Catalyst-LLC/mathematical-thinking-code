#!/usr/bin/env python3
"""
Pattern, structure, and invariant analysis.

This script creates compact reproducible outputs for:
- sequence feature extraction
- finite differences
- residue patterns
- observed periodicity
- conjecture discipline through computed summaries
"""

from __future__ import annotations

import csv
from pathlib import Path
from typing import Iterable

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw" / "pattern_sequences.csv"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


def parse_terms(text: str) -> list[int]:
    return [int(part) for part in text.split() if part.strip()]


def finite_differences(values: list[int]) -> list[int]:
    return [b - a for a, b in zip(values, values[1:])]


def residues(values: Iterable[int], modulus: int) -> list[int]:
    return [value % modulus for value in values]


def observed_period(values: list[int]) -> int | None:
    if not values:
        return None
    for p in range(1, max(1, len(values) // 2) + 1):
        if all(values[i] == values[i + p] for i in range(len(values) - p)):
            return p
    return None


def load_sequences() -> list[dict[str, str]]:
    with DATA.open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def main() -> None:
    rows: list[dict[str, object]] = []
    summary: list[dict[str, object]] = []

    for item in load_sequences():
        terms = parse_terms(item["initial_terms"])
        diff1 = finite_differences(terms)
        mod2 = residues(terms, 2)
        mod3 = residues(terms, 3)

        summary.append(
            {
                "sequence_id": item["sequence_id"],
                "name": item["name"],
                "pattern_type": item["pattern_type"],
                "structural_interpretation": item["structural_interpretation"],
                "length": len(terms),
                "mod2_observed_period": observed_period(mod2),
                "mod3_observed_period": observed_period(mod3),
                "first_difference_prefix": " ".join(map(str, diff1)),
            }
        )

        for index, value in enumerate(terms):
            rows.append(
                {
                    "sequence_id": item["sequence_id"],
                    "index": index,
                    "value": value,
                    "mod_2": value % 2,
                    "mod_3": value % 3,
                    "first_difference": "" if index == 0 else terms[index] - terms[index - 1],
                }
            )

    with (OUT / "sequence_feature_table.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "sequence_id",
                "index",
                "value",
                "mod_2",
                "mod_3",
                "first_difference",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)

    with (OUT / "sequence_pattern_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "sequence_id",
                "name",
                "pattern_type",
                "structural_interpretation",
                "length",
                "mod2_observed_period",
                "mod3_observed_period",
                "first_difference_prefix",
            ],
        )
        writer.writeheader()
        writer.writerows(summary)

    print("Wrote sequence feature outputs:")
    print(f"  {OUT / 'sequence_feature_table.csv'}")
    print(f"  {OUT / 'sequence_pattern_summary.csv'}")


if __name__ == "__main__":
    main()
