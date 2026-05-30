#!/usr/bin/env python3
"""
Historical workflow for:
"The History of Mathematical Thinking from Antiquity to Modernity"

This workflow generates:
- period/milestone timelines;
- tradition-mode matrices;
- representation-form indexes;
- structural abstraction summaries;
- computational milestone summaries;
- Graphviz DOT files linking periods, traditions, and thinking modes.
"""

from __future__ import annotations

import csv
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def write_milestone_timeline() -> None:
    periods = {row["period_id"]: row for row in load_csv("historical_periods.csv")}
    traditions = {row["tradition_id"]: row for row in load_csv("mathematical_traditions.csv")}
    modes = {row["mode_id"]: row for row in load_csv("thinking_modes.csv")}

    with (OUT_TABLES / "mathematical_history_timeline.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "milestone_id",
            "period_name",
            "approximate_range",
            "tradition_name",
            "thinking_mode",
            "contribution",
            "representation_form",
            "long_term_significance",
            "responsible_interpretation_note",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("mathematical_milestones.csv"):
            period = periods.get(row["period_id"], {})
            tradition = traditions.get(row["tradition_id"], {})
            mode = modes.get(row["mode_id"], {})
            writer.writerow(
                {
                    "milestone_id": row["milestone_id"],
                    "period_name": period.get("name", row["period_id"]),
                    "approximate_range": period.get("approximate_range", ""),
                    "tradition_name": tradition.get("name", row["tradition_id"]),
                    "thinking_mode": mode.get("name", row["mode_id"]),
                    "contribution": row["contribution"],
                    "representation_form": row["representation_form"],
                    "long_term_significance": row["long_term_significance"],
                    "responsible_interpretation_note": row["responsible_interpretation_note"],
                }
            )


def write_mode_summary() -> None:
    milestones = load_csv("mathematical_milestones.csv")
    modes = {row["mode_id"]: row for row in load_csv("thinking_modes.csv")}
    counts = Counter(row["mode_id"] for row in milestones)

    with (OUT_TABLES / "thinking_mode_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["mode_id", "mode_name", "milestone_count", "description", "typical_representation", "risk_if_overgeneralized"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for mode_id, mode in sorted(modes.items()):
            writer.writerow(
                {
                    "mode_id": mode_id,
                    "mode_name": mode["name"],
                    "milestone_count": counts.get(mode_id, 0),
                    "description": mode["description"],
                    "typical_representation": mode["typical_representation"],
                    "risk_if_overgeneralized": mode["risk_if_overgeneralized"],
                }
            )


def write_tradition_mode_matrix() -> None:
    milestones = load_csv("mathematical_milestones.csv")
    traditions = {row["tradition_id"]: row["name"] for row in load_csv("mathematical_traditions.csv")}
    modes = {row["mode_id"]: row["name"] for row in load_csv("thinking_modes.csv")}
    grouped: dict[tuple[str, str], int] = defaultdict(int)

    for row in milestones:
        grouped[(row["tradition_id"], row["mode_id"])] += 1

    with (OUT_TABLES / "tradition_mode_matrix.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["tradition_id", "tradition_name", "mode_id", "mode_name", "milestone_count", "interpretation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for (tradition_id, mode_id), count in sorted(grouped.items()):
            writer.writerow(
                {
                    "tradition_id": tradition_id,
                    "tradition_name": traditions.get(tradition_id, tradition_id),
                    "mode_id": mode_id,
                    "mode_name": modes.get(mode_id, mode_id),
                    "milestone_count": count,
                    "interpretation": "classification supports comparison but should not flatten traditions or rank them",
                }
            )


def write_representation_index() -> None:
    with (OUT_TABLES / "representation_form_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["representation_id", "name", "historical_layer", "mathematical_function", "interpretation_risk", "audit_question"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("representation_forms.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "How does this representation make a mathematical object, relation, or procedure visible?",
                }
            )


def write_structure_and_computation_indexes() -> None:
    with (OUT_TABLES / "structural_abstraction_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["structure_id", "name", "objects", "relations_or_operations", "thinking_shift", "example_use", "audit_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("structural_abstractions.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "structural abstraction generalizes across examples by preserving relations, operations, and laws",
                }
            )

    with (OUT_TABLES / "computational_milestone_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["computation_id", "name", "period", "mathematical_role", "representation", "interpretation_warning", "audit_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("computational_milestones.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_note": "computational mathematics should distinguish procedure, evidence, proof, model, and interpretation",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_history_graph() -> None:
    milestones = load_csv("mathematical_milestones.csv")
    periods = {row["period_id"]: row["name"] for row in load_csv("historical_periods.csv")}
    traditions = {row["tradition_id"]: row["name"] for row in load_csv("mathematical_traditions.csv")}
    modes = {row["mode_id"]: row["name"] for row in load_csv("thinking_modes.csv")}

    with (OUT_FIGURES / "mathematical_history_graph.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph mathematical_history_graph {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')

        for row in milestones:
            milestone = safe_dot(row["milestone_id"])
            period = safe_dot(periods.get(row["period_id"], row["period_id"]))
            tradition = safe_dot(traditions.get(row["tradition_id"], row["tradition_id"]))
            mode = safe_dot(modes.get(row["mode_id"], row["mode_id"]))
            dot.write(f'  "{period}" -> "{milestone}" [label="period"];\n')
            dot.write(f'  "{tradition}" -> "{milestone}" [label="tradition"];\n')
            dot.write(f'  "{milestone}" -> "{mode}" [label="mode"];\n')

        dot.write('  note [shape=note, label="Synthetic teaching graph: mathematical history is global, branching, and non-linear."];\n')
        dot.write("}\n")


def main() -> None:
    write_milestone_timeline()
    write_mode_summary()
    write_tradition_mode_matrix()
    write_representation_index()
    write_structure_and_computation_indexes()
    write_history_graph()

    print("Mathematical history workflow complete.")
    print(f"  {OUT_TABLES / 'mathematical_history_timeline.csv'}")
    print(f"  {OUT_TABLES / 'thinking_mode_summary.csv'}")
    print(f"  {OUT_TABLES / 'tradition_mode_matrix.csv'}")
    print(f"  {OUT_TABLES / 'representation_form_index.csv'}")
    print(f"  {OUT_TABLES / 'structural_abstraction_index.csv'}")
    print(f"  {OUT_TABLES / 'computational_milestone_index.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'mathematical_history_graph.dot'}")


if __name__ == "__main__":
    main()
