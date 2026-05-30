#!/usr/bin/env python3
"""
Historical understanding workflow for:
"The Historical Understanding of Mathematics"

This workflow generates:
- object-medium-method-meaning indexes;
- proof-style catalogs;
- notation history summaries;
- transmission maps;
- Graphviz DOT files for mathematical transmission.
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


def write_practice_index() -> None:
    with (OUT_TABLES / "object_medium_method_meaning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "practice_id",
            "practice_name",
            "object_of_thought",
            "medium",
            "method",
            "meaning",
            "caution",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("historical_practices.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "How do object, medium, method, and meaning shape the mathematical practice being described?",
                }
            )


def write_medium_method_summary() -> None:
    practices = load_csv("historical_practices.csv")
    medium_counts = Counter(row["medium"] for row in practices)
    method_counts = Counter(row["method"] for row in practices)

    with (OUT_TABLES / "medium_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["medium", "practice_count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for medium, count in sorted(medium_counts.items()):
            writer.writerow(
                {
                    "medium": medium,
                    "practice_count": count,
                    "interpretation": "medium shapes what can be written, transmitted, generalized, and trusted",
                }
            )

    with (OUT_TABLES / "method_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["method", "practice_count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for method, count in sorted(method_counts.items()):
            writer.writerow(
                {
                    "method": method,
                    "practice_count": count,
                    "interpretation": "method indicates how mathematical authority is produced in context",
                }
            )


def write_proof_style_catalog() -> None:
    with (OUT_TABLES / "proof_style_catalog.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "proof_style_id",
            "name",
            "historical_context",
            "authority_basis",
            "limitation_or_caution",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_styles.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "proof style should be interpreted in relation to medium, standards, audience, and assumptions",
                }
            )


def write_notation_history_summary() -> None:
    with (OUT_TABLES / "notation_history_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "notation_id",
            "notation_or_medium",
            "mathematical_function",
            "historical_effect",
            "anachronism_warning",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("notation_history.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "distinguish historical expression from modern reconstruction",
                }
            )


def write_transmission_summary() -> None:
    with (OUT_TABLES / "mathematical_transmission_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "transmission_id",
            "source_context",
            "target_context",
            "preserved_content",
            "transformed_content",
            "interpretation_note",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("mathematical_transmissions.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "transmission should be treated as preservation plus translation, reinterpretation, and transformation",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_transmission_graph() -> None:
    with (OUT_FIGURES / "mathematical_transmission_graph.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph mathematical_transmission_graph {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')

        for row in load_csv("mathematical_transmissions.csv"):
            source = safe_dot(row["source_context"])
            target = safe_dot(row["target_context"])
            label = safe_dot("preserves/transforms")
            dot.write(f'  "{source}" -> "{target}" [label="{label}"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: transmission is preservation plus transformation."];\n')
        dot.write("}\n")


def main() -> None:
    write_practice_index()
    write_medium_method_summary()
    write_proof_style_catalog()
    write_notation_history_summary()
    write_transmission_summary()
    write_transmission_graph()

    print("Historical understanding workflow complete.")
    print(f"  {OUT_TABLES / 'object_medium_method_meaning_index.csv'}")
    print(f"  {OUT_TABLES / 'medium_summary.csv'}")
    print(f"  {OUT_TABLES / 'method_summary.csv'}")
    print(f"  {OUT_TABLES / 'proof_style_catalog.csv'}")
    print(f"  {OUT_TABLES / 'notation_history_summary.csv'}")
    print(f"  {OUT_TABLES / 'mathematical_transmission_summary.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'mathematical_transmission_graph.dot'}")


if __name__ == "__main__":
    main()
