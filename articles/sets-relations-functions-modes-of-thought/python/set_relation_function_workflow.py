#!/usr/bin/env python3
"""
Set, relation, and function workflow for:
"Sets, Relations, and Functions as Modes of Thought"

This workflow demonstrates:
- finite set operations;
- relation property audits;
- equivalence classes;
- partial orders;
- function validity checks.
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


def parse_int_set(text: str) -> set[int]:
    return {int(part) for part in text.split() if part.strip().lstrip("-").isdigit()}


def parse_pairs(text: str) -> list[tuple[str, str]]:
    pairs = []
    for token in text.split():
        if ":" in token:
            left, right = token.split(":", 1)
            pairs.append((left, right))
    return pairs


def relation_pairs(relation_id: str) -> set[tuple[int, int]]:
    rows = load_csv("relation_pairs.csv")
    pairs = set()
    for row in rows:
        if row["relation_id"] == relation_id and row["source"].lstrip("-").isdigit() and row["target"].lstrip("-").isdigit():
            pairs.add((int(row["source"]), int(row["target"])))
    return pairs


def is_reflexive(domain: set[int], relation: set[tuple[int, int]]) -> bool:
    return all((x, x) in relation for x in domain)


def is_symmetric(relation: set[tuple[int, int]]) -> bool:
    return all((y, x) in relation for x, y in relation)


def is_transitive(relation: set[tuple[int, int]]) -> bool:
    return all(
        (x, z) in relation
        for x, y in relation
        for y2, z in relation
        if y == y2
    )


def is_antisymmetric(relation: set[tuple[int, int]]) -> bool:
    return all(x == y or (y, x) not in relation for x, y in relation)


def function_valid(domain_elements: list[str], codomain_elements: set[str], mapping_pairs: list[tuple[str, str]]) -> tuple[bool, str]:
    outputs: dict[str, list[str]] = defaultdict(list)

    for source, target in mapping_pairs:
        outputs[source].append(target)
        if target not in codomain_elements:
            return False, f"output {target} is outside codomain"

    for source in domain_elements:
        if source not in outputs:
            return False, f"domain input {source} has no output"
        if len(outputs[source]) != 1:
            return False, f"domain input {source} has {len(outputs[source])} outputs"

    extra_inputs = sorted(set(outputs) - set(domain_elements))
    if extra_inputs:
        return False, f"mapping includes inputs outside domain: {' '.join(extra_inputs)}"

    return True, "valid total function on stated domain and codomain"


def write_set_operations() -> None:
    rows = {row["set_id"]: row for row in load_csv("sets.csv")}
    A = parse_int_set(rows["set_A"]["elements"])
    B = parse_int_set(rows["set_B"]["elements"])
    D = parse_int_set(rows["set_D"]["elements"])

    operations = [
        ("A_union_D", A | D, "union of two finite sets"),
        ("A_intersection_D", A & D, "intersection of two finite sets"),
        ("D_minus_A", D - A, "relative complement of A in D"),
        ("A_image_double", {2 * x for x in A}, "image of A under doubling function"),
        ("B_subset_D", B <= D, "whether B is a subset of D"),
    ]

    with (OUT / "set_operation_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["operation_id", "result", "interpretation"])
        writer.writeheader()
        for operation_id, result, interpretation in operations:
            if isinstance(result, set):
                rendered = " ".join(map(str, sorted(result)))
            else:
                rendered = str(result)
            writer.writerow(
                {
                    "operation_id": operation_id,
                    "result": rendered,
                    "interpretation": interpretation,
                }
            )


def write_relation_property_audit() -> None:
    domains = {
        "rel_mod2": {1, 2, 3, 4},
        "rel_divides": {1, 2, 3, 4, 6, 12},
    }

    with (OUT / "relation_property_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "relation_id",
                "reflexive",
                "symmetric",
                "transitive",
                "antisymmetric",
                "equivalence_relation",
                "partial_order",
                "interpretation",
            ],
        )
        writer.writeheader()

        for relation_id, domain in domains.items():
            rel = relation_pairs(relation_id)
            reflexive = is_reflexive(domain, rel)
            symmetric = is_symmetric(rel)
            transitive = is_transitive(rel)
            antisymmetric = is_antisymmetric(rel)
            writer.writerow(
                {
                    "relation_id": relation_id,
                    "reflexive": reflexive,
                    "symmetric": symmetric,
                    "transitive": transitive,
                    "antisymmetric": antisymmetric,
                    "equivalence_relation": reflexive and symmetric and transitive,
                    "partial_order": reflexive and antisymmetric and transitive,
                    "interpretation": "relation properties determine whether the structure supports equivalence classes or order",
                }
            )


def write_equivalence_class_audit() -> None:
    domain = {1, 2, 3, 4, 5, 6, 7, 8}
    classes: dict[int, list[int]] = defaultdict(list)
    for x in sorted(domain):
        classes[x % 3].append(x)

    with (OUT / "equivalence_class_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["equivalence_rule", "class_label", "members", "interpretation"])
        writer.writeheader()
        for residue, members in sorted(classes.items()):
            writer.writerow(
                {
                    "equivalence_rule": "same remainder modulo 3",
                    "class_label": f"residue_{residue}",
                    "members": " ".join(map(str, members)),
                    "interpretation": "equivalence relation partitions the domain into disjoint classes",
                }
            )


def write_function_validation_audit() -> None:
    rows = load_csv("functions.csv")

    with (OUT / "function_validation_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "function_id",
                "name",
                "domain_set_id",
                "codomain_set_id",
                "mapping_rule",
                "is_valid_total_function",
                "validation_message",
                "interpretation",
            ],
        )
        writer.writeheader()

        for row in rows:
            domain_elements = row["domain_elements"].split()
            codomain_elements = set(row["codomain_elements"].split())
            pairs = parse_pairs(row["mapping_pairs"])
            valid, message = function_valid(domain_elements, codomain_elements, pairs)

            writer.writerow(
                {
                    "function_id": row["function_id"],
                    "name": row["name"],
                    "domain_set_id": row["domain_set_id"],
                    "codomain_set_id": row["codomain_set_id"],
                    "mapping_rule": row["mapping_rule"],
                    "is_valid_total_function": valid,
                    "validation_message": message,
                    "interpretation": "domain and codomain are part of the function definition",
                }
            )


def main() -> None:
    write_set_operations()
    write_relation_property_audit()
    write_equivalence_class_audit()
    write_function_validation_audit()

    print("Set, relation, and function workflow complete.")
    print(f"  {OUT / 'set_operation_audit.csv'}")
    print(f"  {OUT / 'relation_property_audit.csv'}")
    print(f"  {OUT / 'equivalence_class_audit.csv'}")
    print(f"  {OUT / 'function_validation_audit.csv'}")


if __name__ == "__main__":
    main()
