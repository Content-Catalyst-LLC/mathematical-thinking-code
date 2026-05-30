#!/usr/bin/env python3
"""
Proof-history workflow for:
"The Historical Development of Proof"

This workflow demonstrates:
- proof-style classification;
- proof-tradition and milestone indexing;
- proof-medium summaries;
- proposition-dependency graph export;
- timeline-style audit tables.
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


def write_style_summary() -> None:
    milestones = load_csv("proof_milestones.csv")
    styles = {row["style_id"]: row["name"] for row in load_csv("proof_styles.csv")}
    counts = Counter(row["proof_style_id"] for row in milestones)

    with (OUT_TABLES / "proof_style_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["style_id", "style_name", "milestone_count", "interpretation"])
        writer.writeheader()

        for style_id, count in sorted(counts.items()):
            writer.writerow(
                {
                    "style_id": style_id,
                    "style_name": styles.get(style_id, style_id),
                    "milestone_count": count,
                    "interpretation": "style count reflects synthetic teaching metadata, not historical prevalence",
                }
            )


def write_milestone_timeline() -> None:
    traditions = {row["tradition_id"]: row for row in load_csv("proof_traditions.csv")}
    styles = {row["style_id"]: row for row in load_csv("proof_styles.csv")}

    with (OUT_TABLES / "proof_milestone_timeline.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "milestone_id",
            "figure_or_text",
            "approximate_period",
            "tradition_name",
            "region_or_language_context",
            "proof_style",
            "contribution",
            "proof_historical_significance",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_milestones.csv"):
            tradition = traditions.get(row["tradition_id"], {})
            style = styles.get(row["proof_style_id"], {})
            writer.writerow(
                {
                    "milestone_id": row["milestone_id"],
                    "figure_or_text": row["figure_or_text"],
                    "approximate_period": row["approximate_period"],
                    "tradition_name": tradition.get("name", row["tradition_id"]),
                    "region_or_language_context": tradition.get("region_or_language_context", ""),
                    "proof_style": style.get("name", row["proof_style_id"]),
                    "contribution": row["contribution"],
                    "proof_historical_significance": row["proof_historical_significance"],
                }
            )


def write_tradition_style_matrix() -> None:
    milestones = load_csv("proof_milestones.csv")
    traditions = {row["tradition_id"]: row["name"] for row in load_csv("proof_traditions.csv")}
    styles = {row["style_id"]: row["name"] for row in load_csv("proof_styles.csv")}

    grouped: dict[tuple[str, str], int] = defaultdict(int)
    for row in milestones:
        grouped[(row["tradition_id"], row["proof_style_id"])] += 1

    with (OUT_TABLES / "tradition_style_matrix.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["tradition_id", "tradition_name", "style_id", "style_name", "milestone_count", "interpretation"],
        )
        writer.writeheader()

        for (tradition_id, style_id), count in sorted(grouped.items()):
            writer.writerow(
                {
                    "tradition_id": tradition_id,
                    "tradition_name": traditions.get(tradition_id, tradition_id),
                    "style_id": style_id,
                    "style_name": styles.get(style_id, style_id),
                    "milestone_count": count,
                    "interpretation": "classification supports comparison but should not flatten traditions",
                }
            )


def write_media_summary() -> None:
    with (OUT_TABLES / "proof_media_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["medium_id", "name", "historical_context", "proof_effect", "interpretation_risk", "audit_question"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("proof_media.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "How does this medium shape what proof can preserve, display, standardize, or conceal?",
                }
            )


def safe_dot(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def write_dependency_dot() -> None:
    dependencies = load_csv("proposition_dependencies.csv")

    with (OUT_FIGURES / "proof_dependency_graph.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph proof_dependency_graph {\n")
        dot.write('  graph [rankdir="LR"];\n')
        dot.write('  node [shape=box];\n')
        for row in dependencies:
            source = safe_dot(row["source_claim"])
            target = safe_dot(row["target_claim"])
            label = safe_dot(row["relationship"])
            dot.write(f'  "{source}" -> "{target}" [label="{label}"];\n')
        dot.write('  note [shape=note, label="Dependency graph is synthetic teaching metadata, not a complete historical reconstruction."];\n')
        dot.write("}\n")


def main() -> None:
    write_style_summary()
    write_milestone_timeline()
    write_tradition_style_matrix()
    write_media_summary()
    write_dependency_dot()

    print("Proof history workflow complete.")
    print(f"  {OUT_TABLES / 'proof_style_summary.csv'}")
    print(f"  {OUT_TABLES / 'proof_milestone_timeline.csv'}")
    print(f"  {OUT_TABLES / 'tradition_style_matrix.csv'}")
    print(f"  {OUT_TABLES / 'proof_media_summary.csv'}")
    print(f"  Graphviz DOT file: {OUT_FIGURES / 'proof_dependency_graph.dot'}")


if __name__ == "__main__":
    main()
