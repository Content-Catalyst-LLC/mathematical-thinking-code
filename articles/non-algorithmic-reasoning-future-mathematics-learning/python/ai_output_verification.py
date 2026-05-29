#!/usr/bin/env python3
"""
AI-output verification workflow.

This script demonstrates why tool-assisted mathematics learning requires:
- assumption checks;
- residual checks;
- domain checks;
- evidence/proof-status distinctions;
- explanation and interpretation.
"""

from __future__ import annotations

import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


def quadratic_residual(x: float, a: float = 1.0, b: float = -5.0, c: float = 6.0) -> float:
    return a * x * x + b * x + c


def verify_quadratic_roots(roots: list[float]) -> list[dict[str, object]]:
    return [
        {
            "root_candidate": root,
            "residual": quadratic_residual(root),
            "passes_residual_check": abs(quadratic_residual(root)) < 1e-10,
        }
        for root in roots
    ]


def real_sqrt_domain_check(x: float) -> bool:
    return x >= 0


def write_ai_output_audit() -> None:
    with (DATA / "ai_outputs.csv").open("r", encoding="utf-8") as src, (OUT / "ai_output_verification_audit.csv").open("w", newline="", encoding="utf-8") as dst:
        reader = csv.DictReader(src)
        writer = csv.DictWriter(
            dst,
            fieldnames=[
                "ai_output_id",
                "task_id",
                "claim_or_answer",
                "known_issue",
                "verification_needed",
                "verification_status",
                "responsible_learning_note",
            ],
        )
        writer.writeheader()

        for row in reader:
            issue = row["known_issue"].lower()
            if "mostly correct" in issue:
                status = "requires residual verification"
            elif "finite evidence" in issue:
                status = "must be labeled as evidence not proof"
            elif "domain" in issue:
                status = "requires domain check"
            elif "examples" in issue:
                status = "proof gap"
            else:
                status = "requires expert review"

            writer.writerow(
                {
                    "ai_output_id": row["ai_output_id"],
                    "task_id": row["task_id"],
                    "claim_or_answer": row["claim_or_answer"],
                    "known_issue": row["known_issue"],
                    "verification_needed": row["verification_needed"],
                    "verification_status": status,
                    "responsible_learning_note": "AI output should be checked, interpreted, and justified before acceptance",
                }
            )


def write_numeric_verification_examples() -> None:
    root_checks = verify_quadratic_roots([2.0, 3.0, 4.0])

    with (OUT / "quadratic_root_residual_checks.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["root_candidate", "residual", "passes_residual_check", "interpretation"])
        writer.writeheader()

        for row in root_checks:
            writer.writerow(
                {
                    **row,
                    "interpretation": "procedure output should be verified against original equation",
                }
            )

    with (OUT / "sqrt_domain_checks.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["input_value", "real_sqrt_domain_valid", "interpretation"])
        writer.writeheader()

        for x in [-4, -1, 0, 1, 4]:
            writer.writerow(
                {
                    "input_value": x,
                    "real_sqrt_domain_valid": real_sqrt_domain_check(float(x)),
                    "interpretation": "domain check prevents invalid real-valued formula use",
                }
            )


def main() -> None:
    write_ai_output_audit()
    write_numeric_verification_examples()

    print("AI-output verification workflow complete.")
    print(f"  {OUT / 'ai_output_verification_audit.csv'}")
    print(f"  {OUT / 'quadratic_root_residual_checks.csv'}")
    print(f"  {OUT / 'sqrt_domain_checks.csv'}")


if __name__ == "__main__":
    main()
