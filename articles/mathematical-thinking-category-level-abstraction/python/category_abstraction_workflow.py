#!/usr/bin/env python3
"""
Category abstraction workflow for:
"Mathematical Thinking and Category-Level Abstraction"

This workflow generates:
- category record indexes;
- functor preservation summaries;
- natural transformation summaries;
- universal property summaries;
- commutative diagram checks;
- Graphviz DOT file for objects-arrows-structure-universality workflows.
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


def write_category_index() -> None:
    with (OUT_TABLES / "category_record_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "category_id",
            "category_name",
            "objects",
            "morphisms",
            "preserved_structure",
            "composition_rule",
            "abstraction_risk",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("category_records.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "What objects and morphisms define this category, and what structure do the morphisms preserve?",
                }
            )


def write_functor_summary() -> None:
    with (OUT_TABLES / "functor_preservation_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "functor_id",
            "functor_name",
            "source_category",
            "target_category",
            "object_mapping",
            "morphism_mapping",
            "preserved_property",
            "forgotten_or_added_structure",
            "review_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("functor_records.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "a functor should preserve identity and composition while documenting what structure is forgotten or added",
                }
            )


def write_natural_transformation_summary() -> None:
    with (OUT_TABLES / "natural_transformation_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "transformation_id",
            "transformation_name",
            "source_functor",
            "target_functor",
            "component_description",
            "naturality_condition",
            "coherence_review",
            "review_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("natural_transformation_records.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "natural transformations require component-wise maps that behave coherently with source morphisms",
                }
            )


def write_universal_property_summary() -> None:
    with (OUT_TABLES / "universal_property_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "property_id",
            "construction_name",
            "diagram_shape",
            "universal_role",
            "uniqueness_condition",
            "example_domain",
            "review_question",
            "interpretation",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("universal_property_records.csv"):
            writer.writerow(
                {
                    **row,
                    "interpretation": "universal properties define constructions by mapping role rather than implementation recipe",
                }
            )


def write_diagram_commutativity_summary() -> None:
    with (OUT_TABLES / "diagram_commutativity_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "diagram_id",
            "diagram_name",
            "diagram_type",
            "path_left",
            "path_right",
            "commutativity_condition",
            "interpretation",
            "review_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("diagram_records.csv"):
            writer.writerow(
                {
                    **row,
                    "review_note": "a categorical diagram should state the equality or universal condition it encodes",
                }
            )


def write_category_counts() -> None:
    categories = load_csv("category_records.csv")
    structure_counts = Counter(row["preserved_structure"] for row in categories)
    morphism_counts = Counter(row["morphisms"] for row in categories)

    with (OUT_TABLES / "category_structure_counts.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["summary_type", "name", "count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for structure, count in sorted(structure_counts.items()):
            writer.writerow(
                {
                    "summary_type": "preserved_structure",
                    "name": structure,
                    "count": count,
                    "interpretation": "preserved structure determines what category-level abstraction is tracking",
                }
            )

        for morphism, count in sorted(morphism_counts.items()):
            writer.writerow(
                {
                    "summary_type": "morphism_type",
                    "name": morphism,
                    "count": count,
                    "interpretation": "chosen morphisms determine the visible structure of the category",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_category_graph() -> None:
    with (OUT_FIGURES / "category_abstraction_workflow.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph category_abstraction_workflow {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')
        dot.write('  "Objects" -> "Arrows" -> "Structure" -> "Universality" -> "Responsibility";\n')

        for row in load_csv("category_records.csv"):
            category = safe_dot(row["category_name"])
            objects = safe_dot(row["objects"])
            morphisms = safe_dot(row["morphisms"])
            dot.write(f'  "{category}" -> "{objects}" [label="objects"];\n')
            dot.write(f'  "{category}" -> "{morphisms}" [label="morphisms"];\n')

        for row in load_csv("functor_records.csv"):
            functor = safe_dot(row["functor_name"])
            source = safe_dot(row["source_category"])
            target = safe_dot(row["target_category"])
            dot.write(f'  "{source}" -> "{functor}" [label="translated by"];\n')
            dot.write(f'  "{functor}" -> "{target}" [label="to"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: category-level abstraction tracks objects, arrows, preserved structure, and universal roles."];\n')
        dot.write("}\n")


def main() -> None:
    write_category_index()
    write_functor_summary()
    write_natural_transformation_summary()
    write_universal_property_summary()
    write_diagram_commutativity_summary()
    write_category_counts()
    write_category_graph()

    print("Category abstraction workflow complete.")
    print(f"  {OUT_TABLES / 'category_record_index.csv'}")
    print(f"  {OUT_TABLES / 'functor_preservation_summary.csv'}")
    print(f"  {OUT_TABLES / 'natural_transformation_summary.csv'}")
    print(f"  {OUT_TABLES / 'universal_property_summary.csv'}")
    print(f"  {OUT_TABLES / 'diagram_commutativity_summary.csv'}")
    print(f"  {OUT_TABLES / 'category_structure_counts.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'category_abstraction_workflow.dot'}")


if __name__ == "__main__":
    main()
