#!/usr/bin/env python3
"""
Graph and network workflow for:
"Graphs, Networks, and Discrete Structure"

This workflow demonstrates:
- graph representation from edge lists;
- degree and component audits;
- breadth-first search;
- directed topological ordering;
- weighted shortest paths;
- adjacency matrix export;
- Graphviz DOT export.
"""

from __future__ import annotations

import csv
import heapq
from collections import defaultdict, deque
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT_TABLES = ROOT / "outputs" / "tables"
OUT_FIGURES = ROOT / "outputs" / "figures"
OUT_TABLES.mkdir(parents=True, exist_ok=True)
OUT_FIGURES.mkdir(parents=True, exist_ok=True)


Graph = dict[str, set[str]]
WeightedGraph = dict[str, list[tuple[str, float]]]


def load_csv(filename: str) -> list[dict[str, str]]:
    with (DATA / filename).open("r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def graph_nodes() -> set[str]:
    return {row["node_id"] for row in load_csv("graph_nodes.csv") if len(row["node_id"]) == 1}


def build_graph(graph_id: str, directed: bool = False) -> Graph:
    graph: dict[str, set[str]] = defaultdict(set)
    for node in graph_nodes():
        graph.setdefault(node, set())

    for row in load_csv("graph_edges.csv"):
        if row["graph_id"] != graph_id:
            continue
        source = row["source_node_id"]
        target = row["target_node_id"]
        graph[source].add(target)
        if not directed and row["directed"].lower() == "false":
            graph[target].add(source)

    return dict(graph)


def build_weighted_graph(graph_id: str) -> WeightedGraph:
    graph: dict[str, list[tuple[str, float]]] = defaultdict(list)
    for row in load_csv("graph_edges.csv"):
        if row["graph_id"] != graph_id:
            continue
        source = row["source_node_id"]
        target = row["target_node_id"]
        weight = float(row["weight"] or 1.0)
        graph[source].append((target, weight))
        if row["directed"].lower() == "false":
            graph[target].append((source, weight))
    return dict(graph)


def bfs_component(graph: Graph, start: str) -> set[str]:
    visited: set[str] = set()
    queue: deque[str] = deque([start])

    while queue:
        node = queue.popleft()
        if node in visited:
            continue
        visited.add(node)
        queue.extend(sorted(graph.get(node, set()) - visited))

    return visited


def bfs_distances(graph: Graph, start: str) -> dict[str, int]:
    distances = {start: 0}
    queue: deque[str] = deque([start])

    while queue:
        node = queue.popleft()
        for neighbor in sorted(graph.get(node, set())):
            if neighbor not in distances:
                distances[neighbor] = distances[node] + 1
                queue.append(neighbor)

    return distances


def dijkstra(graph: WeightedGraph, source: str) -> dict[str, float]:
    distances: dict[str, float] = {source: 0.0}
    heap: list[tuple[float, str]] = [(0.0, source)]

    while heap:
        current_distance, node = heapq.heappop(heap)
        if current_distance > distances.get(node, float("inf")):
            continue

        for neighbor, weight in graph.get(node, []):
            candidate = current_distance + weight
            if candidate < distances.get(neighbor, float("inf")):
                distances[neighbor] = candidate
                heapq.heappush(heap, (candidate, neighbor))

    return distances


def topological_sort(directed_graph: Graph) -> tuple[list[str], bool]:
    indegree: dict[str, int] = defaultdict(int)
    nodes = set(directed_graph)
    for source, targets in directed_graph.items():
        nodes.add(source)
        for target in targets:
            nodes.add(target)
            indegree[target] += 1
        indegree.setdefault(source, indegree[source])

    queue = deque(sorted(node for node in nodes if indegree[node] == 0))
    order: list[str] = []

    while queue:
        node = queue.popleft()
        order.append(node)
        for target in sorted(directed_graph.get(node, set())):
            indegree[target] -= 1
            if indegree[target] == 0:
                queue.append(target)

    has_cycle = len(order) != len(nodes)
    return order, has_cycle


def write_degree_component_audit() -> None:
    graph = build_graph("graph_main", directed=False)

    with (OUT_TABLES / "degree_component_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["node_id", "degree", "component", "component_size", "distances_from_node", "interpretation"],
        )
        writer.writeheader()

        for node in sorted(graph):
            component = bfs_component(graph, node)
            distances = bfs_distances(graph, node)
            writer.writerow(
                {
                    "node_id": node,
                    "degree": len(graph[node]),
                    "component": " ".join(sorted(component)),
                    "component_size": len(component),
                    "distances_from_node": "; ".join(f"{k}:{v}" for k, v in sorted(distances.items())),
                    "interpretation": "degree is local; component and distances reflect reachability structure",
                }
            )


def write_adjacency_matrix() -> None:
    graph = build_graph("graph_main", directed=False)
    nodes = sorted(graph)

    with (OUT_TABLES / "adjacency_matrix.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.writer(handle)
        writer.writerow(["node_id", *nodes])
        for source in nodes:
            writer.writerow([source, *[1 if target in graph[source] else 0 for target in nodes]])


def write_weighted_shortest_path_audit() -> None:
    graph = build_weighted_graph("graph_weighted")
    distances = dijkstra(graph, "A")

    with (OUT_TABLES / "weighted_shortest_path_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["source", "target", "distance", "weight_interpretation", "audit_note"],
        )
        writer.writeheader()

        for target, distance in sorted(distances.items()):
            writer.writerow(
                {
                    "source": "A",
                    "target": target,
                    "distance": distance,
                    "weight_interpretation": "synthetic route cost",
                    "audit_note": "shortest path is meaningful only relative to documented edge-weight semantics",
                }
            )


def write_directed_dependency_audit() -> None:
    directed = build_graph("graph_dependency", directed=True)
    order, has_cycle = topological_sort(directed)

    with (OUT_TABLES / "directed_dependency_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["graph_id", "topological_order", "has_cycle", "interpretation"],
        )
        writer.writeheader()
        writer.writerow(
            {
                "graph_id": "graph_dependency",
                "topological_order": " -> ".join(order),
                "has_cycle": has_cycle,
                "interpretation": "directed acyclic graphs support dependency-respecting order",
            }
        )


def write_bipartite_audit() -> None:
    rows = load_csv("bipartite_edges.csv")
    left_degree: dict[str, int] = defaultdict(int)
    right_degree: dict[str, int] = defaultdict(int)

    for row in rows:
        left_degree[row["left_node"]] += 1
        right_degree[row["right_node"]] += 1

    with (OUT_TABLES / "bipartite_degree_audit.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["side", "node", "degree", "interpretation"])
        writer.writeheader()

        for node, degree in sorted(left_degree.items()):
            writer.writerow({"side": "left", "node": node, "degree": degree, "interpretation": "left-node affiliation count"})
        for node, degree in sorted(right_degree.items()):
            writer.writerow({"side": "right", "node": node, "degree": degree, "interpretation": "right-node affiliation count"})


def write_dot_exports() -> None:
    graph = build_graph("graph_main", directed=False)
    with (OUT_FIGURES / "graph_main.dot").open("w", encoding="utf-8") as dot:
        dot.write("graph graph_main {\n")
        dot.write('  graph [rankdir="LR"];\n')
        for node in sorted(graph):
            if not graph[node]:
                dot.write(f'  "{node}";\n')
            for neighbor in sorted(graph[node]):
                if node < neighbor:
                    dot.write(f'  "{node}" -- "{neighbor}";\n')
        dot.write('  note [shape=box, label="Graph layout is visual; adjacency is the mathematical structure"];\n')
        dot.write("}\n")

    directed = build_graph("graph_dependency", directed=True)
    with (OUT_FIGURES / "dependency_graph.dot").open("w", encoding="utf-8") as dot:
        dot.write("digraph graph_dependency {\n")
        dot.write('  graph [rankdir="LR"];\n')
        for source, targets in sorted(directed.items()):
            if not targets:
                dot.write(f'  "{source}";\n')
            for target in sorted(targets):
                dot.write(f'  "{source}" -> "{target}";\n')
        dot.write("}\n")


def main() -> None:
    write_degree_component_audit()
    write_adjacency_matrix()
    write_weighted_shortest_path_audit()
    write_directed_dependency_audit()
    write_bipartite_audit()
    write_dot_exports()

    print("Graph network workflow complete.")
    print(f"  {OUT_TABLES / 'degree_component_audit.csv'}")
    print(f"  {OUT_TABLES / 'adjacency_matrix.csv'}")
    print(f"  {OUT_TABLES / 'weighted_shortest_path_audit.csv'}")
    print(f"  {OUT_TABLES / 'directed_dependency_audit.csv'}")
    print(f"  {OUT_TABLES / 'bipartite_degree_audit.csv'}")
    print(f"  Graphviz DOT files: {OUT_FIGURES / 'graph_main.dot'} and {OUT_FIGURES / 'dependency_graph.dot'}")


if __name__ == "__main__":
    main()
