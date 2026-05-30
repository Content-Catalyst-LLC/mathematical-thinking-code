#!/usr/bin/env python3
"""
Proof-assistant workflow for:
"Mathematical Thinking and Proof Assistants"

This workflow generates:
- proof-assistant system summaries;
- formalization project indexes;
- theorem-statement audit tables;
- proof-layer summaries;
- trust-boundary maps;
- Graphviz DOT file for define-state-prove-check-interpret workflow.
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


def write_system_summary() -> None:
    with (OUT_TABLES / "proof_assistant_system_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "system_id",
            "system_name",
            "foundation_or_logic",
            "typical_strength",
            "common_use",
            "trust_note",
            "review_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_assistant_systems.csv"):
            writer.writerow(
                {
                    **row,
                    "review_question": "What formal foundation, library culture, and trust boundary does this system imply?",
                }
            )


def write_formalization_project_index() -> None:
    with (OUT_TABLES / "formalization_project_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "project_id",
            "project_name",
            "proof_assistant",
            "foundation",
            "mathematical_domain",
            "purpose",
            "status_note",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("formalization_projects.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "How do the formal foundation, proof assistant, and project purpose shape the formalization?",
                }
            )


def write_theorem_statement_audit() -> None:
    with (OUT_TABLES / "theorem_statement_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "theorem_id",
            "project_id",
            "informal_statement",
            "formal_statement_summary",
            "hypotheses",
            "intended_meaning_review",
            "risk",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("theorem_statement_audits.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "machine checking verifies the formal statement, so intended meaning must be reviewed separately",
                }
            )


def write_proof_layer_summary() -> None:
    with (OUT_TABLES / "proof_layer_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["layer_id", "layer_name", "human_role", "machine_role", "risk_or_limitation", "review_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_layers.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "machine checking is one layer in a broader define-state-prove-check-interpret workflow",
                }
            )


def write_trust_boundary_summary() -> None:
    records = load_csv("proof_trust_boundaries.csv")
    grouped: dict[str, list[str]] = defaultdict(list)
    for row in records:
        grouped[row["trusted_component"]].append(row["theorem_id"])

    with (OUT_TABLES / "trust_boundary_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["trusted_component", "theorem_ids", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for component, theorem_ids in sorted(grouped.items()):
            writer.writerow(
                {
                    "trusted_component": component,
                    "theorem_ids": "; ".join(theorem_ids),
                    "interpretation": "proof assistants relocate trust into formal statements, kernels, axioms, libraries, and human meaning review",
                }
            )


def write_project_counts() -> None:
    projects = load_csv("formalization_projects.csv")
    system_counts = Counter(row["proof_assistant"] for row in projects)
    domain_counts = Counter(row["mathematical_domain"] for row in projects)

    with (OUT_TABLES / "formalization_project_counts.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["category", "name", "count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for system, count in sorted(system_counts.items()):
            writer.writerow(
                {
                    "category": "proof_assistant",
                    "name": system,
                    "count": count,
                    "interpretation": "synthetic counts support project coverage review, not system ranking",
                }
            )

        for domain, count in sorted(domain_counts.items()):
            writer.writerow(
                {
                    "category": "mathematical_domain",
                    "name": domain,
                    "count": count,
                    "interpretation": "synthetic counts support domain coverage review, not domain importance ranking",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_proof_workflow_graph() -> None:
    with (OUT_FIGURES / "proof_assistant_workflow.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph proof_assistant_workflow {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')
        dot.write('  "Define" -> "State" -> "Prove" -> "Check" -> "Interpret";\n')

        for row in load_csv("proof_layers.csv"):
            layer = safe_dot(row["layer_name"])
            human = safe_dot(row["human_role"])
            machine = safe_dot(row["machine_role"])
            dot.write(f'  "{layer}" -> "{human}" [label="human role"];\n')
            dot.write(f'  "{layer}" -> "{machine}" [label="machine role"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: machine checking is central but not the whole of mathematical meaning."];\n')
        dot.write("}\n")


def main() -> None:
    write_system_summary()
    write_formalization_project_index()
    write_theorem_statement_audit()
    write_proof_layer_summary()
    write_trust_boundary_summary()
    write_project_counts()
    write_proof_workflow_graph()

    print("Proof-assistant workflow complete.")
    print(f"  {OUT_TABLES / 'proof_assistant_system_summary.csv'}")
    print(f"  {OUT_TABLES / 'formalization_project_index.csv'}")
    print(f"  {OUT_TABLES / 'theorem_statement_audit.csv'}")
    print(f"  {OUT_TABLES / 'proof_layer_summary.csv'}")
    print(f"  {OUT_TABLES / 'trust_boundary_summary.csv'}")
    print(f"  {OUT_TABLES / 'formalization_project_counts.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'proof_assistant_workflow.dot'}")


if __name__ == "__main__":
    main()
