#!/usr/bin/env python3
"""
Possibility interpretation audit for:
"Combinatorics and the Mathematics of Possibility"

This workflow connects counting problems, methods, warnings,
probability assumptions, and generating-function metadata.
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


def write_warning_index() -> None:
    problems = {row["problem_id"]: row for row in load_csv("combinatorial_problems.csv")}
    methods = {row["problem_id"]: row for row in load_csv("counting_methods.csv")}
    warnings = load_csv("possibility_warnings.csv")

    with (OUT / "possibility_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "warning_id",
                "problem_id",
                "problem_name",
                "method_name",
                "warning",
                "mitigation",
                "responsible_interpretation_note",
            ],
        )
        writer.writeheader()

        for row in warnings:
            problem = problems.get(row["problem_id"], {})
            method = methods.get(row["problem_id"], {})
            writer.writerow(
                {
                    "warning_id": row["warning_id"],
                    "problem_id": row["problem_id"],
                    "problem_name": problem.get("name", ""),
                    "method_name": method.get("method_name", ""),
                    "warning": row["warning"],
                    "mitigation": row["mitigation"],
                    "responsible_interpretation_note": "state assumptions, constraints, exclusions, equal-likelihood status, and consequences",
                }
            )


def write_probability_audit() -> None:
    with (OUT / "probability_counting_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "case_id",
                "name",
                "total_outcomes",
                "favorable_outcomes",
                "equally_likely",
                "probability_if_equally_likely",
                "interpretation",
                "validation_note",
            ],
        )
        writer.writeheader()

        for row in load_csv("probability_cases.csv"):
            total = int(row["total_outcomes"])
            favorable = int(row["favorable_outcomes"])
            equally_likely = row["equally_likely"].lower() == "true"
            probability = favorable / total if equally_likely else ""

            writer.writerow(
                {
                    "case_id": row["case_id"],
                    "name": row["name"],
                    "total_outcomes": total,
                    "favorable_outcomes": favorable,
                    "equally_likely": equally_likely,
                    "probability_if_equally_likely": probability,
                    "interpretation": row["interpretation"],
                    "validation_note": "combinatorial count becomes probability only when sample-space assumptions are valid",
                }
            )


def write_generating_function_index() -> None:
    with (OUT / "generating_function_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["gf_id", "name", "series_form", "coefficient_meaning", "interpretation", "audit_note"],
        )
        writer.writeheader()

        for row in load_csv("generating_function_examples.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "coefficient extraction connects algebraic representation to combinatorial counts",
                }
            )


def write_method_validation_index() -> None:
    with (OUT / "counting_method_validation_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "method_id",
                "problem_id",
                "method_name",
                "formula",
                "double_counting_risk",
                "validation_note",
                "professional_audit_question",
            ],
        )
        writer.writeheader()

        for row in load_csv("counting_methods.csv"):
            writer.writerow(
                {
                    **row,
                    "professional_audit_question": "Are the assumptions sufficient to count every valid object exactly once?",
                }
            )


def main() -> None:
    write_warning_index()
    write_probability_audit()
    write_generating_function_index()
    write_method_validation_index()

    print("Possibility interpretation audit complete.")
    print(f"  {OUT / 'possibility_warning_index.csv'}")
    print(f"  {OUT / 'probability_counting_audit.csv'}")
    print(f"  {OUT / 'generating_function_index.csv'}")
    print(f"  {OUT / 'counting_method_validation_index.csv'}")


if __name__ == "__main__":
    main()
