# Transformation and invariant exploration for
# "Patterns, Structure, and the Mathematical Imagination"

using Printf

struct SimpleGraph
    name::String
    vertices::Vector{String}
    edges::Vector{Tuple{String,String}}
end

function degree_sequence(g::SimpleGraph)
    counts = Dict(v => 0 for v in g.vertices)
    for (a, b) in g.edges
        counts[a] = get(counts, a, 0) + 1
        counts[b] = get(counts, b, 0) + 1
    end
    return sort(collect(values(counts)), rev=true)
end

function relabel(g::SimpleGraph, mapping::Dict{String,String}, new_name::String)
    new_vertices = [mapping[v] for v in g.vertices]
    new_edges = [(mapping[a], mapping[b]) for (a,b) in g.edges]
    return SimpleGraph(new_name, new_vertices, new_edges)
end

function recurrence(seed::Vector{BigInt}, coefficients::Vector{BigInt}, n::Int)
    values = copy(seed[1:min(n, length(seed))])
    order = length(coefficients)
    while length(values) < n
        window = values[(end - order + 1):end]
        push!(values, sum(coefficients .* window))
    end
    return values
end

function main()
    cycle4 = SimpleGraph(
        "cycle4",
        ["a", "b", "c", "d"],
        [("a", "b"), ("b", "c"), ("c", "d"), ("d", "a")]
    )

    mapping = Dict("a"=>"w", "b"=>"x", "c"=>"y", "d"=>"z")
    renamed = relabel(cycle4, mapping, "renamed_cycle4")

    println("Graph invariance under relabeling")
    println(cycle4.name, ": ", degree_sequence(cycle4))
    println(renamed.name, ": ", degree_sequence(renamed))
    println("Degree-sequence invariant preserved: ", degree_sequence(cycle4) == degree_sequence(renamed))

    println("\nRecurrence pattern")
    fib = recurrence(BigInt[0,1], BigInt[1,1], 20)
    println(fib)
    println("Parity pattern: ", [mod(v, 2) for v in fib])
end

main()
