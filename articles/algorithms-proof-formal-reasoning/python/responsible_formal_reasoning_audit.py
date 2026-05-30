#!/usr/bin/env python3
"""
Responsible formal reasoning audit for:
"Algorithms, Proof, and Formal Reasoning"

This workflow demonstrates:
- proof-obligation indexing;
- invariant and termination tables;
- complexity case indexing;
- evidence-type comparisons;
- formal-reasoning warnings.
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


def algorithm_lookup() -> dict[str, dict[str, str]]:
    return {row["algorithm_id"]: row for row in load_csv("algorithm_specifications.csv")}


def write_proof_index() -> None:
    algorithms = algorithm_lookup()
    with (OUT / "proof_obligation_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "proof_id",
            "algorithm_id",
            "algorithm_name",
            "proof_type",
            "claim",
            "invariant_or_measure",
            "proof_status",
            "risk_note",
            "audit_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_obligations.csv"):
            algorithm = algorithms.get(row["algorithm_id"], {})
            writer.writerow(
                {
                    **row,
                    "algorithm_name": algorithm.get("name", row["algorithm_id"]),
                    "audit_question": "Has this proof obligation been distinguished from tests, traces, and implementation behavior?",
                }
            )


def write_invariant_index() -> None:
    algorithms = algorithm_lookup()
    with (OUT / "invariant_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "invariant_id",
            "algorithm_id",
            "algorithm_name",
            "location",
            "invariant",
            "initialization_note",
            "preservation_note",
            "termination_use",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("invariant_cases.csv"):
            algorithm = algorithms.get(row["algorithm_id"], {})
            writer.writerow(
                {
                    **row,
                    "algorithm_name": algorithm.get("name", row["algorithm_id"]),
                    "audit_note": "invariant proof requires initialization, preservation, and useful termination condition",
                }
            )


def write_termination_index() -> None:
    algorithms = algorithm_lookup()
    with (OUT / "termination_argument_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "termination_id",
            "algorithm_id",
            "algorithm_name",
            "decreasing_measure",
            "lower_bound",
            "termination_claim",
            "failure_mode",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("termination_cases.csv"):
            algorithm = algorithms.get(row["algorithm_id"], {})
            writer.writerow(
                {
                    **row,
                    "algorithm_name": algorithm.get("name", row["algorithm_id"]),
                    "audit_note": "termination argument should identify a well-founded decreasing measure",
                }
            )


def write_complexity_index() -> None:
    algorithms = algorithm_lookup()
    with (OUT / "complexity_case_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["case_id", "algorithm_id", "algorithm_name", "growth_class", "dominant_source", "interpretation", "audit_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("complexity_cases.csv"):
            algorithm = algorithms.get(row["algorithm_id"], {})
            writer.writerow(
                {
                    **row,
                    "algorithm_name": algorithm.get("name", row["algorithm_id"]),
                    "audit_note": "complexity claim should be tied to input model and dominant operation count",
                }
            )


def write_graph_algorithm_index() -> None:
    algorithms = algorithm_lookup()
    with (OUT / "graph_algorithm_assumption_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "graph_case_id",
            "algorithm_id",
            "algorithm_name",
            "graph_type",
            "required_assumption",
            "output_guarantee",
            "interpretive_warning",
            "audit_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("graph_algorithm_assumptions.csv"):
            algorithm = algorithms.get(row["algorithm_id"], {})
            writer.writerow(
                {
                    **row,
                    "algorithm_name": algorithm.get("name", row["algorithm_id"]),
                    "audit_note": "graph algorithm proof depends on graph type, edge semantics, and traversal invariant",
                }
            )


def write_evidence_warning_indexes() -> None:
    with (OUT / "evidence_type_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["evidence_id", "name", "strength", "limitation", "best_use", "audit_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("evidence_types.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "strong systems use multiple forms of evidence rather than treating one method as complete",
                }
            )

    algorithms = algorithm_lookup()
    with (OUT / "formal_reasoning_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["warning_id", "algorithm_id", "algorithm_name", "warning", "mitigation", "responsible_interpretation_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("formal_reasoning_warnings.csv"):
            algorithm = algorithms.get(row["algorithm_id"], {})
            writer.writerow(
                {
                    **row,
                    "algorithm_name": algorithm.get("name", row["algorithm_id"]),
                    "responsible_interpretation_note": "formal correctness, specification quality, and social consequences are separate review layers",
                }
            )


def main() -> None:
    write_proof_index()
    write_invariant_index()
    write_termination_index()
    write_complexity_index()
    write_graph_algorithm_index()
    write_evidence_warning_indexes()

    print("Responsible formal reasoning audit complete.")
    print(f"  {OUT / 'proof_obligation_index.csv'}")
    print(f"  {OUT / 'invariant_index.csv'}")
    print(f"  {OUT / 'termination_argument_index.csv'}")
    print(f"  {OUT / 'complexity_case_index.csv'}")
    print(f"  {OUT / 'graph_algorithm_assumption_index.csv'}")
    print(f"  {OUT / 'evidence_type_index.csv'}")
    print(f"  {OUT / 'formal_reasoning_warning_index.csv'}")


if __name__ == "__main__":
    main()
