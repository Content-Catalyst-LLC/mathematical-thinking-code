# Function dependence and residual checks for:
# "What Makes Algebraic Thinking Distinct?"

function f(x)
    return 3x + 2
end

function solve_linear(a, b, y)
    return (y - b) / a
end

function residual(a, b, x, y)
    return a*x + b - y
end

function equivalence_audit(domain)
    rows = []
    for x in domain
        expanded = 2x + 6
        factored = 2 * (x + 3)
        push!(rows, (x=x, expanded=expanded, factored=factored, agrees=expanded == factored))
    end
    return rows
end

x_candidate = solve_linear(3.0, 2.0, 17.0)

println("Function dependence demo")
println("f(5) = ", f(5))
println("Candidate solution to 3x+2=17: ", x_candidate)
println("Residual check: ", residual(3.0, 2.0, x_candidate, 17.0))
println("Equivalence audit: ", equivalence_audit(-3:3))
println("Interpretation: algebraic reasoning joins symbolic relation, solution candidate, and verification.")
