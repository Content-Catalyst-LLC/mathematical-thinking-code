#!/usr/bin/env python3
"""
Responsible quantification audit for:
"Mathematical Thinking and the Ethics of Quantification"

This workflow generates:
- responsible quantification checklists;
- high-stakes metric reviews;
- proxy and benchmark review tables;
- contestability and invalid-use summaries.
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


def write_responsible_checklist() -> None:
    with (OUT / "responsible_quantification_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["check_id", "stage", "question", "failure_mode", "mitigation", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("responsible_quantification_checks.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "responsible quantification should define, measure, contextualize, govern, and review justice impacts",
                }
            )


def write_high_stakes_review() -> None:
    metrics = load_csv("metric_records.csv")

    with (OUT / "high_stakes_metric_review.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["metric_id", "metric_name", "metric_type", "target_concept", "intended_use", "invalid_use_warning", "review_requirement"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in metrics:
            if row["consequence_level"] == "high_stakes":
                writer.writerow(
                    {
                        "metric_id": row["metric_id"],
                        "metric_name": row["metric_name"],
                        "metric_type": row["metric_type"],
                        "target_concept": row["target_concept"],
                        "intended_use": row["intended_use"],
                        "invalid_use_warning": row["invalid_use_warning"],
                        "review_requirement": "requires strong validity evidence, subgroup review, uncertainty reporting, documentation, contestability, and periodic audit",
                    }
                )


def write_proxy_benchmark_review() -> None:
    metrics = load_csv("metric_records.csv")

    with (OUT / "proxy_benchmark_review.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["metric_id", "metric_name", "metric_type", "target_concept", "proxy_or_method", "review_question"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in metrics:
            if row["metric_type"] in {"proxy", "indicator", "benchmark", "score", "risk_score"}:
                writer.writerow(
                    {
                        "metric_id": row["metric_id"],
                        "metric_name": row["metric_name"],
                        "metric_type": row["metric_type"],
                        "target_concept": row["target_concept"],
                        "proxy_or_method": row["proxy_or_method"],
                        "review_question": "How strong is the relationship between this proxy or method and the target concept?",
                    }
                )


def write_contestability_summary() -> None:
    governance = load_csv("governance_checks.csv")

    with (OUT / "contestability_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["metric_id", "documentation_available", "contestability_mechanism", "audit_frequency", "invalid_use_warning", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in governance:
            writer.writerow(
                {
                    "metric_id": row["metric_id"],
                    "documentation_available": row["documentation_available"],
                    "contestability_mechanism": row["contestability_mechanism"],
                    "audit_frequency": row["audit_frequency"],
                    "invalid_use_warning": row["invalid_use_warning"],
                    "review_note": "contestability turns quantified authority into accountable governance",
                }
            )


def main() -> None:
    write_responsible_checklist()
    write_high_stakes_review()
    write_proxy_benchmark_review()
    write_contestability_summary()

    print("Responsible quantification audit complete.")
    print(f"  {OUT / 'responsible_quantification_checklist.csv'}")
    print(f"  {OUT / 'high_stakes_metric_review.csv'}")
    print(f"  {OUT / 'proxy_benchmark_review.csv'}")
    print(f"  {OUT / 'contestability_summary.csv'}")


if __name__ == "__main__":
    main()
