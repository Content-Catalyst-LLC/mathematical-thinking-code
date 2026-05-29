# Discovery exploration for:
# "Conjecture, Creativity, and Mathematical Discovery"

function iterate_map(f, x0::Float64, steps::Int)
    values = Vector{Float64}(undef, steps)
    values[1] = x0
    for i in 2:steps
        values[i] = f(values[i - 1])
    end
    return values
end

function appears_bounded(values; bound = 1.0)
    return all(abs.(values) .<= bound)
end

function finite_differences(values)
    return [values[i + 1] - values[i] for i in 1:(length(values) - 1)]
end

function classify_sequence(values)
    d1 = finite_differences(values)
    d2 = finite_differences(d1)
    if length(unique(d1)) == 1
        return "arithmetic"
    elseif length(d2) > 0 && length(unique(d2)) == 1
        return "quadratic"
    else
        return "undetermined finite pattern"
    end
end

linear_update(x) = 0.8 * x + 0.1
logistic_update(r) = x -> r * x * (1.0 - x)

linear_values = iterate_map(linear_update, 0.2, 50)
logistic_values = iterate_map(logistic_update(3.7), 0.2, 50)

println("Finite discovery audit")
println("Arithmetic classification: ", classify_sequence([2, 5, 8, 11, 14]))
println("Quadratic classification: ", classify_sequence([1, 4, 9, 16, 25]))
println("Linear system appears bounded: ", appears_bounded(linear_values))
println("Logistic system appears bounded: ", appears_bounded(logistic_values))
println("Interpretation: simulation and finite checks suggest conjectures but do not replace proof.")
