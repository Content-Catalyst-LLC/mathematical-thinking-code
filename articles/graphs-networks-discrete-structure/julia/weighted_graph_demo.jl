# Weighted graph and dependency demo for:
# "Graphs, Networks, and Discrete Structure"

function dijkstra(vertices, edges, source)
    dist = Dict(v => Inf for v in vertices)
    dist[source] = 0.0
    visited = Set{String}()

    while length(visited) < length(vertices)
        candidates = [v for v in vertices if !(v in visited)]
        isempty(candidates) && break

        u = candidates[argmin([dist[v] for v in candidates])]
        push!(visited, u)

        for (a, b, w) in edges
            if a == u && dist[u] + w < dist[b]
                dist[b] = dist[u] + w
            end
        end
    end

    return dist
end

function degree_table(vertices, edges)
    counts = Dict(v => 0 for v in vertices)
    for (u, v) in edges
        counts[u] += 1
        counts[v] += 1
    end
    return counts
end

vertices = ["A", "B", "C", "D"]
weighted_edges = [
    ("A", "D", 7.0),
    ("A", "B", 2.0),
    ("B", "D", 3.0),
    ("A", "C", 5.0),
    ("C", "D", 1.0)
]

undirected_edges = [("A", "B"), ("A", "C"), ("B", "D")]

println("Degree table: ", degree_table(["A", "B", "C", "D", "E"], undirected_edges))
println("Shortest-path distances from A: ", dijkstra(vertices, weighted_edges, "A"))
println("Interpretation: shortest path depends on edge-weight meaning and graph direction.")
