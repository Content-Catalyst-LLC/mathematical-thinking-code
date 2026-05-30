#!/usr/bin/env python3
"""
Historiographic responsibility audit for:
"The Historical Understanding of Mathematics"

This workflow generates:
- historiographic risk indexes;
- canon-risk audits;
- notation anachronism checklist;
- responsible historical interpretation checklist.
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


def write_historiographic_risk_index() -> None:
    with (OUT / "historiographic_risk_index.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["risk_id", "risk_name", "problem", "mitigation", "responsible_history_note"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("historiographic_risks.csv"):
            writer.writerow(
                {
                    **row,
                    "responsible_history_note": "mathematical history should preserve mathematical content while interpreting media, context, and power",
                }
            )


def write_canon_risk_audit() -> None:
    with (OUT / "canon_risk_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["canon_risk_id", "risk", "problem", "responsible_response", "audit_question"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("canon_risks.csv"):
            writer.writerow(
                {
                    **row,
                    "audit_question": "Whose mathematical labor, media, or tradition becomes invisible in this canon?",
                }
            )


def write_notation_anachronism_checklist() -> None:
    with (OUT / "notation_anachronism_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "notation_id",
            "notation_or_medium",
            "mathematical_function",
            "historical_effect",
            "anachronism_warning",
            "review_question",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()

        for row in load_csv("notation_history.csv"):
            writer.writerow(
                {
                    **row,
                    "review_question": "Is this notation being presented as historical expression, modern reconstruction, or both?",
                }
            )


def write_responsible_interpretation_checklist() -> None:
    checks = [
        {
            "check_id": "check_01",
            "question": "Does the account distinguish mathematical validity from historical practice?",
            "risk": "flattening truth and history",
            "mitigation": "state what is formally valid and what is historically situated",
        },
        {
            "check_id": "check_02",
            "question": "Does the account distinguish original notation from modern reconstruction?",
            "risk": "notation anachronism",
            "mitigation": "show or describe original media when possible",
        },
        {
            "check_id": "check_03",
            "question": "Does the account include multiple mathematical traditions without forcing them into a single ladder?",
            "risk": "Eurocentric linear progress narrative",
            "mitigation": "use network, transmission, and plurality language where appropriate",
        },
        {
            "check_id": "check_04",
            "question": "Does the account identify what source survival may have excluded?",
            "risk": "textual and institutional bias",
            "mitigation": "note lost, oral, material, craft, pedagogical, and marginalized practices",
        },
        {
            "check_id": "check_05",
            "question": "Does the account separate proof, model, computation, specification, and consequence?",
            "risk": "formal overconfidence",
            "mitigation": "state evidence standards and limitations explicitly",
        },
    ]

    with (OUT / "responsible_historical_interpretation_checklist.csv").open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["check_id", "question", "risk", "mitigation"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(checks)


def main() -> None:
    write_historiographic_risk_index()
    write_canon_risk_audit()
    write_notation_anachronism_checklist()
    write_responsible_interpretation_checklist()

    print("Historiographic responsibility audit complete.")
    print(f"  {OUT / 'historiographic_risk_index.csv'}")
    print(f"  {OUT / 'canon_risk_audit.csv'}")
    print(f"  {OUT / 'notation_anachronism_checklist.csv'}")
    print(f"  {OUT / 'responsible_historical_interpretation_checklist.csv'}")


if __name__ == "__main__":
    main()
