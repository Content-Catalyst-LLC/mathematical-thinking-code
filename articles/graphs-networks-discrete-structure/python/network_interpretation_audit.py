#!/usr/bin/env python3
"""
Network interpretation audit for:
"Graphs, Networks, and Discrete Structure"

This workflow demonstrates:
- algorithm metadata indexing;
- centrality interpretation warnings;
- network example interpretation;
- graph-model warning and mitigation tables.
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


def write_algorithm_index() -> None:
    with (OUT / "graph_algorithm_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "algorithm_id",
                "name",
                "graph_type",
                "input_assumption",
                "output",
                "complexity_note",
                "audit_note",
                "professional_question",
            ],
        )
        writer.writeheader()

        for row in load_csv("graph_algorithms.csv"):
            writer.writerow(
                {
                    **row,
                    "professional_question": "Do the algorithm assumptions match the graph type and edge semantics?",
                }
            )


def write_centrality_index() -> None:
    with (OUT / "centrality_interpretation_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["case_id", "node_id", "metric", "value_note", "interpretation_risk", "mitigation", "audit_note"],
        )
        writer.writeheader()

        for row in load_csv("centrality_cases.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "centrality is a structural measure, not a direct measure of legitimacy, expertise, or moral value",
                }
            )


def write_network_example_index() -> None:
    with (OUT / "network_example_interpretation_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["network_id", "name", "node_meaning", "edge_meaning", "interpretive_risk", "audit_question", "interpretation_note"],
        )
        writer.writeheader()

        for row in load_csv("network_examples.csv"):
            writer.writerow(
                {
                    **row,
                    "interpretation_note": "network meaning depends on node definition, edge definition, data collection, and provenance",
                }
            )


def write_warning_index() -> None:
    with (OUT / "network_warning_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["warning_id", "graph_id", "structure_type", "warning", "mitigation", "responsible_interpretation_note"],
        )
        writer.writeheader()

        for row in load_csv("network_warnings.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_interpretation_note": "define nodes, edges, weights, direction, provenance, uncertainty, and downstream consequences",
                }
            )


def main() -> None:
    write_algorithm_index()
    write_centrality_index()
    write_network_example_index()
    write_warning_index()

    print("Network interpretation audit complete.")
    print(f"  {OUT / 'graph_algorithm_index.csv'}")
    print(f"  {OUT / 'centrality_interpretation_index.csv'}")
    print(f"  {OUT / 'network_example_interpretation_index.csv'}")
    print(f"  {OUT / 'network_warning_index.csv'}")


if __name__ == "__main__":
    main()
