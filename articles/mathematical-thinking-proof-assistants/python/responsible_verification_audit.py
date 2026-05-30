#!/usr/bin/env python3
"""
Responsible verification audit for:
"Mathematical Thinking and Proof Assistants"

This workflow generates:
- proof-assistant skill indexes;
- AI-to-proof-assistant workflow audits;
- responsible verification checklists;
- theorem risk summaries.
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


def write_skill_index() -> None:
    with (OUT / "proof_assistant_skill_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["skill_id", "skill_name", "why_it_matters", "review_question", "education_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_assistant_skills.csv"):
            writer.writerow(
                {
                    **row,
                    "education_note": "proof-assistant literacy combines formal syntax, mathematical meaning, and verification habits",
                }
            )


def write_ai_workflow_audit() -> None:
    with (OUT / "ai_to_proof_assistant_workflow_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "workflow_id",
            "stage",
            "ai_role",
            "proof_assistant_role",
            "human_role",
            "risk",
            "mitigation",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("ai_formalization_workflows.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "AI should be treated as proposal generation, proof assistant checking as formal verification, and human review as interpretation",
                }
            )


def write_responsible_verification_checklist() -> None:
    with (OUT / "responsible_verification_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["check_id", "stage", "question", "failure_mode", "mitigation", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("responsible_verification_checks.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "proof assistant work should move through define, state, prove, check, and interpret",
                }
            )


def write_theorem_risk_summary() -> None:
    risks = Counter(row["risk"] for row in load_csv("theorem_statement_audits.csv"))

    with (OUT / "theorem_statement_risk_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["risk", "count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for risk, count in sorted(risks.items()):
            writer.writerow(
                {
                    "risk": risk,
                    "count": count,
                    "interpretation": "risk summary highlights where formal statement review is needed",
                }
            )


def main() -> None:
    write_skill_index()
    write_ai_workflow_audit()
    write_responsible_verification_checklist()
    write_theorem_risk_summary()

    print("Responsible verification audit complete.")
    print(f"  {OUT / 'proof_assistant_skill_index.csv'}")
    print(f"  {OUT / 'ai_to_proof_assistant_workflow_audit.csv'}")
    print(f"  {OUT / 'responsible_verification_checklist.csv'}")
    print(f"  {OUT / 'theorem_statement_risk_summary.csv'}")


if __name__ == "__main__":
    main()
