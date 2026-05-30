#!/usr/bin/env python3
"""
Recursive model and grammar audit for:
"Recursion and Recursive Thinking"

This workflow demonstrates:
- grammar-rule indexing;
- recursive model update trajectories;
- warning/mitigation tables;
- stopping-condition and risk documentation.
"""

from __future__ import annotations

import csv
import math
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def write_grammar_index() -> None:
    with (OUT / "recursive_grammar_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["rule_id", "nonterminal", "production", "rule_type", "interpretation", "audit_note"],
        )
        writer.writeheader()

        for row in load_csv("grammar_rules.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "recursive grammar rules generate nested structure from finite symbolic rules",
                }
            )


def write_model_update_trajectories() -> None:
    with (OUT / "recursive_model_update_trajectories.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["model_id", "step", "state_value", "update_rule", "risk_note", "interpretation"],
        )
        writer.writeheader()

        # Numeric models from the metadata.
        decay = 100.0
        feedback = 1.0
        fixed_point = 0.25

        for step in range(0, 16):
            writer.writerow(
                {
                    "model_id": "model_decay",
                    "step": step,
                    "state_value": round(decay, 8),
                    "update_rule": "x_next=0.85*x",
                    "risk_note": "rounding and model-form assumptions",
                    "interpretation": "recursive state update with decreasing trajectory",
                }
            )
            decay = 0.85 * decay

            writer.writerow(
                {
                    "model_id": "model_feedback",
                    "step": step,
                    "state_value": round(feedback, 8),
                    "update_rule": "x_next=1.2*x+0.5",
                    "risk_note": "reinforcing loop can amplify values",
                    "interpretation": "recursive feedback can produce rapid amplification",
                }
            )
            feedback = 1.2 * feedback + 0.5

            writer.writerow(
                {
                    "model_id": "model_iteration",
                    "step": step,
                    "state_value": round(fixed_point, 8),
                    "update_rule": "x_next=cos(x)",
                    "risk_note": "convergence depends on update rule and starting point",
                    "interpretation": "fixed-point iteration as recursive update",
                }
            )
            fixed_point = math.cos(fixed_point)


def write_warning_index() -> None:
    definitions = {row["definition_id"]: row for row in load_csv("recursive_definitions.csv")}
    algorithms = {row["algorithm_id"]: row for row in load_csv("algorithm_cases.csv")}
    models = {row["model_id"]: row for row in load_csv("model_update_cases.csv")}

    with (OUT / "recursion_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
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

        for row in load_csv("recursion_warnings.csv"):
            name = (
                definitions.get(row["structure_id"], {}).get("name")
                or algorithms.get(row["structure_id"], {}).get("name")
                or models.get(row["structure_id"], {}).get("name")
                or row["structure_id"]
            )

            writer.writerow(
                {
                    "warning_id": row["warning_id"],
                    "structure_type": row["structure_type"],
                    "structure_id": row["structure_id"],
                    "structure_name": name,
                    "warning": row["warning"],
                    "mitigation": row["mitigation"],
                    "responsible_interpretation_note": "document base case, recursive rule, stopping condition, invariant, and error propagation risk",
                }
            )


def write_algorithm_index() -> None:
    with (OUT / "recursive_algorithm_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "algorithm_id",
                "name",
                "base_case",
                "recursive_reduction",
                "combination_rule",
                "complexity_note",
                "correctness_note",
                "audit_question",
            ],
        )
        writer.writeheader()

        for row in load_csv("algorithm_cases.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "Does the recursive reduction reach the base case and preserve correctness?",
                }
            )


def main() -> None:
    write_grammar_index()
    write_model_update_trajectories()
    write_warning_index()
    write_algorithm_index()

    print("Recursive model audit complete.")
    print(f"  {OUT / 'recursive_grammar_index.csv'}")
    print(f"  {OUT / 'recursive_model_update_trajectories.csv'}")
    print(f"  {OUT / 'recursion_warning_index.csv'}")
    print(f"  {OUT / 'recursive_algorithm_index.csv'}")


if __name__ == "__main__":
    main()
