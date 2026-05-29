# Induction and inference demonstration for
# "Proof and the Logic of Mathematical Justification"

struct ProofAuditRow
    n::Int
    computed::Int
    formula::Int
    agrees::Bool
end

function sum_first_n(n::Int)
    return sum(1:n)
end

function formula_sum_first_n(n::Int)
    return div(n * (n + 1), 2)
end

function finite_induction_audit(max_n::Int)
    rows = ProofAuditRow[]
    for n in 1:max_n
        computed = sum_first_n(n)
        formula = formula_sum_first_n(n)
        push!(rows, ProofAuditRow(n, computed, formula, computed == formula))
    end
    return rows
end

function modus_ponens(implication_holds::Bool, antecedent_holds::Bool)
    return implication_holds && antecedent_holds
end

function bounded_nonconvergent_trace(n::Int)
    return [(-1)^k for k in 0:(n - 1)]
end

audit = finite_induction_audit(50)

println("Finite induction-style audit:")
for row in audit[1:10]
    println(row)
end

println("All finite checks agree: ", all(row.agrees for row in audit))
println("Modus ponens demo, implication=true, antecedent=true: ", modus_ponens(true, true))
println("Bounded nonconvergent trace:")
println(bounded_nonconvergent_trace(20))
println("Interpretation: finite checks and traces support reasoning but do not replace proof.")
