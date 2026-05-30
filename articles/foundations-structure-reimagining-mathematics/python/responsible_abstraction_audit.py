#!/usr/bin/env python3
"""
Responsible abstraction audit for:
"Foundations, Structure, and the Reimagining of Mathematics"

This workflow generates:
- abstraction warning indexes;
- proof-assistant layer audits;
- formal correctness vs ethical adequacy checklist;
- model-risk checklist.
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


def write_abstraction_warning_index() -> None:
    with (OUT / "abstraction_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["warning_id", "topic", "warning", "mitigation", "responsible_abstraction_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("abstraction_warnings.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_abstraction_note": "formal power should be paired with assumptions, interpretation, access, and consequence review",
                }
            )


def write_proof_assistant_layer_audit() -> None:
    with (OUT / "proof_assistant_layer_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["layer_id", "layer_name", "human_role", "machine_role", "risk_or_limitation", "audit_question"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_assistant_layers.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "What remains a human responsibility at this layer of formalization?",
                }
            )


def write_formal_correctness_checklist() -> None:
    checks = [
        {
            "check_id": "check_01",
            "question": "Is the formal statement actually the intended informal claim?",
            "risk": "formal statement mismatch",
            "mitigation": "review definitions, theorem statement, and informal meaning together",
        },
        {
            "check_id": "check_02",
            "question": "Are all axioms and imported library assumptions acceptable?",
            "risk": "hidden foundation assumptions",
            "mitigation": "document axioms, imports, and trust boundary",
        },
        {
            "check_id": "check_03",
            "question": "Does the proof establish only internal correctness or also model adequacy?",
            "risk": "formal overconfidence",
            "mitigation": "distinguish proof, specification, and real-world interpretation",
        },
        {
            "check_id": "check_04",
            "question": "Is an optimization objective ethically and institutionally acceptable?",
            "risk": "optimization harm",
            "mitigation": "review objectives before solving",
        },
        {
            "check_id": "check_05",
            "question": "Who is excluded by the abstraction, notation, or model?",
            "risk": "access barrier",
            "mitigation": "include examples, history, explanation, and affected-community review when relevant",
        },
    ]

    with (OUT / "formal_correctness_vs_adequacy_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["check_id", "question", "risk", "mitigation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(checks)


def write_model_risk_checklist() -> None:
    with (OUT / "model_risk_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["model_id", "formal_structure", "assumption_risk", "responsible_question", "recommended_review"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("model_interpretations.csv"):
            writer.writerow(
                {
                    "model_id": row["model_id"],
                    "formal_structure": row["formal_structure"],
                    "assumption_risk": row["assumption_risk"],
                    "responsible_question": row["responsible_question"],
                    "recommended_review": "review interpretation, domain, data, assumptions, stakeholder consequences, and validation evidence",
                }
            )


def main() -> None:
    write_abstraction_warning_index()
    write_proof_assistant_layer_audit()
    write_formal_correctness_checklist()
    write_model_risk_checklist()

    print("Responsible abstraction audit complete.")
    print(f"  {OUT / 'abstraction_warning_index.csv'}")
    print(f"  {OUT / 'proof_assistant_layer_audit.csv'}")
    print(f"  {OUT / 'formal_correctness_vs_adequacy_checklist.csv'}")
    print(f"  {OUT / 'model_risk_checklist.csv'}")


if __name__ == "__main__":
    main()
