"""
Mathematical Thinking Workflow

Educational examples for pattern recognition, recursion, induction-style checking,
and proof dependency graphs.

Run:
    python mathematical_thinking_workflow.py
"""

from __future__ import annotations

from typing import Callable, List, Tuple
import pandas as pd
import networkx as nx


def generate_recursive_sequence(
    initial_value: int,
    update_rule: Callable[[int, int], int],
    n_terms: int
) -> List[int]:
    """Generate a recursively defined integer sequence."""
    if n_terms <= 0:
        raise ValueError("n_terms must be positive.")

    values = [initial_value]

    for index in range(1, n_terms):
        values.append(update_rule(values[-1], index))

    return values


def triangular_number(n: int) -> int:
    """Return the nth triangular number using the closed form."""
    if n < 0:
        raise ValueError("n must be nonnegative.")
    return n * (n + 1) // 2


def sum_first_n_integers(n: int) -> int:
    """Return the sum 1 + 2 + ... + n."""
    if n < 0:
        raise ValueError("n must be nonnegative.")
    return sum(range(1, n + 1))


def build_induction_check(max_n: int = 50) -> pd.DataFrame:
    """
    Check the triangular-number formula for many cases.

    This is evidence for a conjecture, not a proof.
    """
    rows = []

    for n in range(1, max_n + 1):
        rows.append({
            "n": n,
            "sum_first_n": sum_first_n_integers(n),
            "formula_value": triangular_number(n),
            "matches": sum_first_n_integers(n) == triangular_number(n)
        })

    return pd.DataFrame(rows)


def build_proof_dependency_graph() -> nx.DiGraph:
    """Build a simple proof dependency graph."""
    proof_edges: List[Tuple[str, str]] = [
        ("Definition: natural numbers", "Lemma: successor structure"),
        ("Definition: addition", "Lemma: recursive sum"),
        ("Lemma: successor structure", "Induction principle"),
        ("Lemma: recursive sum", "Theorem: triangular number formula"),
        ("Induction principle", "Theorem: triangular number formula"),
        ("Base case", "Theorem: triangular number formula"),
        ("Inductive step", "Theorem: triangular number formula"),
    ]

    graph = nx.DiGraph()
    graph.add_edges_from(proof_edges)
    return graph


def proof_graph_metrics(graph: nx.DiGraph) -> pd.DataFrame:
    """Calculate simple graph metrics for a proof dependency graph."""
    centrality = nx.degree_centrality(graph)

    return pd.DataFrame({
        "node": list(graph.nodes()),
        "in_degree": [graph.in_degree(node) for node in graph.nodes()],
        "out_degree": [graph.out_degree(node) for node in graph.nodes()],
        "degree_centrality": [centrality[node] for node in graph.nodes()]
    }).sort_values("degree_centrality", ascending=False)


def main() -> None:
    arithmetic_like = generate_recursive_sequence(
        initial_value=2,
        update_rule=lambda current, index: current + 3,
        n_terms=20
    )

    doubling_like = generate_recursive_sequence(
        initial_value=1,
        update_rule=lambda current, index: current * 2,
        n_terms=20
    )

    print("Arithmetic-like sequence:")
    print(arithmetic_like)

    print("\nDoubling-like sequence:")
    print(doubling_like)

    induction_checks = build_induction_check(max_n=50)
    print("\nInduction-style computational checks:")
    print(induction_checks.head())
    print("All checked cases match:", induction_checks["matches"].all())

    graph = build_proof_dependency_graph()
    metrics = proof_graph_metrics(graph)

    print("\nProof dependency graph metrics:")
    print(metrics)

    induction_checks.to_csv("../outputs/induction_checks.csv", index=False)
    metrics.to_csv("../outputs/proof_graph_metrics.csv", index=False)


if __name__ == "__main__":
    main()
