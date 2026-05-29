#!/usr/bin/env python3
"""
Transformation and diagram audit for:
"Geometry and the Visual Mind in Mathematics"

This workflow demonstrates:
- coordinate transformations;
- invariance checks;
- representation warnings;
- Graphviz DOT visual metadata without treating diagrams as proof.
"""

from __future__ import annotations

import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


def rotate_90(x: float, y: float) -> tuple[float, float]:
    return -y, x


def reflect_x(x: float, y: float) -> tuple[float, float]:
    return x, -y


def scale_2(x: float, y: float) -> tuple[float, float]:
    return 2 * x, 2 * y


def norm2(x: float, y: float) -> float:
    return x * x + y * y


def write_transformation_coordinate_audit() -> None:
    with (DATA / "points.csv").open("r", encoding="utf-8") as src, (OUT_TABLES / "coordinate_transformation_audit.csv").open("w", newline="", encoding="utf-8") as dst:
        reader = csv.DictReader(src)
        writer = csv.DictWriter(
            dst,
            fieldnames=[
                "point_id",
                "x",
                "y",
                "transformation",
                "x_transformed",
                "y_transformed",
                "squared_distance_before",
                "squared_distance_after",
                "distance_preserved",
                "interpretation",
            ],
        )
        writer.writeheader()

        for row in reader:
            x = float(row["x"])
            y = float(row["y"])
            for name, transform in [
                ("rotate_90", rotate_90),
                ("reflect_x", reflect_x),
                ("scale_2", scale_2),
            ]:
                xt, yt = transform(x, y)
                before = norm2(x, y)
                after = norm2(xt, yt)
                writer.writerow(
                    {
                        "point_id": row["point_id"],
                        "x": x,
                        "y": y,
                        "transformation": name,
                        "x_transformed": xt,
                        "y_transformed": yt,
                        "squared_distance_before": before,
                        "squared_distance_after": after,
                        "distance_preserved": abs(before - after) < 1e-10,
                        "interpretation": "isometries preserve distance; scaling changes distance unless scale is unit",
                    }
                )


def write_representation_warning_audit() -> None:
    representations = {}
    with (DATA / "representations.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            representations[row["representation_id"]] = row

    with (DATA / "diagram_warnings.csv").open("r", encoding="utf-8") as src, (OUT_TABLES / "diagram_warning_audit.csv").open("w", newline="", encoding="utf-8") as dst:
        reader = csv.DictReader(src)
        writer = csv.DictWriter(
            dst,
            fieldnames=[
                "warning_id",
                "representation_id",
                "representation_type",
                "preserved_structure",
                "omitted_detail",
                "warning",
                "mitigation",
            ],
        )
        writer.writeheader()

        for row in reader:
            rep = representations.get(row["representation_id"], {})
            writer.writerow(
                {
                    "warning_id": row["warning_id"],
                    "representation_id": row["representation_id"],
                    "representation_type": rep.get("representation_type", ""),
                    "preserved_structure": rep.get("preserved_structure", ""),
                    "omitted_detail": rep.get("omitted_detail", ""),
                    "warning": row["warning"],
                    "mitigation": row["mitigation"],
                }
            )


def write_graph_layout_dot() -> None:
    dot_path = OUT_FIGURES / "cycle4_layout.dot"
    with dot_path.open("w", encoding="utf-8") as dot:
        dot.write("graph cycle4_layout {\n")
        dot.write('  graph [rankdir="LR"];\n')
        for source, target in [("a", "b"), ("b", "c"), ("c", "d"), ("d", "a")]:
            dot.write(f'  "{source}" -- "{target}";\n')
        dot.write('  note [shape=box, label="Layout is visual; connectivity is mathematical structure"];\n')
        dot.write("}\n")


def main() -> None:
    write_transformation_coordinate_audit()
    write_representation_warning_audit()
    write_graph_layout_dot()

    print("Transformation and diagram audit complete.")
    print(f"  {OUT_TABLES / 'coordinate_transformation_audit.csv'}")
    print(f"  {OUT_TABLES / 'diagram_warning_audit.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'cycle4_layout.dot'}")


if __name__ == "__main__":
    main()
