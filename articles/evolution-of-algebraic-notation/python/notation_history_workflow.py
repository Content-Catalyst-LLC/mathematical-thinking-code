#!/usr/bin/env python3
"""
Notation-history workflow for:
"The Evolution of Algebraic Notation"

This workflow demonstrates:
- notation-style summaries;
- milestone timelines;
- symbol-context audit tables;
- transformation-rule indexes;
- expression-dependency DOT export.
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


def write_style_summary() -> None:
    milestones = load_csv("notation_milestones.csv")
    styles = {row["style_id"]: row for row in load_csv("notation_styles.csv")}
    counts = Counter(row["style_id"] for row in milestones)

    with (OUT_TABLES / "notation_style_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["style_id", "style_name", "milestone_count", "dominant_medium", "mathematical_effect", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for style_id, count in sorted(counts.items()):
            style = styles.get(style_id, {})
            writer.writerow(
                {
                    "style_id": style_id,
                    "style_name": style.get("name", style_id),
                    "milestone_count": count,
                    "dominant_medium": style.get("dominant_medium", ""),
                    "mathematical_effect": style.get("mathematical_effect", ""),
                    "interpretation": "style count reflects synthetic teaching metadata, not historical prevalence",
                }
            )


def write_milestone_timeline() -> None:
    styles = {row["style_id"]: row for row in load_csv("notation_styles.csv")}

    with (OUT_TABLES / "notation_milestone_timeline.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "milestone_id",
            "period",
            "tradition_or_figure",
            "style_name",
            "contribution",
            "interpretation_note",
            "historical_caution",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("notation_milestones.csv"):
            style = styles.get(row["style_id"], {})
            writer.writerow(
                {
                    "milestone_id": row["milestone_id"],
                    "period": row["period"],
                    "tradition_or_figure": row["tradition_or_figure"],
                    "style_name": style.get("name", row["style_id"]),
                    "contribution": row["contribution"],
                    "interpretation_note": row["interpretation_note"],
                    "historical_caution": "modern symbolic reconstruction should not be confused with original notation",
                }
            )


def write_symbol_context_audit() -> None:
    with (OUT_TABLES / "symbol_context_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "symbol_id",
            "symbol_text",
            "meaning_context",
            "mathematical_role",
            "ambiguity_note",
            "responsible_pedagogy_note",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("symbol_records.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "Has the symbol's context, role, ambiguity, and valid interpretation been stated?",
                }
            )


def write_transformation_index() -> None:
    with (OUT_TABLES / "symbolic_transformation_rule_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "rule_id",
            "rule_name",
            "input_pattern",
            "output_pattern",
            "mathematical_condition",
            "interpretation_note",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("transformation_rules.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "symbolic transformations require explicit laws, domains, and side conditions",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_expression_graph() -> None:
    expressions = load_csv("expression_examples.csv")

    with (OUT_FIGURES / "expression_history_graph.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph expression_history_graph {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')
        previous = None
        for row in expressions:
            node = safe_dot(row["expression_id"])
            label = safe_dot(row["expression_text"] + "\\n" + row["historical_layer"])
            dot.write(f'  "{node}" [label="{label}"];\n')
            if previous is not None:
                dot.write(f'  "{previous}" -> "{node}" [label="notation evolves"];\n')
            previous = node
        dot.write('  note [shape=note, label="Synthetic teaching graph: notation history is not a single linear path."];\n')
        dot.write("}\n")


def write_style_milestone_matrix() -> None:
    milestones = load_csv("notation_milestones.csv")
    grouped: dict[str, list[str]] = defaultdict(list)
    for row in milestones:
        grouped[row["style_id"]].append(row["tradition_or_figure"])

    styles = {row["style_id"]: row["name"] for row in load_csv("notation_styles.csv")}

    with (OUT_TABLES / "style_milestone_matrix.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["style_id", "style_name", "examples", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for style_id, examples in sorted(grouped.items()):
            writer.writerow(
                {
                    "style_id": style_id,
                    "style_name": styles.get(style_id, style_id),
                    "examples": "; ".join(examples),
                    "interpretation": "styles are analytic categories, not civilizational rankings",
                }
            )


def main() -> None:
    write_style_summary()
    write_milestone_timeline()
    write_symbol_context_audit()
    write_transformation_index()
    write_expression_graph()
    write_style_milestone_matrix()

    print("Notation history workflow complete.")
    print(f"  {OUT_TABLES / 'notation_style_summary.csv'}")
    print(f"  {OUT_TABLES / 'notation_milestone_timeline.csv'}")
    print(f"  {OUT_TABLES / 'symbol_context_audit.csv'}")
    print(f"  {OUT_TABLES / 'symbolic_transformation_rule_index.csv'}")
    print(f"  {OUT_TABLES / 'style_milestone_matrix.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'expression_history_graph.dot'}")


if __name__ == "__main__":
    main()
