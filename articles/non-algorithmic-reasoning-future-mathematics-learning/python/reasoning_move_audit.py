#!/usr/bin/env python3
"""
Reasoning move and assessment audit for:
"Non-Algorithmic Reasoning and the Future of Mathematics Learning"

This workflow makes non-algorithmic reasoning visible:
- reasoning moves by stage;
- task algorithmic/non-algorithmic balance;
- rubric-based student-solution audits;
- misconception links and intervention notes.
"""

from __future__ import annotations

import csv
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def write_reasoning_stage_summary() -> None:
    moves = load_csv("reasoning_moves.csv")
    by_stage: dict[str, list[str]] = defaultdict(list)

    for row in moves:
        by_stage[row["stage"]].append(row["move_id"])

    with (OUT / "reasoning_stage_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["stage", "move_count", "move_ids", "interpretation"])
        writer.writeheader()

        for stage in sorted(by_stage):
            writer.writerow(
                {
                    "stage": stage,
                    "move_count": len(by_stage[stage]),
                    "move_ids": " ".join(sorted(by_stage[stage])),
                    "interpretation": "stage represents a visible component of non-algorithmic mathematical reasoning",
                }
            )


def write_task_balance_audit() -> None:
    tasks = load_csv("learning_tasks.csv")

    with (OUT / "task_algorithmic_non_algorithmic_balance.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "task_id",
                "title",
                "task_type",
                "algorithmic_component",
                "non_algorithmic_component",
                "design_note",
            ],
        )
        writer.writeheader()

        for row in tasks:
            writer.writerow(
                {
                    "task_id": row["task_id"],
                    "title": row["title"],
                    "task_type": row["task_type"],
                    "algorithmic_component": row["algorithmic_component"],
                    "non_algorithmic_component": row["non_algorithmic_component"],
                    "design_note": "task should assess reasoning in addition to answer correctness",
                }
            )


def write_student_audit_summary() -> None:
    audits = load_csv("student_solution_audits.csv")
    score_fields = [
        "framing_score",
        "representation_score",
        "strategy_score",
        "assumption_score",
        "justification_score",
        "reflection_score",
    ]

    with (OUT / "student_reasoning_audit_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "audit_id",
                "task_id",
                "student_id",
                "method_used",
                "total_score",
                "max_score",
                "reasoning_profile",
                "comment",
            ],
        )
        writer.writeheader()

        for row in audits:
            total = sum(int(row[field]) for field in score_fields)
            max_score = 18
            if total >= 15:
                profile = "strong non-algorithmic reasoning"
            elif total >= 9:
                profile = "partial reasoning visible"
            else:
                profile = "primarily procedural or incomplete"

            writer.writerow(
                {
                    "audit_id": row["audit_id"],
                    "task_id": row["task_id"],
                    "student_id": row["student_id"],
                    "method_used": row["method_used"],
                    "total_score": total,
                    "max_score": max_score,
                    "reasoning_profile": profile,
                    "comment": row["comment"],
                }
            )


def write_misconception_intervention_index() -> None:
    misconceptions = load_csv("misconceptions.csv")

    with (OUT / "misconception_intervention_index.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "misconception_id",
                "name",
                "diagnostic_signal",
                "intervention",
                "reasoning_dimension",
            ],
        )
        writer.writeheader()

        for row in misconceptions:
            name = row["name"].lower()
            if "domain" in name:
                dimension = "assumption checking"
            elif "proof" in name or "examples" in name:
                dimension = "justification"
            elif "tool" in name:
                dimension = "verification"
            elif "answer" in name:
                dimension = "interpretation"
            else:
                dimension = "conceptual understanding"

            writer.writerow(
                {
                    "misconception_id": row["misconception_id"],
                    "name": row["name"],
                    "diagnostic_signal": row["diagnostic_signal"],
                    "intervention": row["intervention"],
                    "reasoning_dimension": dimension,
                }
            )


def main() -> None:
    write_reasoning_stage_summary()
    write_task_balance_audit()
    write_student_audit_summary()
    write_misconception_intervention_index()

    print("Reasoning move audit complete.")
    print(f"  {OUT / 'reasoning_stage_summary.csv'}")
    print(f"  {OUT / 'task_algorithmic_non_algorithmic_balance.csv'}")
    print(f"  {OUT / 'student_reasoning_audit_summary.csv'}")
    print(f"  {OUT / 'misconception_intervention_index.csv'}")


if __name__ == "__main__":
    main()
