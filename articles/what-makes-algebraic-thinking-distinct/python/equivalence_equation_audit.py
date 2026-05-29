#!/usr/bin/env python3
"""
Equivalence and equation audit for:
"What Makes Algebraic Thinking Distinct?"

This workflow demonstrates:
- variable-role indexing;
- transformation-rule risk audits;
- equation residual checks;
- misconception/intervention mappings.
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


def write_variable_role_index() -> None:
    rows = load_csv("variable_roles.csv")

    with (OUT / "variable_role_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["role_id", "symbol", "role_type", "example", "interpretation", "learning_note"],
        )
        writer.writeheader()

        for row in rows:
            writer.writerow(
                {
                    **row,
                    "learning_note": "students should distinguish unknowns, generalized numbers, inputs, parameters, and indices",
                }
            )


def write_transformation_risk_audit() -> None:
    rows = load_csv("transformation_rules.csv")

    with (OUT / "transformation_risk_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "rule_id",
                "name",
                "source_form",
                "target_form",
                "preserved_meaning",
                "risk_note",
                "risk_category",
            ],
        )
        writer.writeheader()

        for row in rows:
            risk = row["risk_note"].lower()
            if "extraneous" in risk:
                category = "can introduce extra solutions"
            elif "lose solutions" in risk:
                category = "can lose solutions"
            elif "domain" in risk:
                category = "domain-sensitive transformation"
            else:
                category = "meaning-preserving when assumptions hold"

            writer.writerow({**row, "risk_category": category})


def residual_linear(x: float) -> float:
    return 3.0 * x + 2.0 - 17.0


def circle_residual(x: float, y: float) -> float:
    return x * x + y * y - 1.0


def write_equation_verification() -> None:
    with (OUT / "equation_verification_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "audit_id",
                "candidate",
                "relation",
                "residual",
                "passes_check",
                "interpretation",
            ],
        )
        writer.writeheader()

        for candidate in [4.0, 5.0, 6.0]:
            residual = residual_linear(candidate)
            writer.writerow(
                {
                    "audit_id": "linear_equation_3x_plus_2_equals_17",
                    "candidate": candidate,
                    "relation": "3x+2=17",
                    "residual": residual,
                    "passes_check": abs(residual) < 1e-10,
                    "interpretation": "candidate solution should be checked in original equation",
                }
            )

        for x, y in [(1.0, 0.0), (0.0, 1.0), (0.5, 0.5), (0.6, 0.8)]:
            residual = circle_residual(x, y)
            writer.writerow(
                {
                    "audit_id": "unit_circle_relation",
                    "candidate": f"({x},{y})",
                    "relation": "x^2+y^2=1",
                    "residual": residual,
                    "passes_check": abs(residual) < 1e-10,
                    "interpretation": "geometric equation defines a relation checked by substitution",
                }
            )


def write_misconception_index() -> None:
    rows = load_csv("algebraic_misconceptions.csv")

    with (OUT / "algebraic_misconception_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "misconception_id",
                "name",
                "diagnostic_signal",
                "intervention",
                "algebraic_dimension",
            ],
        )
        writer.writeheader()

        for row in rows:
            name = row["name"].lower()
            if "equal" in name:
                dimension = "equivalence"
            elif "variable" in name:
                dimension = "variable role"
            elif "cancellation" in name or "extraneous" in name:
                dimension = "transformation validity"
            elif "proof" in name:
                dimension = "generality and proof"
            else:
                dimension = "expression/equation distinction"

            writer.writerow(
                {
                    "misconception_id": row["misconception_id"],
                    "name": row["name"],
                    "diagnostic_signal": row["diagnostic_signal"],
                    "intervention": row["intervention"],
                    "algebraic_dimension": dimension,
                }
            )


def main() -> None:
    write_variable_role_index()
    write_transformation_risk_audit()
    write_equation_verification()
    write_misconception_index()

    print("Equivalence and equation audit complete.")
    print(f"  {OUT / 'variable_role_index.csv'}")
    print(f"  {OUT / 'transformation_risk_audit.csv'}")
    print(f"  {OUT / 'equation_verification_audit.csv'}")
    print(f"  {OUT / 'algebraic_misconception_index.csv'}")


if __name__ == "__main__":
    main()
