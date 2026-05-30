#!/usr/bin/env python3
"""
Automation workflow for:
"Mathematical Thinking in an Age of Automation"

This workflow generates:
- automation task indexes;
- tool literacy summaries;
- verification record tables;
- evidence-standard summaries;
- trust-boundary maps;
- Graphviz DOT file for automation verification workflow.
"""

from __future__ import annotations

import csv
from collections import Counter, defaultdict
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


def write_automation_task_index() -> None:
    with (OUT_TABLES / "automation_task_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "task_id",
            "task_name",
            "tool_type",
            "mathematical_object",
            "output_type",
            "assumptions",
            "verification_method",
            "interpretation_note",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("automation_tasks.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "What was automated, what assumptions were used, and how should the output be verified?",
                }
            )


def write_tool_literacy_summary() -> None:
    with (OUT_TABLES / "tool_literacy_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["tool_id", "tool_name", "tool_category", "strength", "human_review", "failure_mode", "literacy_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("automation_tools.csv"):
            writer.writerow(
                {
                    **row,
                    "literacy_note": "tool literacy means knowing the strength, trust boundary, and failure mode of the system",
                }
            )


def write_verification_summary() -> None:
    with (OUT_TABLES / "verification_record_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "verification_id",
            "task_id",
            "verification_method",
            "evidence_standard",
            "trust_boundary",
            "interpretation_note",
            "review_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("verification_records.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "verification standards differ for arithmetic, symbolic, numerical, AI-generated, and formal outputs",
                }
            )


def write_evidence_standard_summary() -> None:
    records = load_csv("verification_records.csv")
    grouped: dict[str, list[str]] = defaultdict(list)
    for row in records:
        grouped[row["evidence_standard"]].append(row["task_id"])

    with (OUT_TABLES / "evidence_standard_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["evidence_standard", "task_ids", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for standard, tasks in sorted(grouped.items()):
            writer.writerow(
                {
                    "evidence_standard": standard,
                    "task_ids": "; ".join(tasks),
                    "interpretation": "automated outputs should be judged by the evidence standard appropriate to their output type",
                }
            )


def write_trust_boundary_summary() -> None:
    trust_counts = Counter(row["trust_boundary"] for row in load_csv("verification_records.csv"))

    with (OUT_TABLES / "trust_boundary_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["trust_boundary", "record_count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for boundary, count in sorted(trust_counts.items()):
            writer.writerow(
                {
                    "trust_boundary": boundary,
                    "record_count": count,
                    "interpretation": "trust is relocated into inputs, assumptions, models, systems, libraries, kernels, and interpretations",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_automation_graph() -> None:
    with (OUT_FIGURES / "automation_verification_workflow.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph automation_verification_workflow {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')
        dot.write('  "Specify" -> "Compute" -> "Verify" -> "Interpret";\n')

        for row in load_csv("automation_tasks.csv"):
            task = safe_dot(row["task_name"])
            tool = safe_dot(row["tool_type"])
            verify = safe_dot(row["verification_method"])
            dot.write(f'  "{task}" -> "{tool}" [label="uses"];\n')
            dot.write(f'  "{tool}" -> "{verify}" [label="requires"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: automated output requires verification and interpretation."];\n')
        dot.write("}\n")


def main() -> None:
    write_automation_task_index()
    write_tool_literacy_summary()
    write_verification_summary()
    write_evidence_standard_summary()
    write_trust_boundary_summary()
    write_automation_graph()

    print("Automation workflow complete.")
    print(f"  {OUT_TABLES / 'automation_task_index.csv'}")
    print(f"  {OUT_TABLES / 'tool_literacy_summary.csv'}")
    print(f"  {OUT_TABLES / 'verification_record_summary.csv'}")
    print(f"  {OUT_TABLES / 'evidence_standard_summary.csv'}")
    print(f"  {OUT_TABLES / 'trust_boundary_summary.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'automation_verification_workflow.dot'}")


if __name__ == "__main__":
    main()
