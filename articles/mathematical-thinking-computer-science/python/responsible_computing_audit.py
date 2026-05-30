#!/usr/bin/env python3
"""
Responsible computing audit for:
"Mathematical Thinking for Computer Science"

This workflow demonstrates:
- proof-obligation indexing;
- representation warning tables;
- type-structure audit;
- probability assumption audit;
- linear-algebra representation notes.
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


def write_proof_obligation_index() -> None:
    algorithms = {row["algorithm_id"]: row for row in load_csv("algorithm_specifications.csv")}

    with (OUT / "proof_obligation_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "proof_id",
                "algorithm_id",
                "algorithm_name",
                "proof_type",
                "claim",
                "method",
                "risk_note",
                "audit_question",
            ],
        )
        writer.writeheader()

        for row in load_csv("proof_obligations.csv"):
            algorithm = algorithms.get(row["algorithm_id"], {})
            writer.writerow(
                {
                    **row,
                    "algorithm_name": algorithm.get("name", row["algorithm_id"]),
                    "audit_question": "Has the proof obligation been distinguished from testing and example-based evidence?",
                }
            )


def write_warning_index() -> None:
    concepts = {row["concept_id"]: row for row in load_csv("computational_concepts.csv")}

    with (OUT / "representation_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["warning_id", "concept_id", "concept_name", "warning", "mitigation", "responsible_interpretation_note"],
        )
        writer.writeheader()

        for row in load_csv("representation_warnings.csv"):
            concept = concepts.get(row["concept_id"], {})
            writer.writerow(
                {
                    **row,
                    "concept_name": concept.get("name", row["concept_id"]),
                    "responsible_interpretation_note": "formal correctness, representation quality, and downstream consequences must be audited separately",
                }
            )


def write_type_audit() -> None:
    with (OUT / "type_structure_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["type_id", "name", "type_kind", "mathematical_analogy", "programming_use", "invariant_note", "audit_note"],
        )
        writer.writeheader()

        for row in load_csv("type_examples.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "type structure should document valid operations, invalid operations, and boundary cases",
                }
            )


def write_probability_audit() -> None:
    with (OUT / "probability_uncertainty_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["case_id", "name", "sample_space", "event", "assumption_note", "interpretation", "audit_note"],
        )
        writer.writeheader()

        for row in load_csv("probability_cases.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "probabilistic claim requires sample-space definition, assumptions, calibration, and uncertainty communication",
                }
            )


def write_linear_algebra_audit() -> None:
    with (OUT / "linear_algebra_representation_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["example_id", "name", "object_type", "formula", "computer_science_use", "interpretation", "audit_note"],
        )
        writer.writeheader()

        for row in load_csv("linear_algebra_examples.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "mathematical representation should not be confused with full semantic or social meaning",
                }
            )


def main() -> None:
    write_proof_obligation_index()
    write_warning_index()
    write_type_audit()
    write_probability_audit()
    write_linear_algebra_audit()

    print("Responsible computing audit complete.")
    print(f"  {OUT / 'proof_obligation_index.csv'}")
    print(f"  {OUT / 'representation_warning_index.csv'}")
    print(f"  {OUT / 'type_structure_audit.csv'}")
    print(f"  {OUT / 'probability_uncertainty_audit.csv'}")
    print(f"  {OUT / 'linear_algebra_representation_audit.csv'}")


if __name__ == "__main__":
    main()
