#!/usr/bin/env python3
"""
Responsible visual argument audit for:
"Mathematical Thinking and Visual Proof"

This workflow generates:
- visual risk indexes;
- accessibility review summaries;
- see-abstract-prove-interpret checklists;
- domain risk crosswalks.
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


def write_visual_risk_index() -> None:
    with (OUT / "visual_risk_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["risk_id", "risk_name", "problem", "mitigation", "responsible_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("visual_risks.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_note": "visual proof requires generality review, proof discipline, and accessible explanation",
                }
            )


def write_accessibility_review_summary() -> None:
    with (OUT / "accessibility_review_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "review_id",
            "record_id",
            "visual_dependency",
            "alternative_description",
            "accessibility_note",
            "review_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("accessibility_reviews.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "visual mathematical communication should include structural descriptions and nonvisual equivalents",
                }
            )


def write_workflow_checklist() -> None:
    with (OUT / "see_abstract_prove_interpret_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["workflow_id", "stage", "question", "failure_mode", "mitigation", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("visual_workflows.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "visual proof becomes rigorous when seeing moves through abstraction, proof, and interpretation",
                }
            )


def write_domain_review_summary() -> None:
    records = load_csv("visual_proof_records.csv")
    domain_counts = Counter(row["domain"] for row in records)

    with (OUT / "domain_review_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["domain", "record_count", "recommended_review"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for domain, count in sorted(domain_counts.items()):
            if domain == "graph_theory":
                review = "separate abstract graph from drawing layout"
            elif domain == "calculus":
                review = "translate visual motion into limit definitions"
            elif domain == "geometry":
                review = "derive relations from construction rather than appearance"
            elif domain == "algebra":
                review = "identify preserved area or structural equivalence"
            elif domain == "combinatorics":
                review = "state what is being counted and how generality is established"
            else:
                review = "state diagram syntax, semantics, and valid transformations"

            writer.writerow(
                {
                    "domain": domain,
                    "record_count": count,
                    "recommended_review": review,
                }
            )


def main() -> None:
    write_visual_risk_index()
    write_accessibility_review_summary()
    write_workflow_checklist()
    write_domain_review_summary()

    print("Responsible visual argument audit complete.")
    print(f"  {OUT / 'visual_risk_index.csv'}")
    print(f"  {OUT / 'accessibility_review_summary.csv'}")
    print(f"  {OUT / 'see_abstract_prove_interpret_checklist.csv'}")
    print(f"  {OUT / 'domain_review_summary.csv'}")


if __name__ == "__main__":
    main()
