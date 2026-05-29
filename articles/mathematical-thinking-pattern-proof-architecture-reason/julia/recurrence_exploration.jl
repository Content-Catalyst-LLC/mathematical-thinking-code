# Recurrence exploration for "What Is Mathematical Thinking?"

using Printf

struct LinearRecurrence
    name::String
    seeds::Vector{BigInt}
    coefficients::Vector{BigInt}
end

function generate(rec::LinearRecurrence, n::Int)
    if n <= 0
        return BigInt[]
    end
    values = BigInt[]
    for seed in rec.seeds[1:min(n, length(rec.seeds))]
        push!(values, seed)
    end

    order = length(rec.coefficients)
    while length(values) < n
        window = values[(end - order + 1):end]
        push!(values, sum(rec.coefficients .* window))
    end
    return values
end

function residues(values::Vector{BigInt}, modulus::Int)
    return [Int(mod(v, modulus)) for v in values]
end

function first_repeat_pair(values::Vector{Int})
    seen = Dict{Tuple{Int, Int}, Int}()
    for i in 1:(length(values) - 1)
        pair = (values[i], values[i + 1])
        if haskey(seen, pair)
            return (seen[pair], i)
        end
        seen[pair] = i
    end
    return nothing
end

function main()
    recurrences = [
        LinearRecurrence("fibonacci", BigInt[0, 1], BigInt[1, 1]),
        LinearRecurrence("lucas", BigInt[2, 1], BigInt[1, 1]),
        LinearRecurrence("pell", BigInt[0, 1], BigInt[1, 2])
    ]

    for rec in recurrences
        values = generate(rec, 40)
        @printf("\n%s\n", rec.name)
        println(values[1:12])
        for modulus in 2:10
            r = residues(values, modulus)
            repeat_pair = first_repeat_pair(r)
            println("  modulus=", modulus, " first_repeat_pair=", repeat_pair)
        end
    end
end

main()
