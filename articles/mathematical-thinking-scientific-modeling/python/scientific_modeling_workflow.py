#!/usr/bin/env python3
"""
Scientific modeling workflow for:
"Mathematical Thinking and Scientific Modeling"

This workflow generates:
- scientific model indexes;
- assumption summaries;
- variable and parameter metadata;
- calibration and validation summaries;
- uncertainty and sensitivity summaries;
- Graphviz DOT file for represent-relate-test-revise workflows.
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


def write_model_index() -> None:
    with (OUT_TABLES / "scientific_model_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "model_id",
            "model_name",
            "model_type",
            "purpose",
            "target_system",
            "intended_use",
            "scope_limit",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("scientific_model_records.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "What does this model represent, what is it for, and where does its validity end?",
                }
            )


def write_assumption_summary() -> None:
    with (OUT_TABLES / "model_assumption_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "assumption_id",
            "model_id",
            "assumption_text",
            "assumption_type",
            "failure_consequence",
            "review_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("model_assumptions.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "assumptions should be explicit, testable where possible, and connected to consequences if they fail",
                }
            )


def write_variable_parameter_summary() -> None:
    with (OUT_TABLES / "variable_parameter_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["record_id", "model_id", "name", "role", "unit", "uncertainty_note", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("variable_parameter_records.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "variables and parameters should include role, unit, measurement basis, and uncertainty",
                }
            )


def write_calibration_validation_summary() -> None:
    with (OUT_TABLES / "calibration_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "calibration_id",
            "model_id",
            "calibration_method",
            "data_used",
            "risk",
            "review_question",
            "interpretation",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for row in load_csv("calibration_records.csv"):
            writer.writerow(
                {
                    **row,
                    "interpretation": "calibration aligns model output with data but does not by itself prove model validity",
                }
            )

    with (OUT_TABLES / "validation_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "validation_id",
            "model_id",
            "validation_type",
            "evidence_used",
            "limitation",
            "credibility_note",
            "interpretation",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for row in load_csv("validation_records.csv"):
            writer.writerow(
                {
                    **row,
                    "interpretation": "validation is purpose-specific and should state limitations clearly",
                }
            )


def write_uncertainty_sensitivity_summary() -> None:
    with (OUT_TABLES / "uncertainty_source_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["uncertainty_id", "model_id", "source_type", "description", "mitigation", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for row in load_csv("uncertainty_sources.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "uncertainty source should be identified, communicated, and propagated where relevant",
                }
            )

    with (OUT_TABLES / "sensitivity_analysis_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["sensitivity_id", "model_id", "factor_tested", "method", "finding", "decision_relevance", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for row in load_csv("sensitivity_records.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "sensitivity analysis shows which conclusions depend on uncertain factors",
                }
            )


def write_model_counts() -> None:
    records = load_csv("scientific_model_records.csv")
    type_counts = Counter(row["model_type"] for row in records)
    purpose_counts = Counter(row["purpose"] for row in records)

    with (OUT_TABLES / "model_type_purpose_counts.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["summary_type", "name", "count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for model_type, count in sorted(type_counts.items()):
            writer.writerow(
                {
                    "summary_type": "model_type",
                    "name": model_type,
                    "count": count,
                    "interpretation": "model type clarifies what kind of scientific knowledge is being represented",
                }
            )

        for purpose, count in sorted(purpose_counts.items()):
            writer.writerow(
                {
                    "summary_type": "purpose",
                    "name": purpose,
                    "count": count,
                    "interpretation": "model purpose determines appropriate validation and interpretation standards",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_modeling_graph() -> None:
    with (OUT_FIGURES / "scientific_modeling_workflow.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph scientific_modeling_workflow {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')
        dot.write('  "Represent" -> "Relate" -> "Test" -> "Revise" -> "Responsibility";\n')

        for row in load_csv("scientific_model_records.csv"):
            model = safe_dot(row["model_name"])
            purpose = safe_dot(row["purpose"])
            model_type = safe_dot(row["model_type"])
            dot.write(f'  "{model}" -> "{model_type}" [label="type"];\n')
            dot.write(f'  "{model}" -> "{purpose}" [label="purpose"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: scientific modeling represents, relates, tests, revises, and communicates limits."];\n')
        dot.write("}\n")


def main() -> None:
    write_model_index()
    write_assumption_summary()
    write_variable_parameter_summary()
    write_calibration_validation_summary()
    write_uncertainty_sensitivity_summary()
    write_model_counts()
    write_modeling_graph()

    print("Scientific modeling workflow complete.")
    print(f"  {OUT_TABLES / 'scientific_model_index.csv'}")
    print(f"  {OUT_TABLES / 'model_assumption_summary.csv'}")
    print(f"  {OUT_TABLES / 'variable_parameter_summary.csv'}")
    print(f"  {OUT_TABLES / 'calibration_summary.csv'}")
    print(f"  {OUT_TABLES / 'validation_summary.csv'}")
    print(f"  {OUT_TABLES / 'uncertainty_source_summary.csv'}")
    print(f"  {OUT_TABLES / 'sensitivity_analysis_summary.csv'}")
    print(f"  {OUT_TABLES / 'model_type_purpose_counts.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'scientific_modeling_workflow.dot'}")


if __name__ == "__main__":
    main()
