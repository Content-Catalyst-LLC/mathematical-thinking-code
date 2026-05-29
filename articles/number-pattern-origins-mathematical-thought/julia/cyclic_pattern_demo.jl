# Cyclic pattern and finite-difference demo for:
# "Number, Pattern, and the Origins of Mathematical Thought"

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

function cycle_position(t, period)
    return mod(t, period)
end

function rhythmic_pattern(length, period)
    return [cycle_position(t, period) for t in 0:(length - 1)]
end

triangular = [1, 3, 6, 10, 15, 21, 28]
cycle = rhythmic_pattern(16, 4)

println("Triangular sequence classification: ", classify_sequence(triangular))
println("Triangular first differences: ", finite_differences(triangular))
println("Triangular second differences: ", finite_differences(finite_differences(triangular)))
println("Cyclic pattern: ", cycle)
println("Interpretation: finite patterns suggest structure; modular arithmetic and proof give formal meaning.")
