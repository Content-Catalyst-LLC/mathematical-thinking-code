#!/usr/bin/env python3
"""
Responsible AI-assisted discovery audit for:
"Mathematical Thinking and AI-Assisted Discovery"

This workflow generates:
- discovery risk indexes;
- discovery workflow audits;
- proof-status taxonomy tables;
- generate-test-prove-interpret checklists.
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


def write_discovery_risk_index() -> None:
    with (OUT / "discovery_risk_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["risk_id", "risk_name", "mathematical_problem", "mitigation", "responsible_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("discovery_risks.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_note": "AI-assisted discovery requires verification, documentation, and human interpretation",
                }
            )


def write_workflow_audit() -> None:
    with (OUT / "generate_test_prove_interpret_workflow_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "workflow_id",
            "stage",
            "ai_role",
            "evaluator_role",
            "human_role",
            "risk",
            "mitigation",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("discovery_workflows.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "generation, testing, proof, and interpretation should remain distinct stages",
                }
            )


def write_proof_status_taxonomy() -> None:
    with (OUT / "proof_status_taxonomy.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["status_id", "status_name", "meaning", "promotion_requirement", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_status_taxonomy.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "candidate status should be stated explicitly before any mathematical claim is promoted",
                }
            )


def write_candidate_risk_crosswalk() -> None:
    candidates = load_csv("discovery_candidates.csv")
    risks = load_csv("discovery_risks.csv")

    status_counts = Counter(row["current_status"] for row in candidates)

    with (OUT / "candidate_status_review.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["current_status", "candidate_count", "recommended_review"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for status, count in sorted(status_counts.items()):
            if status == "untested":
                review = "begin definition checks, example tests, and proof review"
            elif status == "tested_on_examples":
                review = "search counterexamples and attempt proof"
            elif status == "machine_check_required":
                review = "run proof assistant and audit formal statement"
            else:
                review = "review evidence standard and remaining questions"

            writer.writerow(
                {
                    "current_status": status,
                    "candidate_count": count,
                    "recommended_review": review,
                }
            )

    with (OUT / "discovery_risk_names.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["risk_name", "mitigation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for row in risks:
            writer.writerow({"risk_name": row["risk_name"], "mitigation": row["mitigation"]})


def main() -> None:
    write_discovery_risk_index()
    write_workflow_audit()
    write_proof_status_taxonomy()
    write_candidate_risk_crosswalk()

    print("Responsible AI-assisted discovery audit complete.")
    print(f"  {OUT / 'discovery_risk_index.csv'}")
    print(f"  {OUT / 'generate_test_prove_interpret_workflow_audit.csv'}")
    print(f"  {OUT / 'proof_status_taxonomy.csv'}")
    print(f"  {OUT / 'candidate_status_review.csv'}")
    print(f"  {OUT / 'discovery_risk_names.csv'}")


if __name__ == "__main__":
    main()
