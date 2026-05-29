#!/usr/bin/env python3
"""
Mapping validation and interpretation audit for:
"Sets, Relations, and Functions as Modes of Thought"

This workflow connects mathematical structures to warnings about boundaries,
codomains, missing inputs, categories, and multivalued relations.
"""

from __future__ import annotations

import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def write_mapping_warning_index() -> None:
    warnings = load_csv("mapping_warnings.csv")
    functions = {row["function_id"]: row for row in load_csv("functions.csv")}

    with (OUT / "mapping_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "warning_id",
                "structure_type",
                "structure_id",
                "structure_name",
                "warning",
                "mitigation",
                "responsible_interpretation_note",
            ],
        )
        writer.writeheader()

        for row in warnings:
            name = functions.get(row["structure_id"], {}).get("name", row["structure_id"])
            writer.writerow(
                {
                    "warning_id": row["warning_id"],
                    "structure_type": row["structure_type"],
                    "structure_id": row["structure_id"],
                    "structure_name": name,
                    "warning": row["warning"],
                    "mitigation": row["mitigation"],
                    "responsible_interpretation_note": "state boundaries, assumptions, domain, codomain, and consequences",
                }
            )


def write_modeling_structure_index() -> None:
    models = load_csv("modeling_examples.csv")

    with (OUT / "modeling_structure_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "model_id",
                "name",
                "object_set",
                "relation",
                "functions",
                "assumption_note",
                "mathematical_architecture",
            ],
        )
        writer.writeheader()

        for row in models:
            writer.writerow(
                {
                    **row,
                    "mathematical_architecture": "model = objects + relations + mappings + assumptions",
                }
            )


def write_composition_audit() -> None:
    # A tiny deterministic pipeline: x -> 2x -> label.
    def double(x: int) -> int:
        return 2 * x

    def label(y: int) -> str:
        if y <= 2:
            return "low"
        if y <= 6:
            return "medium"
        return "high"

    with (OUT / "function_composition_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["input", "after_double", "after_label", "composition", "interpretation"],
        )
        writer.writeheader()

        for x in [1, 2, 3, 4]:
            y = double(x)
            z = label(y)
            writer.writerow(
                {
                    "input": x,
                    "after_double": y,
                    "after_label": z,
                    "composition": "label(double(x))",
                    "interpretation": "composition chains mappings; category thresholds should be documented",
                }
            )


def main() -> None:
    write_mapping_warning_index()
    write_modeling_structure_index()
    write_composition_audit()

    print("Mapping validation audit complete.")
    print(f"  {OUT / 'mapping_warning_index.csv'}")
    print(f"  {OUT / 'modeling_structure_index.csv'}")
    print(f"  {OUT / 'function_composition_audit.csv'}")


if __name__ == "__main__":
    main()
