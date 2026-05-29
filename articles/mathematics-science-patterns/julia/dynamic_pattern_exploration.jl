# Dynamic pattern exploration for "Mathematics as the Science of Patterns"

function iterate_map(f, x0::Float64, n::Int)
    values = Vector{Float64}(undef, n)
    values[1] = x0
    for i in 2:n
        values[i] = f(values[i - 1])
    end
    return values
end

function finite_differences(values)
    return [values[i + 1] - values[i] for i in 1:(length(values) - 1)]
end

function classify_numeric_pattern(values)
    d1 = finite_differences(values)
    d2 = finite_differences(d1)

    if length(unique(round.(d1, digits=10))) == 1
        return "arithmetic"
    elseif length(d2) > 0 && length(unique(round.(d2, digits=10))) == 1
        return "quadratic"
    else
        return "undetermined finite pattern"
    end
end

linear_update(x) = 0.8 * x + 1.0
logistic_update(r) = x -> r * x * (1.0 - x)

println("Finite sequence classification")
println(classify_numeric_pattern([2.0, 5.0, 8.0, 11.0, 14.0]))
println(classify_numeric_pattern([1.0, 4.0, 9.0, 16.0, 25.0]))

println("\nLinear dynamic pattern:")
println(iterate_map(linear_update, 0.0, 20))

println("\nLogistic dynamic pattern r=3.2:")
println(iterate_map(logistic_update(3.2), 0.2, 20))

println("\nLogistic dynamic pattern r=3.7:")
println(iterate_map(logistic_update(3.7), 0.2, 20))
