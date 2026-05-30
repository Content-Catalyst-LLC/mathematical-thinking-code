#!/usr/bin/env python3
"""
Unity workflow for:
"Historical Development and the Unity of Mathematical Ideas"

This workflow generates:
- historical layer summaries;
- mathematical idea indexes;
- cross-field connection matrices;
- transformation/invariance catalogs;
- proof/algorithm/model distinction tables;
- Graphviz DOT files for idea networks.
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


def write_historical_layer_summary() -> None:
    ideas = load_csv("mathematical_ideas.csv")
    counts = Counter(row["historical_layer"] for row in ideas)

    with (OUT_TABLES / "historical_layer_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "layer_id",
            "name",
            "historical_period",
            "dominant_unifying_idea",
            "representation_forms",
            "later_connection",
            "idea_count",
            "interpretation_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("historical_layers.csv"):
            writer.writerow(
                {
                    "layer_id": row["layer_id"],
                    "name": row["name"],
                    "historical_period": row["historical_period"],
                    "dominant_unifying_idea": row["dominant_unifying_idea"],
                    "representation_forms": row["representation_forms"],
                    "later_connection": row["later_connection"],
                    "idea_count": counts.get(row["name"], 0),
                    "interpretation_note": row["interpretation_note"],
                }
            )


def write_mathematical_idea_index() -> None:
    with (OUT_TABLES / "mathematical_idea_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "idea_id",
            "name",
            "primary_field",
            "historical_layer",
            "unifying_role",
            "representation",
            "transformation",
            "invariant_or_preserved_structure",
            "interpretation_note",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("mathematical_ideas.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "How does this idea move across fields without erasing contextual difference?",
                }
            )


def write_cross_field_connection_matrix() -> None:
    grouped: dict[str, list[str]] = defaultdict(list)
    for row in load_csv("cross_field_connections.csv"):
        grouped[row["connection_type"]].append(f"{row['source_idea']} -> {row['target_idea']}")

    with (OUT_TABLES / "cross_field_connection_matrix.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["connection_type", "connections", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for connection_type, connections in sorted(grouped.items()):
            writer.writerow(
                {
                    "connection_type": connection_type,
                    "connections": "; ".join(connections),
                    "interpretation": "cross-field connection indicates conceptual migration, not contextual sameness",
                }
            )


def write_transformation_invariance_catalog() -> None:
    with (OUT_TABLES / "transformation_invariance_catalog.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["invariant_id", "field", "transformation", "invariant", "meaning", "example", "audit_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("transformation_invariants.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "state what is transformed, what is preserved, and what interpretation depends on context",
                }
            )


def write_proof_algorithm_model_table() -> None:
    with (OUT_TABLES / "proof_algorithm_model_distinctions.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "connection_id",
            "mathematical_form",
            "core_question",
            "evidence_standard",
            "risk_if_confused",
            "responsible_distinction",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_algorithm_model_connections.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "proof, algorithm, model, simulation, and verification should not be collapsed into one evidence standard",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_idea_network_graph() -> None:
    with (OUT_FIGURES / "mathematical_idea_network.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph mathematical_idea_network {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')

        for row in load_csv("cross_field_connections.csv"):
            source = safe_dot(row["source_idea"])
            target = safe_dot(row["target_idea"])
            label = safe_dot(row["connection_type"])
            dot.write(f'  "{source}" -> "{target}" [label="{label}"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: idea migration does not imply contextual sameness."];\n')
        dot.write("}\n")


def main() -> None:
    write_historical_layer_summary()
    write_mathematical_idea_index()
    write_cross_field_connection_matrix()
    write_transformation_invariance_catalog()
    write_proof_algorithm_model_table()
    write_idea_network_graph()

    print("Mathematical unity workflow complete.")
    print(f"  {OUT_TABLES / 'historical_layer_summary.csv'}")
    print(f"  {OUT_TABLES / 'mathematical_idea_index.csv'}")
    print(f"  {OUT_TABLES / 'cross_field_connection_matrix.csv'}")
    print(f"  {OUT_TABLES / 'transformation_invariance_catalog.csv'}")
    print(f"  {OUT_TABLES / 'proof_algorithm_model_distinctions.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'mathematical_idea_network.dot'}")


if __name__ == "__main__":
    main()
