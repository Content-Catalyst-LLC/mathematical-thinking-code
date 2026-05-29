#!/usr/bin/env python3
"""
Geometric reasoning workflow for:
"Geometry and the Visual Mind in Mathematics"

This workflow demonstrates:
- points, distances, triangle areas;
- coordinate residual checks;
- unit-circle membership checks;
- geometry as computable but interpreted structure.
"""

from __future__ import annotations

import csv
from dataclasses import dataclass
from math import sqrt
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


@dataclass(frozen=True)
class Point:
    point_id: str
    x: float
    y: float
    role: str


def distance(a: Point, b: Point) -> float:
    return sqrt((b.x - a.x) ** 2 + (b.y - a.y) ** 2)


def triangle_area(a: Point, b: Point, c: Point) -> float:
    return abs(a.x * (b.y - c.y) + b.x * (c.y - a.y) + c.x * (a.y - b.y)) / 2.0


def orientation(a: Point, b: Point, c: Point) -> float:
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)


def unit_circle_residual(p: Point) -> float:
    return p.x * p.x + p.y * p.y - 1.0


def load_points() -> dict[str, Point]:
    points: dict[str, Point] = {}
    with (DATA / "points.csv").open("r", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            points[row["point_id"]] = Point(
                row["point_id"],
                float(row["x"]),
                float(row["y"]),
                row["role"],
            )
    return points


def write_triangle_audit(points: dict[str, Point]) -> None:
    a, b, c = points["A"], points["B"], points["C"]
    pairs = [("AB", a, b), ("BC", b, c), ("CA", c, a)]

    with (OUT / "triangle_distance_area_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["measurement_id", "value", "interpretation"],
        )
        writer.writeheader()

        for label, p, q in pairs:
            writer.writerow(
                {
                    "measurement_id": f"side_{label}",
                    "value": distance(p, q),
                    "interpretation": "distance computed from coordinate representation",
                }
            )

        writer.writerow(
            {
                "measurement_id": "triangle_area_ABC",
                "value": triangle_area(a, b, c),
                "interpretation": "area computed from coordinate determinant formula",
            }
        )

        writer.writerow(
            {
                "measurement_id": "orientation_ABC",
                "value": orientation(a, b, c),
                "interpretation": "signed orientation encodes left/right turn and twice signed area",
            }
        )


def write_circle_audit(points: dict[str, Point]) -> None:
    with (OUT / "unit_circle_membership_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["point_id", "x", "y", "residual_x2_plus_y2_minus_1", "on_unit_circle", "interpretation"],
        )
        writer.writeheader()

        for point_id in ["F", "G"]:
            p = points[point_id]
            residual = unit_circle_residual(p)
            writer.writerow(
                {
                    "point_id": p.point_id,
                    "x": p.x,
                    "y": p.y,
                    "residual_x2_plus_y2_minus_1": residual,
                    "on_unit_circle": abs(residual) < 1e-10,
                    "interpretation": "coordinate equation checks geometric membership",
                }
            )


def main() -> None:
    points = load_points()
    write_triangle_audit(points)
    write_circle_audit(points)

    print("Geometric reasoning workflow complete.")
    print(f"  {OUT / 'triangle_distance_area_audit.csv'}")
    print(f"  {OUT / 'unit_circle_membership_audit.csv'}")


if __name__ == "__main__":
    main()
