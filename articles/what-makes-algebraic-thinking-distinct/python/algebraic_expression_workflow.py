#!/usr/bin/env python3
"""
Algebraic expression workflow for:
"What Makes Algebraic Thinking Distinct?"

This workflow demonstrates:
- expressions as trees;
- rendering and evaluation;
- sampled equivalence checking;
- expression-form audits.
"""

from __future__ import annotations

import csv
from dataclasses import dataclass
from pathlib import Path
from typing import Union

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


@dataclass(frozen=True)
class Var:
    name: str


@dataclass(frozen=True)
class Const:
    value: float


@dataclass(frozen=True)
class Add:
    left: "Expr"
    right: "Expr"


@dataclass(frozen=True)
class Mul:
    left: "Expr"
    right: "Expr"


@dataclass(frozen=True)
class Pow:
    base: "Expr"
    exponent: int


Expr = Union[Var, Const, Add, Mul, Pow]


def render(expr: Expr) -> str:
    if isinstance(expr, Var):
        return expr.name
    if isinstance(expr, Const):
        return str(int(expr.value)) if expr.value.is_integer() else str(expr.value)
    if isinstance(expr, Add):
        return f"({render(expr.left)} + {render(expr.right)})"
    if isinstance(expr, Mul):
        return f"({render(expr.left)} * {render(expr.right)})"
    if isinstance(expr, Pow):
        return f"({render(expr.base)}^{expr.exponent})"
    raise TypeError(f"Unknown expression: {expr}")


def evaluate(expr: Expr, env: dict[str, float]) -> float:
    if isinstance(expr, Var):
        return env[expr.name]
    if isinstance(expr, Const):
        return expr.value
    if isinstance(expr, Add):
        return evaluate(expr.left, env) + evaluate(expr.right, env)
    if isinstance(expr, Mul):
        return evaluate(expr.left, env) * evaluate(expr.right, env)
    if isinstance(expr, Pow):
        return evaluate(expr.base, env) ** expr.exponent
    raise TypeError(f"Unknown expression: {expr}")


def tree_size(expr: Expr) -> int:
    if isinstance(expr, (Var, Const)):
        return 1
    if isinstance(expr, (Add, Mul)):
        return 1 + tree_size(expr.left) + tree_size(expr.right)
    if isinstance(expr, Pow):
        return 1 + tree_size(expr.base)
    raise TypeError(f"Unknown expression: {expr}")


def write_expression_tree_audit() -> None:
    x = Var("x")
    examples: list[tuple[str, str, Expr]] = [
        ("expr_linear_factored", "factored", Mul(Const(2.0), Add(x, Const(3.0)))),
        ("expr_linear_expanded", "expanded", Add(Mul(Const(2.0), x), Const(6.0))),
        ("expr_quadratic_factored", "factored", Mul(Add(x, Const(2.0)), Add(x, Const(3.0)))),
        ("expr_quadratic_expanded", "expanded", Add(Add(Pow(x, 2), Mul(Const(5.0), x)), Const(6.0))),
    ]

    with (OUT / "algebraic_expression_tree_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "expression_id",
                "form_type",
                "rendered_expression",
                "tree_size",
                "value_at_x_4",
                "structure_note",
            ],
        )
        writer.writeheader()

        for expression_id, form_type, expr in examples:
            writer.writerow(
                {
                    "expression_id": expression_id,
                    "form_type": form_type,
                    "rendered_expression": render(expr),
                    "tree_size": tree_size(expr),
                    "value_at_x_4": evaluate(expr, {"x": 4.0}),
                    "structure_note": "expression tree makes algebraic grouping and operations explicit",
                }
            )


def write_equivalence_sample_audit() -> None:
    x = Var("x")
    factored = Mul(Const(2.0), Add(x, Const(3.0)))
    expanded = Add(Mul(Const(2.0), x), Const(6.0))
    quadratic_factored = Mul(Add(x, Const(2.0)), Add(x, Const(3.0)))
    quadratic_expanded = Add(Add(Pow(x, 2), Mul(Const(5.0), x)), Const(6.0))

    comparisons = [
        ("linear_expand_factor", factored, expanded),
        ("quadratic_expand_factor", quadratic_factored, quadratic_expanded),
    ]

    with (OUT / "sampled_equivalence_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "comparison_id",
                "x",
                "left_form",
                "right_form",
                "left_value",
                "right_value",
                "agrees_on_sample",
                "interpretation",
            ],
        )
        writer.writeheader()

        for comparison_id, left, right in comparisons:
            for value in range(-10, 11):
                left_value = evaluate(left, {"x": float(value)})
                right_value = evaluate(right, {"x": float(value)})
                writer.writerow(
                    {
                        "comparison_id": comparison_id,
                        "x": value,
                        "left_form": render(left),
                        "right_form": render(right),
                        "left_value": left_value,
                        "right_value": right_value,
                        "agrees_on_sample": abs(left_value - right_value) < 1e-10,
                        "interpretation": "sampled agreement supports equivalence but symbolic proof establishes identity",
                    }
                )


def main() -> None:
    write_expression_tree_audit()
    write_equivalence_sample_audit()

    print("Algebraic expression workflow complete.")
    print(f"  {OUT / 'algebraic_expression_tree_audit.csv'}")
    print(f"  {OUT / 'sampled_equivalence_audit.csv'}")


if __name__ == "__main__":
    main()
