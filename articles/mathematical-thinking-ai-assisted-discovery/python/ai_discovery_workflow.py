#!/usr/bin/env python3
"""
AI-assisted discovery workflow for:
"Mathematical Thinking and AI-Assisted Discovery"

This workflow generates:
- discovery candidate indexes;
- evaluator summaries;
- verification record summaries;
- proof-status summaries;
- human interpretation records;
- Graphviz DOT file for generate-test-prove-interpret workflows.
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


def write_discovery_candidate_index() -> None:
    with (OUT_TABLES / "discovery_candidate_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "candidate_id",
            "title",
            "output_type",
            "generated_by",
            "assumptions",
            "current_status",
            "interpretation_question",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("discovery_candidates.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "What kind of candidate was generated, what evidence supports it, and what verification is still required?",
                }
            )


def write_evaluator_summary() -> None:
    with (OUT_TABLES / "evaluator_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["evaluator_id", "candidate_id", "evaluator_type", "criterion", "limitation", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("evaluator_records.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "evaluator design determines what the AI-assisted workflow can and cannot validate",
                }
            )


def write_verification_summary() -> None:
    with (OUT_TABLES / "verification_record_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "verification_id",
            "candidate_id",
            "verification_method",
            "evidence_standard",
            "result_summary",
            "remaining_question",
            "status_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("verification_records.csv"):
            writer.writerow(
                {
                    **row,
                    "status_note": "AI-generated output becomes mathematical knowledge only through the appropriate evidence standard",
                }
            )


def write_proof_status_summary() -> None:
    candidates = load_csv("discovery_candidates.csv")
    status_counts = Counter(row["current_status"] for row in candidates)
    type_counts = Counter(row["output_type"] for row in candidates)

    with (OUT_TABLES / "candidate_status_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["summary_type", "name", "count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for status, count in sorted(status_counts.items()):
            writer.writerow(
                {
                    "summary_type": "current_status",
                    "name": status,
                    "count": count,
                    "interpretation": "status counts support workflow review, not mathematical authority",
                }
            )

        for output_type, count in sorted(type_counts.items()):
            writer.writerow(
                {
                    "summary_type": "output_type",
                    "name": output_type,
                    "count": count,
                    "interpretation": "output types require different evidence standards",
                }
            )


def write_human_interpretation_summary() -> None:
    with (OUT_TABLES / "human_interpretation_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "interpretation_id",
            "candidate_id",
            "novelty_review",
            "significance_review",
            "proof_status",
            "credit_and_workflow_note",
            "review_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("human_interpretation_records.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "human interpretation reviews novelty, significance, proof status, and credit",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_discovery_graph() -> None:
    with (OUT_FIGURES / "ai_discovery_workflow.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph ai_discovery_workflow {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')
        dot.write('  "Generate" -> "Test" -> "Prove" -> "Interpret";\n')

        for row in load_csv("discovery_candidates.csv"):
            candidate = safe_dot(row["title"])
            output_type = safe_dot(row["output_type"])
            status = safe_dot(row["current_status"])
            dot.write(f'  "{candidate}" -> "{output_type}" [label="output type"];\n')
            dot.write(f'  "{output_type}" -> "{status}" [label="current status"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: AI output is candidate material until tested, proved, and interpreted."];\n')
        dot.write("}\n")


def main() -> None:
    write_discovery_candidate_index()
    write_evaluator_summary()
    write_verification_summary()
    write_proof_status_summary()
    write_human_interpretation_summary()
    write_discovery_graph()

    print("AI-assisted discovery workflow complete.")
    print(f"  {OUT_TABLES / 'discovery_candidate_index.csv'}")
    print(f"  {OUT_TABLES / 'evaluator_summary.csv'}")
    print(f"  {OUT_TABLES / 'verification_record_summary.csv'}")
    print(f"  {OUT_TABLES / 'candidate_status_summary.csv'}")
    print(f"  {OUT_TABLES / 'human_interpretation_summary.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'ai_discovery_workflow.dot'}")


if __name__ == "__main__":
    main()
