# Recurrence, generating-function coefficients, and search-space growth demo for:
# "Combinatorics and the Mathematics of Possibility"

function binomial(n, k)
    if k < 0 || k > n
        return big(0)
    end
    k = min(k, n - k)
    result = big(1)
    for i in 1:k
        result = result * (n - k + i) ÷ i
    end
    return result
end

function fibonacci_tilings(n)
    if n == 0 || n == 1
        return big(1)
    end
    previous = big(1)
    current = big(1)
    for _ in 2:n
        previous, current = current, previous + current
    end
    return current
end

function pascal_row(n)
    return [binomial(n, k) for k in 0:n]
end

function search_space_table(nmax)
    return [
        (n=n, subsets=big(2)^n, simple_graphs=big(2)^binomial(n, 2), tilings=fibonacci_tilings(n))
        for n in 1:nmax
    ]
end

println("Pascal row 8: ", pascal_row(8))
println("Fibonacci tiling counts 0..12: ", [fibonacci_tilings(n) for n in 0:12])
println("Search-space growth: ", search_space_table(10))
println("Interpretation: combinatorial structures encode possibility through rules, coefficients, and recurrence.")
