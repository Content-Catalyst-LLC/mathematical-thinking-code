#!/usr/bin/env python3
"""
Algorithm, Boolean, and responsible-interpretation audit for:
"Discrete Mathematics and the Logic of Structure"

This workflow demonstrates:
- Boolean truth-table generation;
- algorithm metadata indexing;
- proof-pattern indexing;
- discrete-structure warning tables.
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


def bool_text(value: bool) -> str:
    return "true" if value else "false"


def write_boolean_truth_table() -> None:
    with (OUT / "boolean_truth_table_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "P",
                "Q",
                "not_P",
                "P_and_Q",
                "P_or_Q",
                "P_implies_Q",
                "P_xor_Q",
                "interpretation",
            ],
        )
        writer.writeheader()

        for P in [False, True]:
            for Q in [False, True]:
                writer.writerow(
                    {
                        "P": bool_text(P),
                        "Q": bool_text(Q),
                        "not_P": bool_text(not P),
                        "P_and_Q": bool_text(P and Q),
                        "P_or_Q": bool_text(P or Q),
                        "P_implies_Q": bool_text((not P) or Q),
                        "P_xor_Q": bool_text(P != Q),
                        "interpretation": "Boolean structure formalizes discrete truth conditions",
                    }
                )


def write_algorithm_index() -> None:
    rows = load_csv("algorithms.csv")
    with (OUT / "algorithm_invariant_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "algorithm_id",
                "name",
                "input_structure",
                "output_structure",
                "invariant_note",
                "complexity_note",
                "audit_question",
            ],
        )
        writer.writeheader()

        for row in rows:
            writer.writerow(
                {
                    **row,
                    "audit_question": "Does the procedure preserve its invariant and terminate under stated input assumptions?",
                }
            )


def write_proof_pattern_index() -> None:
    rows = load_csv("proof_patterns.csv")
    with (OUT / "proof_pattern_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "proof_id",
                "name",
                "discrete_use",
                "required_structure",
                "risk_note",
                "validation_note",
            ],
        )
        writer.writeheader()

        for row in rows:
            writer.writerow(
                {
                    **row,
                    "validation_note": "proof status should be distinguished from finite evidence or visual plausibility",
                }
            )


def write_structure_warning_index() -> None:
    rows = load_csv("structure_warnings.csv")
    with (OUT / "discrete_structure_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "warning_id",
                "structure_type",
                "structure_id",
                "warning",
                "mitigation",
                "responsible_interpretation_note",
            ],
        )
        writer.writeheader()

        for row in rows:
            writer.writerow(
                {
                    **row,
                    "responsible_interpretation_note": "discrete representations preserve selected structure while omitting other context",
                }
            )


def main() -> None:
    write_boolean_truth_table()
    write_algorithm_index()
    write_proof_pattern_index()
    write_structure_warning_index()

    print("Algorithm and Boolean audit complete.")
    print(f"  {OUT / 'boolean_truth_table_audit.csv'}")
    print(f"  {OUT / 'algorithm_invariant_index.csv'}")
    print(f"  {OUT / 'proof_pattern_index.csv'}")
    print(f"  {OUT / 'discrete_structure_warning_index.csv'}")


if __name__ == "__main__":
    main()
