# Recurrence, modular arithmetic, and graph adjacency demo for:
# "Discrete Mathematics and the Logic of Structure"

function fibonacci(n)
    if n == 0
        return 0
    elseif n == 1
        return 1
    end

    previous = 0
    current = 1

    for _ in 2:n
        previous, current = current, previous + current
    end

    return current
end

function residues(modulus, n)
    return [k % modulus for k in 0:(n - 1)]
end

function degree_table(vertices, edges)
    counts = Dict(v => 0 for v in vertices)
    for (u, v) in edges
        counts[u] += 1
        counts[v] += 1
    end
    return counts
end

vertices = ["A", "B", "C", "D", "E"]
edges = [("A", "B"), ("A", "C"), ("B", "D")]

println("Fibonacci values: ", [fibonacci(n) for n in 0:12])
println("Residues mod 7: ", residues(7, 21))
println("Degree table: ", degree_table(vertices, edges))
println("Interpretation: recurrence, modular arithmetic, and graph adjacency reveal discrete rule-governed structure.")
