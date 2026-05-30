#!/usr/bin/env python3
"""
Visual proof workflow for:
"Mathematical Thinking and Visual Proof"

This workflow generates:
- visual-proof record indexes;
- diagram-relation summaries;
- proof-without-words classifications;
- role and proof-status summaries;
- Graphviz DOT file for see-abstract-prove-interpret workflows.
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


def write_visual_proof_index() -> None:
    with (OUT_TABLES / "visual_proof_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "record_id",
            "title",
            "domain",
            "visual_role",
            "visible_structure",
            "proof_status",
            "generalization_question",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("visual_proof_records.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "What does the diagram show, what must be generalized, and what proof status does it have?",
                }
            )


def write_diagram_relation_summary() -> None:
    with (OUT_TABLES / "diagram_relation_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["relation_id", "record_id", "visual_feature", "mathematical_relation", "proof_requirement", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("diagram_relations.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "visual features become mathematical evidence only when connected to explicit relations and proof requirements",
                }
            )


def write_proof_without_words_summary() -> None:
    with (OUT_TABLES / "proof_without_words_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["example_id", "title", "visual_device", "mathematical_idea", "missing_words_prompt", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_without_words_examples.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "a proof without words asks the reader to supply the general argument",
                }
            )


def write_role_status_summary() -> None:
    records = load_csv("visual_proof_records.csv")
    role_counts = Counter(row["visual_role"] for row in records)
    status_counts = Counter(row["proof_status"] for row in records)
    domain_counts = Counter(row["domain"] for row in records)

    with (OUT_TABLES / "visual_role_status_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["summary_type", "name", "count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for role, count in sorted(role_counts.items()):
            writer.writerow(
                {
                    "summary_type": "visual_role",
                    "name": role,
                    "count": count,
                    "interpretation": "visual role distinguishes illustration, evidence, heuristic, argument, and formal diagrammatic proof",
                }
            )

        for status, count in sorted(status_counts.items()):
            writer.writerow(
                {
                    "summary_type": "proof_status",
                    "name": status,
                    "count": count,
                    "interpretation": "proof status clarifies what remains to be justified",
                }
            )

        for domain, count in sorted(domain_counts.items()):
            writer.writerow(
                {
                    "summary_type": "domain",
                    "name": domain,
                    "count": count,
                    "interpretation": "domain counts support coverage review, not ranking",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_visual_workflow_graph() -> None:
    with (OUT_FIGURES / "visual_proof_workflow.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph visual_proof_workflow {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')
        dot.write('  "See" -> "Abstract" -> "Prove" -> "Interpret";\n')

        for row in load_csv("visual_proof_records.csv"):
            title = safe_dot(row["title"])
            role = safe_dot(row["visual_role"])
            status = safe_dot(row["proof_status"])
            dot.write(f'  "{title}" -> "{role}" [label="role"];\n')
            dot.write(f'  "{role}" -> "{status}" [label="status"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: visual insight becomes proof through abstraction and justification."];\n')
        dot.write("}\n")


def main() -> None:
    write_visual_proof_index()
    write_diagram_relation_summary()
    write_proof_without_words_summary()
    write_role_status_summary()
    write_visual_workflow_graph()

    print("Visual proof workflow complete.")
    print(f"  {OUT_TABLES / 'visual_proof_index.csv'}")
    print(f"  {OUT_TABLES / 'diagram_relation_summary.csv'}")
    print(f"  {OUT_TABLES / 'proof_without_words_summary.csv'}")
    print(f"  {OUT_TABLES / 'visual_role_status_summary.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'visual_proof_workflow.dot'}")


if __name__ == "__main__":
    main()
