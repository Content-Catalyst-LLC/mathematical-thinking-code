#!/usr/bin/env python3
"""
Responsible automation audit for:
"Mathematical Thinking in an Age of Automation"

This workflow generates:
- automation risk indexes;
- human judgment skill indexes;
- proof-assistant layer audits;
- specify-compute-verify-interpret checklist.
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


def write_automation_risk_index() -> None:
    with (OUT / "automation_risk_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["risk_id", "risk_name", "mathematical_problem", "mitigation", "responsible_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("automation_risks.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_note": "automation should be paired with assumption review, verification, interpretation, and consequence awareness",
                }
            )


def write_judgment_skill_index() -> None:
    with (OUT / "human_judgment_skill_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["skill_id", "skill_name", "automation_context", "why_it_matters", "review_question", "education_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("human_judgment_skills.csv"):
            writer.writerow(
                {
                    **row,
                    "education_note": "human mathematical agency depends on developing this skill alongside tool literacy",
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


def write_scvi_checklist() -> None:
    checks = [
        {
            "stage": "Specify",
            "question": "What exactly is the problem, object, domain, and desired output?",
            "failure_mode": "wrong question answered precisely",
            "mitigation": "state variables, units, assumptions, domain, and purpose",
        },
        {
            "stage": "Compute",
            "question": "What procedure, system, model, or tool produced the output?",
            "failure_mode": "opaque automation",
            "mitigation": "record tool type, version when relevant, method, parameters, and data",
        },
        {
            "stage": "Verify",
            "question": "How do we know the result is correct, stable, valid, or adequate?",
            "failure_mode": "unchallenged output",
            "mitigation": "use independent checks, tests, formal verification, sensitivity analysis, or proof review",
        },
        {
            "stage": "Interpret",
            "question": "What does the result mean in context and what should not be inferred?",
            "failure_mode": "formal correctness without meaning",
            "mitigation": "state scope, limitations, uncertainty, and consequences",
        },
    ]

    with (OUT / "specify_compute_verify_interpret_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["stage", "question", "failure_mode", "mitigation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(checks)


def main() -> None:
    write_automation_risk_index()
    write_judgment_skill_index()
    write_proof_assistant_layer_audit()
    write_scvi_checklist()

    print("Responsible automation audit complete.")
    print(f"  {OUT / 'automation_risk_index.csv'}")
    print(f"  {OUT / 'human_judgment_skill_index.csv'}")
    print(f"  {OUT / 'proof_assistant_layer_audit.csv'}")
    print(f"  {OUT / 'specify_compute_verify_interpret_checklist.csv'}")


if __name__ == "__main__":
    main()
