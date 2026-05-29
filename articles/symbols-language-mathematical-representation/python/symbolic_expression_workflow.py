#!/usr/bin/env python3
"""
Symbolic expression workflow for:
"Symbols, Language, and Mathematical Representation"

This script demonstrates mathematical expressions as structured objects:
- expression trees;
- rendering and evaluation;
- symbolic differentiation for a small expression language;
- representation metadata outputs.
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
        if expr.value.is_integer():
            return str(int(expr.value))
        return str(expr.value)
    if isinstance(expr, Add):
        return f"({render(expr.left)} + {render(expr.right)})"
    if isinstance(expr, Mul):
        return f"({render(expr.left)} * {render(expr.right)})"
    if isinstance(expr, Pow):
        return f"({render(expr.base)}^{expr.exponent})"
    raise TypeError(f"Unknown expression: {expr}")


def evaluate(expr: Expr, environment: dict[str, float]) -> float:
    if isinstance(expr, Var):
        return environment[expr.name]
    if isinstance(expr, Const):
        return expr.value
    if isinstance(expr, Add):
        return evaluate(expr.left, environment) + evaluate(expr.right, environment)
    if isinstance(expr, Mul):
        return evaluate(expr.left, environment) * evaluate(expr.right, environment)
    if isinstance(expr, Pow):
        return evaluate(expr.base, environment) ** expr.exponent
    raise TypeError(f"Unknown expression: {expr}")


def derivative(expr: Expr, variable: str) -> Expr:
    if isinstance(expr, Var):
        return Const(1.0 if expr.name == variable else 0.0)
    if isinstance(expr, Const):
        return Const(0.0)
    if isinstance(expr, Add):
        return Add(derivative(expr.left, variable), derivative(expr.right, variable))
    if isinstance(expr, Mul):
        return Add(
            Mul(derivative(expr.left, variable), expr.right),
            Mul(expr.left, derivative(expr.right, variable)),
        )
    if isinstance(expr, Pow):
        if expr.exponent == 0:
            return Const(0.0)
        return Mul(Const(float(expr.exponent)), Mul(Pow(expr.base, expr.exponent - 1), derivative(expr.base, variable)))
    raise TypeError(f"Unknown expression: {expr}")


def tree_size(expr: Expr) -> int:
    if isinstance(expr, (Var, Const)):
        return 1
    if isinstance(expr, (Add, Mul)):
        return 1 + tree_size(expr.left) + tree_size(expr.right)
    if isinstance(expr, Pow):
        return 1 + tree_size(expr.base)
    raise TypeError(f"Unknown expression: {expr}")


def main() -> None:
    x = Var("x")
    y = Var("y")

    examples: list[tuple[str, Expr, dict[str, float]]] = [
        ("linear", Add(x, Const(2.0)), {"x": 3.0}),
        ("product", Mul(Add(x, Const(2.0)), y), {"x": 3.0, "y": 4.0}),
        ("quadratic", Add(Pow(x, 2), Add(Mul(Const(2.0), x), Const(1.0))), {"x": 3.0}),
    ]

    with (OUT / "symbolic_expression_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "expression_id",
                "rendered_expression",
                "tree_size",
                "evaluation_environment",
                "evaluated_value",
                "derivative_with_respect_to_x",
                "derivative_value_at_environment",
                "interpretation",
            ],
        )
        writer.writeheader()

        for expression_id, expr, environment in examples:
            d_expr = derivative(expr, "x")
            writer.writerow(
                {
                    "expression_id": expression_id,
                    "rendered_expression": render(expr),
                    "tree_size": tree_size(expr),
                    "evaluation_environment": str(environment),
                    "evaluated_value": evaluate(expr, environment),
                    "derivative_with_respect_to_x": render(d_expr),
                    "derivative_value_at_environment": evaluate(d_expr, environment),
                    "interpretation": "expression tree preserves symbolic structure for rendering, evaluation, and transformation",
                }
            )

    print("Symbolic expression workflow complete.")
    print(f"  {OUT / 'symbolic_expression_audit.csv'}")


if __name__ == "__main__":
    main()
