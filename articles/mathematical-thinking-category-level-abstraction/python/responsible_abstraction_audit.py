#!/usr/bin/env python3
"""
Responsible abstraction audit for:
"Mathematical Thinking and Category-Level Abstraction"

This workflow generates:
- abstraction risk indexes;
- responsible abstraction checklists;
- preservation/forgetting review tables;
- functor review crosswalks.
"""

from __future__ import annotations

import csv
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def write_abstraction_risk_index() -> None:
    with (OUT / "abstraction_risk_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["risk_id", "risk_name", "problem", "mitigation", "responsible_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("abstraction_risks.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_note": "category-level abstraction should remain grounded in examples, preservation, implementation, and interpretation",
                }
            )


def write_responsible_checklist() -> None:
    with (OUT / "responsible_abstraction_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["check_id", "stage", "question", "failure_mode", "mitigation", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("responsible_abstraction_checks.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "objects, arrows, structure, universality, and responsibility should all be made explicit",
                }
            )


def write_preservation_forgetting_review() -> None:
    functors = load_csv("functor_records.csv")

    with (OUT / "preservation_forgetting_review.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["functor_id", "functor_name", "preserved_property", "forgotten_or_added_structure", "review_question"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in functors:
            writer.writerow(
                {
                    "functor_id": row["functor_id"],
                    "functor_name": row["functor_name"],
                    "preserved_property": row["preserved_property"],
                    "forgotten_or_added_structure": row["forgotten_or_added_structure"],
                    "review_question": "What does this translation preserve, forget, add, or make invisible?",
                }
            )


def write_universal_property_review() -> None:
    properties = load_csv("universal_property_records.csv")
    shape_counts = Counter(row["diagram_shape"] for row in properties)

    with (OUT / "universal_property_shape_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["diagram_shape", "count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for shape, count in sorted(shape_counts.items()):
            writer.writerow(
                {
                    "diagram_shape": shape,
                    "count": count,
                    "interpretation": "diagram shape helps identify the universal role a construction satisfies",
                }
            )


def main() -> None:
    write_abstraction_risk_index()
    write_responsible_checklist()
    write_preservation_forgetting_review()
    write_universal_property_review()

    print("Responsible abstraction audit complete.")
    print(f"  {OUT / 'abstraction_risk_index.csv'}")
    print(f"  {OUT / 'responsible_abstraction_checklist.csv'}")
    print(f"  {OUT / 'preservation_forgetting_review.csv'}")
    print(f"  {OUT / 'universal_property_shape_summary.csv'}")


if __name__ == "__main__":
    main()
