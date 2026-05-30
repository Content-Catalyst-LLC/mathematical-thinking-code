#!/usr/bin/env python3
"""
Symbolic-expression audit for:
"The Evolution of Algebraic Notation"

This workflow demonstrates:
- expression tree construction;
- polynomial expansion/factoring checks;
- symbolic transformation audits;
- notation-access warning indexes.
"""

from __future__ import annotations

import csv
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


@dataclass(frozen=True)
class Expr:
    op: str
    value: str | None = None
    left: "Expr | None" = None
    right: "Expr | None" = None

    def pretty(self) -> str:
        if self.op in {"var", "const"}:
            return self.value or ""
        if self.op == "pow":
            return f"({self.left.pretty()})^{self.right.pretty()}"
        return f"({self.left.pretty()} {self.op} {self.right.pretty()})"

    def node_count(self) -> int:
        total = 1
        if self.left is not None:
            total += self.left.node_count()
        if self.right is not None:
            total += self.right.node_count()
        return total

    def depth(self) -> int:
        if self.left is None and self.right is None:
            return 1
        left_depth = self.left.depth() if self.left is not None else 0
        right_depth = self.right.depth() if self.right is not None else 0
        return 1 + max(left_depth, right_depth)


def var(name: str) -> Expr:
    return Expr("var", value=name)


def const(value: int) -> Expr:
    return Expr("const", value=str(value))


def add(left: Expr, right: Expr) -> Expr:
    return Expr("+", left=left, right=right)


def mul(left: Expr, right: Expr) -> Expr:
    return Expr("*", left=left, right=right)


def pow_expr(left: Expr, n: int) -> Expr:
    return Expr("pow", left=left, right=const(n))


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def write_expression_tree_audit() -> None:
    examples = [
        ("expr_linear", add(mul(var("a"), var("x")), var("b"))),
        ("expr_quadratic_left", add(add(mul(var("a"), pow_expr(var("x"), 2)), mul(var("b"), var("x"))), var("c"))),
        ("expr_perfect_square_expanded", add(add(pow_expr(var("x"), 2), mul(const(2), var("x"))), const(1))),
        ("expr_perfect_square_factored", pow_expr(add(var("x"), const(1)), 2)),
        ("expr_associative_law_left", mul(mul(var("a"), var("b")), var("c"))),
        ("expr_associative_law_right", mul(var("a"), mul(var("b"), var("c")))),
    ]

    with (OUT / "expression_tree_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["expression_id", "pretty_expression", "node_count", "tree_depth", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for expression_id, expression in examples:
            writer.writerow(
                {
                    "expression_id": expression_id,
                    "pretty_expression": expression.pretty(),
                    "node_count": expression.node_count(),
                    "tree_depth": expression.depth(),
                    "interpretation": "symbolic notation can be represented as an expression tree",
                }
            )


def write_polynomial_identity_audit() -> None:
    # Audit x^2 + 2x + 1 == (x+1)^2 for a small integer domain.
    with (OUT / "polynomial_identity_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["x", "expanded_value", "factored_value", "identity_holds", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for x in range(-10, 11):
            expanded = x * x + 2 * x + 1
            factored = (x + 1) ** 2
            writer.writerow(
                {
                    "x": x,
                    "expanded_value": expanded,
                    "factored_value": factored,
                    "identity_holds": expanded == factored,
                    "interpretation": "finite check illustrates but does not replace symbolic proof of identity",
                }
            )


def write_warning_index() -> None:
    with (OUT / "notation_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["warning_id", "topic", "warning", "mitigation", "responsible_interpretation_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("notation_warnings.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_interpretation_note": "notation should be taught with meaning, historical context, assumptions, and access in view",
                }
            )


def write_expression_example_index() -> None:
    with (OUT / "expression_example_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "expression_id",
            "expression_text",
            "historical_layer",
            "structure_type",
            "tree_description",
            "interpretation_note",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("expression_examples.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "expression meaning depends on notation layer, domain, and transformation rules",
                }
            )


def main() -> None:
    write_expression_tree_audit()
    write_polynomial_identity_audit()
    write_warning_index()
    write_expression_example_index()

    print("Symbolic expression audit complete.")
    print(f"  {OUT / 'expression_tree_audit.csv'}")
    print(f"  {OUT / 'polynomial_identity_audit.csv'}")
    print(f"  {OUT / 'notation_warning_index.csv'}")
    print(f"  {OUT / 'expression_example_index.csv'}")


if __name__ == "__main__":
    main()
