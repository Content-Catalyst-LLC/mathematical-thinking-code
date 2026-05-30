#!/usr/bin/env python3
"""
Historiography audit for:
"The Historical Development of Proof"

This workflow demonstrates:
- responsible history warnings;
- tradition inclusion audit;
- proof-style limitation index;
- canon-risk checklist.
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
                    "responsible_history_note": "proof history should recognize distinct traditions without reducing them to a single triumphalist path",
                }
            )


def write_tradition_inclusion_audit() -> None:
    with (OUT / "tradition_inclusion_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "tradition_id",
            "name",
            "period",
            "region_or_language_context",
            "dominant_proof_style",
            "interpretation_note",
            "inclusion_reason",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_traditions.csv"):
            writer.writerow(
                {
                    **row,
                    "inclusion_reason": "included to avoid narrowing proof history to a single Greek-European formalization narrative",
                }
            )


def write_style_limitation_index() -> None:
    with (OUT / "proof_style_limitation_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["style_id", "name", "typical_medium", "accepted_ground", "strength", "limitation_note", "audit_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_styles.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "style classifications are analytic tools and should not be treated as fixed civilizational rankings",
                }
            )


def write_canon_risk_checklist() -> None:
    warnings = load_csv("historiographic_warnings.csv")

    with (OUT / "canon_risk_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["check_id", "question", "risk_topic", "recommended_action"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for idx, row in enumerate(warnings, start=1):
            writer.writerow(
                {
                    "check_id": f"check_{idx:02d}",
                    "question": f"Does the article avoid this risk: {row['warning']}",
                    "risk_topic": row["topic"],
                    "recommended_action": row["mitigation"],
                }
            )


def main() -> None:
    write_warning_index()
    write_tradition_inclusion_audit()
    write_style_limitation_index()
    write_canon_risk_checklist()

    print("Historiography audit complete.")
    print(f"  {OUT / 'historiographic_warning_index.csv'}")
    print(f"  {OUT / 'tradition_inclusion_audit.csv'}")
    print(f"  {OUT / 'proof_style_limitation_index.csv'}")
    print(f"  {OUT / 'canon_risk_checklist.csv'}")


if __name__ == "__main__":
    main()
