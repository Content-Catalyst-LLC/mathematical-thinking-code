#!/usr/bin/env python3
"""
Foundations and structure workflow for:
"Foundations, Structure, and the Reimagining of Mathematics"

This workflow generates:
- foundation view summaries;
- mathematical structure indexes;
- preservation-map matrices;
- formal-system summaries;
- model-interpretation audits;
- Graphviz DOT files for structure-preserving transformations.
"""

from __future__ import annotations

import csv
from collections import defaultdict
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


def write_foundation_view_summary() -> None:
    with (OUT_TABLES / "foundation_view_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "view_id",
            "name",
            "central_question",
            "mathematical_strength",
            "limitation_note",
            "responsible_interpretation",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("foundation_views.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "What does this foundation make clear, and what does it leave out?",
                }
            )


def write_structure_index() -> None:
    with (OUT_TABLES / "mathematical_structure_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "structure_id",
            "name",
            "objects",
            "relations_or_operations",
            "laws_or_axioms",
            "preserved_by",
            "interpretation_note",
            "structural_audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("mathematical_structures.csv"):
            writer.writerow(
                {
                    **row,
                    "structural_audit_note": "structure should be interpreted through objects, laws, preservation maps, and examples",
                }
            )


def write_preservation_matrix() -> None:
    grouped: dict[str, list[str]] = defaultdict(list)
    for row in load_csv("transformation_maps.csv"):
        grouped[row["map_type"]].append(f"{row['source_structure']} -> {row['target_structure']}")

    with (OUT_TABLES / "preservation_map_matrix.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["map_type", "structure_pairs", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for map_type, pairs in sorted(grouped.items()):
            writer.writerow(
                {
                    "map_type": map_type,
                    "structure_pairs": "; ".join(pairs),
                    "interpretation": "preservation maps reveal what counts as sameness or transformation within a structural view",
                }
            )


def write_formal_system_summary() -> None:
    with (OUT_TABLES / "formal_system_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["system_id", "language", "axioms", "inference_rules", "intended_use", "limitation_note", "audit_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("formal_systems.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "formal systems require separate review of syntax, axioms, proof rules, intended interpretation, and limitations",
                }
            )


def write_model_interpretation_audit() -> None:
    with (OUT_TABLES / "model_interpretation_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "model_id",
            "formal_structure",
            "possible_interpretations",
            "assumption_risk",
            "responsible_question",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("model_interpretations.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "model meaning depends on interpretation, assumptions, domain, data, and consequence",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_transformation_graph() -> None:
    with (OUT_FIGURES / "structure_transformation_graph.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph structure_transformation_graph {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')

        for row in load_csv("transformation_maps.csv"):
            source = safe_dot(row["source_structure"])
            target = safe_dot(row["target_structure"])
            label = safe_dot(row["map_type"] + ": " + row["what_is_preserved"])
            dot.write(f'  "{source}" -> "{target}" [label="{label}"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: maps indicate preservation, not total sameness."];\n')
        dot.write("}\n")


def main() -> None:
    write_foundation_view_summary()
    write_structure_index()
    write_preservation_matrix()
    write_formal_system_summary()
    write_model_interpretation_audit()
    write_transformation_graph()

    print("Foundations and structure workflow complete.")
    print(f"  {OUT_TABLES / 'foundation_view_summary.csv'}")
    print(f"  {OUT_TABLES / 'mathematical_structure_index.csv'}")
    print(f"  {OUT_TABLES / 'preservation_map_matrix.csv'}")
    print(f"  {OUT_TABLES / 'formal_system_summary.csv'}")
    print(f"  {OUT_TABLES / 'model_interpretation_audit.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'structure_transformation_graph.dot'}")


if __name__ == "__main__":
    main()
