#!/usr/bin/env python3
"""
Responsible generalization audit for:
"Historical Development and the Unity of Mathematical Ideas"

This workflow generates:
- responsible generalization warning index;
- formal similarity vs contextual sameness checklist;
- model migration audit table;
- idea transfer risk checklist.
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
    with (OUT / "responsible_generalization_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["warning_id", "topic", "warning", "mitigation", "responsible_generalization_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("responsible_generalization_warnings.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_generalization_note": "mathematical unity should identify what is shared without erasing what differs",
                }
            )


def write_formal_similarity_checklist() -> None:
    checks = [
        {
            "check_id": "check_01",
            "question": "What structure is actually preserved across the two contexts?",
            "risk": "false equivalence",
            "mitigation": "state the preserved relation, operation, invariant, or evidence standard",
        },
        {
            "check_id": "check_02",
            "question": "What changes when the idea moves from one field to another?",
            "risk": "context erasure",
            "mitigation": "document domain assumptions, interpretation, data, and consequences",
        },
        {
            "check_id": "check_03",
            "question": "Is the transfer a proof, analogy, model, algorithm, or heuristic?",
            "risk": "evidence confusion",
            "mitigation": "separate proof standards from model validation and computational exploration",
        },
        {
            "check_id": "check_04",
            "question": "Who or what may be affected if the generalization is applied?",
            "risk": "optimization or model harm",
            "mitigation": "include ethical and stakeholder review when mathematical ideas guide decisions",
        },
        {
            "check_id": "check_05",
            "question": "Does the historical framing preserve the original tradition's terms, media, and purposes?",
            "risk": "historical flattening",
            "mitigation": "distinguish modern reconstruction from historical practice",
        },
    ]

    with (OUT / "formal_similarity_vs_contextual_sameness_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["check_id", "question", "risk", "mitigation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(checks)


def write_model_migration_audit() -> None:
    with (OUT / "model_migration_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "connection_id",
            "source_idea",
            "target_idea",
            "connection_type",
            "preserved_structure",
            "example",
            "caution_note",
            "recommended_review",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("cross_field_connections.csv"):
            writer.writerow(
                {
                    **row,
                    "recommended_review": "review preserved structure, changed assumptions, target-domain meaning, evidence standard, and possible consequences",
                }
            )


def write_idea_transfer_risk_checklist() -> None:
    with (OUT / "idea_transfer_risk_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["idea_id", "name", "primary_field", "unifying_role", "interpretation_note", "transfer_risk_question"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("mathematical_ideas.csv"):
            writer.writerow(
                {
                    "idea_id": row["idea_id"],
                    "name": row["name"],
                    "primary_field": row["primary_field"],
                    "unifying_role": row["unifying_role"],
                    "interpretation_note": row["interpretation_note"],
                    "transfer_risk_question": "What must remain true for this idea to transfer responsibly across fields?",
                }
            )


def main() -> None:
    write_warning_index()
    write_formal_similarity_checklist()
    write_model_migration_audit()
    write_idea_transfer_risk_checklist()

    print("Responsible generalization audit complete.")
    print(f"  {OUT / 'responsible_generalization_warning_index.csv'}")
    print(f"  {OUT / 'formal_similarity_vs_contextual_sameness_checklist.csv'}")
    print(f"  {OUT / 'model_migration_audit.csv'}")
    print(f"  {OUT / 'idea_transfer_risk_checklist.csv'}")


if __name__ == "__main__":
    main()
