#!/usr/bin/env python3
"""
Historiographic audit for:
"The History of Mathematical Thinking from Antiquity to Modernity"

This workflow generates:
- historiographic warning index;
- tradition inclusion audit;
- period coverage audit;
- responsible-history checklist.
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


def write_warning_index() -> None:
    with (OUT / "historiographic_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["warning_id", "topic", "warning", "mitigation", "responsible_history_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("historiographic_warnings.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_history_note": "mathematical history should recognize universality of valid reasoning without erasing social, linguistic, institutional, and material conditions of knowledge",
                }
            )


def write_tradition_inclusion_audit() -> None:
    with (OUT / "tradition_inclusion_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "tradition_id",
            "name",
            "region_or_language_context",
            "primary_media",
            "dominant_thinking_mode",
            "historiographic_caution",
            "inclusion_reason",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("mathematical_traditions.csv"):
            writer.writerow(
                {
                    **row,
                    "inclusion_reason": "included to resist a narrow linear canon and foreground multiple forms of mathematical thinking",
                }
            )


def write_period_coverage_audit() -> None:
    milestones = load_csv("mathematical_milestones.csv")
    milestone_counts: dict[str, int] = {}
    for row in milestones:
        milestone_counts[row["period_id"]] = milestone_counts.get(row["period_id"], 0) + 1

    with (OUT / "period_coverage_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "period_id",
            "name",
            "approximate_range",
            "dominant_mathematical_mode",
            "representation_forms",
            "milestone_count",
            "coverage_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("historical_periods.csv"):
            writer.writerow(
                {
                    "period_id": row["period_id"],
                    "name": row["name"],
                    "approximate_range": row["approximate_range"],
                    "dominant_mathematical_mode": row["dominant_mathematical_mode"],
                    "representation_forms": row["representation_forms"],
                    "milestone_count": milestone_counts.get(row["period_id"], 0),
                    "coverage_note": "synthetic coverage supports teaching and should be expanded with specialist sources for scholarly use",
                }
            )


def write_responsible_history_checklist() -> None:
    warnings = load_csv("historiographic_warnings.csv")

    with (OUT / "responsible_history_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["check_id", "question", "risk_topic", "recommended_action"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for idx, row in enumerate(warnings, start=1):
            writer.writerow(
                {
                    "check_id": f"check_{idx:02d}",
                    "question": f"Does the narrative avoid this risk: {row['warning']}",
                    "risk_topic": row["topic"],
                    "recommended_action": row["mitigation"],
                }
            )


def main() -> None:
    write_warning_index()
    write_tradition_inclusion_audit()
    write_period_coverage_audit()
    write_responsible_history_checklist()

    print("Historiographic audit complete.")
    print(f"  {OUT / 'historiographic_warning_index.csv'}")
    print(f"  {OUT / 'tradition_inclusion_audit.csv'}")
    print(f"  {OUT / 'period_coverage_audit.csv'}")
    print(f"  {OUT / 'responsible_history_checklist.csv'}")


if __name__ == "__main__":
    main()
