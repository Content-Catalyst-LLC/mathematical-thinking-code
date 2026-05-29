#!/usr/bin/env python3
"""
Sequence and recurrence exploration for the article:
"What Is Mathematical Thinking?"

The module emphasizes:
- recurrence generation
- residue patterns
- periodicity search
- conjecture scaffolding
- reproducible output tables
"""

from __future__ import annotations

import csv
from dataclasses import dataclass
from pathlib import Path
from typing import Callable, Iterable

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


@dataclass(frozen=True)
class LinearRecurrence:
    name: str
    seeds: tuple[int, ...]
    coefficients: tuple[int, ...]

    def generate(self, n: int) -> list[int]:
        if n <= 0:
            return []
        values = list(self.seeds[:n])
        order = len(self.coefficients)
        while len(values) < n:
            window = values[-order:]
            values.append(sum(c * x for c, x in zip(self.coefficients, window)))
        return values


def residues(values: Iterable[int], modulus: int) -> list[int]:
    return [value % modulus for value in values]


def minimal_period(values: list[int], max_period: int | None = None) -> int | None:
    if not values:
        return None
    limit = max_period or max(1, len(values) // 2)
    for period in range(1, limit + 1):
        ok = True
        for i in range(len(values) - period):
            if values[i] != values[i + period]:
                ok = False
                break
        if ok:
            return period
    return None


def finite_difference(values: list[int]) -> list[int]:
    return [b - a for a, b in zip(values, values[1:])]


def write_sequence_table(recurrences: list[LinearRecurrence], n: int = 30) -> None:
    rows: list[dict[str, object]] = []
    for rec in recurrences:
        values = rec.generate(n)
        diff1 = finite_difference(values)
        for i, value in enumerate(values):
            rows.append(
                {
                    "sequence": rec.name,
                    "index": i,
                    "value": value,
                    "mod_2": value % 2,
                    "mod_3": value % 3,
                    "mod_5": value % 5,
                    "first_difference": "" if i == 0 else diff1[i - 1],
                }
            )

    with (OUT / "sequence_analysis.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "sequence",
                "index",
                "value",
                "mod_2",
                "mod_3",
                "mod_5",
                "first_difference",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)


def write_period_table(recurrences: list[LinearRecurrence], n: int = 90) -> None:
    rows: list[dict[str, object]] = []
    for rec in recurrences:
        values = rec.generate(n)
        for modulus in range(2, 13):
            residue_values = residues(values, modulus)
            rows.append(
                {
                    "sequence": rec.name,
                    "modulus": modulus,
                    "observed_minimal_period": minimal_period(residue_values, max_period=50),
                    "sample_prefix": " ".join(map(str, residue_values[:20])),
                }
            )

    with (OUT / "residue_periods.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "sequence",
                "modulus",
                "observed_minimal_period",
                "sample_prefix",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    recurrences = [
        LinearRecurrence("fibonacci", seeds=(0, 1), coefficients=(1, 1)),
        LinearRecurrence("lucas", seeds=(2, 1), coefficients=(1, 1)),
        LinearRecurrence("pell", seeds=(0, 1), coefficients=(1, 2)),
    ]

    write_sequence_table(recurrences)
    write_period_table(recurrences)

    print("Wrote:")
    print(f"  {OUT / 'sequence_analysis.csv'}")
    print(f"  {OUT / 'residue_periods.csv'}")


if __name__ == "__main__":
    main()
