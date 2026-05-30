#!/usr/bin/env python3
"""
Quantification ethics workflow for:
"Mathematical Thinking and the Ethics of Quantification"

This workflow generates:
- metric record indexes;
- risk and validity summaries;
- governance summaries;
- Goodhart, aggregation, ranking, uncertainty, and justice summaries;
- Graphviz DOT file for define-measure-contextualize-govern workflows.
"""

from __future__ import annotations

import csv
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def write_metric_index() -> None:
    with (OUT_TABLES / "metric_record_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "metric_id",
            "metric_name",
            "metric_type",
            "target_concept",
            "proxy_or_method",
            "consequence_level",
            "intended_use",
            "invalid_use_warning",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("metric_records.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "What does this metric claim to represent, and what should it not be used for?",
                }
            )


def write_risk_validity_governance() -> None:
    with (OUT_TABLES / "metric_risk_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["risk_id", "metric_id", "risk_name", "problem", "mitigation", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for row in load_csv("metric_risks.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "metric risks require validity review, incentive review, uncertainty review, and governance controls",
                }
            )

    with (OUT_TABLES / "validity_review_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "review_id",
            "metric_id",
            "construct_validity_note",
            "uncertainty_note",
            "subgroup_review_note",
            "context_note",
            "review_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for row in load_csv("validity_reviews.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "validity review should connect target concept, proxy, uncertainty, subgroup effects, and context",
                }
            )

    with (OUT_TABLES / "governance_check_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "check_id",
            "metric_id",
            "documentation_available",
            "contestability_mechanism",
            "audit_frequency",
            "invalid_use_warning",
            "review_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for row in load_csv("governance_checks.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "accountable metrics need documentation, contestability, audit cadence, and invalid-use warnings",
                }
            )


def write_specialized_reviews() -> None:
    review_specs = [
        ("goodhart_records.csv", "goodhart_risk_summary.csv", ["goodhart_id", "metric_id", "target_goal", "optimization_pressure", "distortion_mechanism", "countermeasure"]),
        ("aggregation_reviews.csv", "aggregation_review_summary.csv", ["aggregation_id", "metric_id", "aggregation_method", "what_it_shows", "what_it_may_hide", "disaggregation_needed"]),
        ("ranking_reviews.csv", "ranking_review_summary.csv", ["ranking_id", "metric_id", "ranking_basis", "instability_source", "context_loss", "responsible_reporting"]),
        ("uncertainty_reviews.csv", "uncertainty_review_summary.csv", ["uncertainty_id", "metric_id", "uncertainty_source", "description", "communication_method"]),
        ("justice_reviews.csv", "justice_review_summary.csv", ["justice_id", "metric_id", "recognition_question", "distribution_question", "voice_question", "harm_question"]),
    ]

    for input_name, output_name, fieldnames in review_specs:
        with (OUT_TABLES / output_name).open("w", newline="", encoding="utf-8") as handle:
            extended = fieldnames + ["review_note"]
            writer = csv.DictWriter(handle, fieldnames=extended)
            writer.writeheader()
            for row in load_csv(input_name):
                writer.writerow(
                    {
                        **row,
                        "review_note": "specialized quantification review documents what the number may distort, hide, or govern",
                    }
                )


def write_metric_counts() -> None:
    metrics = load_csv("metric_records.csv")
    type_counts = Counter(row["metric_type"] for row in metrics)
    consequence_counts = Counter(row["consequence_level"] for row in metrics)

    with (OUT_TABLES / "metric_type_consequence_counts.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["summary_type", "name", "count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for metric_type, count in sorted(type_counts.items()):
            writer.writerow(
                {
                    "summary_type": "metric_type",
                    "name": metric_type,
                    "count": count,
                    "interpretation": "metric type clarifies whether a number is a measure, proxy, score, ranking, risk score, indicator, or benchmark",
                }
            )

        for consequence, count in sorted(consequence_counts.items()):
            writer.writerow(
                {
                    "summary_type": "consequence_level",
                    "name": consequence,
                    "count": count,
                    "interpretation": "consequence level determines the required strength of validity, governance, and contestability",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_quantification_graph() -> None:
    with (OUT_FIGURES / "quantification_ethics_workflow.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph quantification_ethics_workflow {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')
        dot.write('  "Define" -> "Measure" -> "Contextualize" -> "Govern" -> "Justice";\n')

        for row in load_csv("metric_records.csv"):
            metric = safe_dot(row["metric_name"])
            concept = safe_dot(row["target_concept"])
            metric_type = safe_dot(row["metric_type"])
            dot.write(f'  "{metric}" -> "{concept}" [label="claims to represent"];\n')
            dot.write(f'  "{metric}" -> "{metric_type}" [label="type"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: responsible quantification defines, measures, contextualizes, governs, and reviews justice."];\n')
        dot.write("}\n")


def main() -> None:
    write_metric_index()
    write_risk_validity_governance()
    write_specialized_reviews()
    write_metric_counts()
    write_quantification_graph()

    print("Quantification ethics workflow complete.")
    print(f"  {OUT_TABLES / 'metric_record_index.csv'}")
    print(f"  {OUT_TABLES / 'metric_risk_summary.csv'}")
    print(f"  {OUT_TABLES / 'validity_review_summary.csv'}")
    print(f"  {OUT_TABLES / 'governance_check_summary.csv'}")
    print(f"  {OUT_TABLES / 'goodhart_risk_summary.csv'}")
    print(f"  {OUT_TABLES / 'aggregation_review_summary.csv'}")
    print(f"  {OUT_TABLES / 'ranking_review_summary.csv'}")
    print(f"  {OUT_TABLES / 'uncertainty_review_summary.csv'}")
    print(f"  {OUT_TABLES / 'justice_review_summary.csv'}")
    print(f"  {OUT_TABLES / 'metric_type_consequence_counts.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'quantification_ethics_workflow.dot'}")


if __name__ == "__main__":
    main()
