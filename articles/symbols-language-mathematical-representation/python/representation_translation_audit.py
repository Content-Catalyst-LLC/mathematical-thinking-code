#!/usr/bin/env python3
"""
Representation translation audit.

This script demonstrates:
- representation metadata;
- graph edge-list to adjacency-matrix translation;
- preservation/omission audit;
- Graphviz DOT output for relational representation.
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


def copy_representation_audit() -> None:
    objects = {}
    with (DATA / "mathematical_objects.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            objects[row["object_id"]] = row

    translations_by_source: dict[str, list[str]] = defaultdict(list)
    with (DATA / "translations.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            translations_by_source[row["source_representation_id"]].append(row["target_representation_id"])

    warnings_by_rep: dict[str, list[str]] = defaultdict(list)
    with (DATA / "notation_warnings.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            warnings_by_rep[row["representation_id"]].append(f"{row['warning']} Mitigation: {row['mitigation']}")

    with (DATA / "representations.csv").open("r", encoding="utf-8") as src, (OUT_TABLES / "representation_audit.csv").open("w", newline="", encoding="utf-8") as dst:
        reader = csv.DictReader(src)
        writer = csv.DictWriter(
            dst,
            fieldnames=[
                "representation_id",
                "object_name",
                "object_type",
                "representation_type",
                "notation_or_format",
                "preserved_structure",
                "omitted_detail",
                "translation_targets",
                "warnings",
            ],
        )
        writer.writeheader()
        for row in reader:
            obj = objects.get(row["object_id"], {})
            writer.writerow(
                {
                    "representation_id": row["representation_id"],
                    "object_name": obj.get("name", ""),
                    "object_type": obj.get("object_type", ""),
                    "representation_type": row["representation_type"],
                    "notation_or_format": row["notation_or_format"],
                    "preserved_structure": row["preserved_structure"],
                    "omitted_detail": row["omitted_detail"],
                    "translation_targets": " ".join(translations_by_source.get(row["representation_id"], [])),
                    "warnings": " | ".join(warnings_by_rep.get(row["representation_id"], [])),
                }
            )


def load_graphs() -> dict[str, list[tuple[str, str]]]:
    grouped: dict[str, list[tuple[str, str]]] = defaultdict(list)
    with (DATA / "graph_edges.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            grouped[row["graph_id"]].append((row["source"], row["target"]))
    return dict(grouped)


def adjacency_matrix(edges: list[tuple[str, str]]) -> tuple[list[str], list[list[int]]]:
    vertices = sorted({v for edge in edges for v in edge})
    index = {vertex: i for i, vertex in enumerate(vertices)}
    matrix = [[0 for _ in vertices] for _ in vertices]

    for source, target in edges:
        i = index[source]
        j = index[target]
        matrix[i][j] = 1
        matrix[j][i] = 1

    return vertices, matrix


def write_graph_translation_outputs() -> None:
    graphs = load_graphs()

    with (OUT_TABLES / "graph_edge_to_matrix_translation.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["graph_id", "vertex_order", "row_label", "matrix_row", "interpretation"],
        )
        writer.writeheader()

        for graph_id, edges in graphs.items():
            vertices, matrix = adjacency_matrix(edges)

            with (OUT_FIGURES / f"{graph_id}.dot").open("w", encoding="utf-8") as dot:
                dot.write(f"graph {graph_id} {{\n")
                dot.write('  graph [rankdir="LR"];\n')
                for source, target in edges:
                    dot.write(f'  "{source}" -- "{target}";\n')
                dot.write("}\n")

            for vertex, row in zip(vertices, matrix):
                writer.writerow(
                    {
                        "graph_id": graph_id,
                        "vertex_order": " ".join(vertices),
                        "row_label": vertex,
                        "matrix_row": " ".join(map(str, row)),
                        "interpretation": "adjacency matrix preserves edge relation after vertex order is fixed",
                    }
                )


def main() -> None:
    copy_representation_audit()
    write_graph_translation_outputs()

    print("Representation translation audit complete.")
    print(f"  {OUT_TABLES / 'representation_audit.csv'}")
    print(f"  {OUT_TABLES / 'graph_edge_to_matrix_translation.csv'}")
    print(f"  Graphviz DOT files: {OUT_FIGURES}")


if __name__ == "__main__":
    main()
