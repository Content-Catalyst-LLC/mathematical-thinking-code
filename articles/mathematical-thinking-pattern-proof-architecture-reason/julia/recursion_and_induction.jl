# Mathematical Thinking: Recursion and Induction in Julia
# Educational example only.

function recursive_sequence(initial_value::Int, update_rule::Function, n_terms::Int)
    n_terms <= 0 && error("n_terms must be positive")

    values = Vector{Int}(undef, n_terms)
    values[1] = initial_value

    for i in 2:n_terms
        values[i] = update_rule(values[i - 1], i - 1)
    end

    return values
end

function triangular_number(n::Int)
    n < 0 && error("n must be nonnegative")
    return div(n * (n + 1), 2)
end

function induction_style_check(max_n::Int)
    rows = []

    for n in 1:max_n
        direct_sum = sum(1:n)
        formula_value = triangular_number(n)
        push!(rows, (n=n, direct_sum=direct_sum, formula_value=formula_value, matches=(direct_sum == formula_value)))
    end

    return rows
end

arithmetic_like = recursive_sequence(2, (current, i) -> current + 3, 20)
doubling_like = recursive_sequence(1, (current, i) -> current * 2, 20)

println("Arithmetic-like sequence:")
println(arithmetic_like)

println("\nDoubling-like sequence:")
println(doubling_like)

println("\nInduction-style checks:")
for row in induction_style_check(20)
    println(row)
end
