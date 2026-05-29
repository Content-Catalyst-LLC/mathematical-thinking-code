#!/usr/bin/env python3
"""
Pattern interpretation audit for:
"Number, Pattern, and the Origins of Mathematical Thought"

This workflow connects patterns, representations, proof status,
warnings, and responsible interpretation.
"""

from __future__ import annotations

import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def write_pattern_warning_index() -> None:
    patterns = {row["pattern_id"]: row for row in load_csv("pattern_records.csv")}
    warnings = load_csv("interpretation_warnings.csv")

    with (OUT / "pattern_interpretation_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "warning_id",
                "pattern_id",
                "pattern_type",
                "example",
                "possible_rule",
                "proof_status",
                "warning",
                "mitigation",
            ],
        )
        writer.writeheader()

        for row in warnings:
            pattern = patterns.get(row["pattern_id"], {})
            writer.writerow(
                {
                    "warning_id": row["warning_id"],
                    "pattern_id": row["pattern_id"],
                    "pattern_type": pattern.get("pattern_type", ""),
                    "example": pattern.get("example", ""),
                    "possible_rule": pattern.get("possible_rule", ""),
                    "proof_status": pattern.get("proof_status", ""),
                    "warning": row["warning"],
                    "mitigation": row["mitigation"],
                }
            )


def write_representation_preservation_audit() -> None:
    rows = load_csv("representation_practices.csv")

    with (OUT / "representation_preservation_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "practice_id",
                "origin_id",
                "representation_type",
                "example",
                "preserved_structure",
                "omitted_detail",
                "interpretation",
            ],
        )
        writer.writeheader()

        for row in rows:
            writer.writerow(
                {
                    **row,
                    "interpretation": "mathematical representations preserve selected structure while omitting other context",
                }
            )


def write_cultural_practice_index() -> None:
    rows = load_csv("cultural_practices.csv")

    with (OUT / "cultural_mathematics_practice_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["practice_id", "name", "mathematical_form", "embedded_knowledge", "series_note"],
        )
        writer.writeheader()

        for row in rows:
            writer.writerow(
                {
                    **row,
                    "series_note": "mathematical thought emerges through culture, labor, memory, craft, and symbolic practice",
                }
            )


def main() -> None:
    write_pattern_warning_index()
    write_representation_preservation_audit()
    write_cultural_practice_index()

    print("Pattern interpretation audit complete.")
    print(f"  {OUT / 'pattern_interpretation_warning_index.csv'}")
    print(f"  {OUT / 'representation_preservation_audit.csv'}")
    print(f"  {OUT / 'cultural_mathematics_practice_index.csv'}")


if __name__ == "__main__":
    main()
