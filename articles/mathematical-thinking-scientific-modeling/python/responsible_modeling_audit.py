#!/usr/bin/env python3
"""
Responsible modeling audit for:
"Mathematical Thinking and Scientific Modeling"

This workflow generates:
- model-risk indexes;
- responsible modeling checklists;
- validation-by-purpose tables;
- uncertainty review tables.
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


def write_model_risk_index() -> None:
    with (OUT / "model_risk_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["risk_id", "risk_name", "problem", "mitigation", "responsible_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("model_risks.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_note": "scientific models require transparency, uncertainty, scope limits, validation, and responsible interpretation",
                }
            )


def write_responsible_modeling_checklist() -> None:
    with (OUT / "responsible_modeling_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["check_id", "stage", "question", "failure_mode", "mitigation", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("responsible_modeling_checks.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "scientific modeling should move through representation, relationship, testing, revision, and responsibility",
                }
            )


def write_validation_by_purpose() -> None:
    models = load_csv("scientific_model_records.csv")
    validations = load_csv("validation_records.csv")
    validation_by_model = {row["model_id"]: row for row in validations}

    with (OUT / "validation_by_purpose.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["model_id", "model_name", "purpose", "validation_type", "credibility_note", "review_question"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for model in models:
            val = validation_by_model.get(model["model_id"], {})
            writer.writerow(
                {
                    "model_id": model["model_id"],
                    "model_name": model["model_name"],
                    "purpose": model["purpose"],
                    "validation_type": val.get("validation_type", "not documented"),
                    "credibility_note": val.get("credibility_note", "validation not documented"),
                    "review_question": "Does the validation evidence match the model purpose and intended use?",
                }
            )


def write_uncertainty_review() -> None:
    uncertainty = load_csv("uncertainty_sources.csv")
    source_counts = Counter(row["source_type"] for row in uncertainty)

    with (OUT / "uncertainty_source_counts.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["source_type", "count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for source_type, count in sorted(source_counts.items()):
            writer.writerow(
                {
                    "source_type": source_type,
                    "count": count,
                    "interpretation": "uncertainty sources should be separately identified rather than collapsed into vague caution",
                }
            )


def main() -> None:
    write_model_risk_index()
    write_responsible_modeling_checklist()
    write_validation_by_purpose()
    write_uncertainty_review()

    print("Responsible modeling audit complete.")
    print(f"  {OUT / 'model_risk_index.csv'}")
    print(f"  {OUT / 'responsible_modeling_checklist.csv'}")
    print(f"  {OUT / 'validation_by_purpose.csv'}")
    print(f"  {OUT / 'uncertainty_source_counts.csv'}")


if __name__ == "__main__":
    main()
