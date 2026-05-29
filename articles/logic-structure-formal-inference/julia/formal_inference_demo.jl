# Formal inference demonstration for
# "Logic and the Structure of Formal Inference"

implies(p::Bool, q::Bool) = (!p) || q
equivalent(p::Bool, q::Bool) = p == q

function truth_table()
    rows = []
    for p in [false, true]
        for q in [false, true]
            original = implies(p, q)
            converse = implies(q, p)
            contrapositive = implies(!q, !p)
            push!(rows, (
                P=p,
                Q=q,
                implication=original,
                converse=converse,
                contrapositive=contrapositive,
                contrapositive_equiv=equivalent(original, contrapositive)
            ))
        end
    end
    return rows
end

function modus_ponens(implication_holds::Bool, antecedent_holds::Bool)
    if implication_holds && antecedent_holds
        return true
    else
        return false
    end
end

function finite_even_square_audit(domain)
    return [(n=n, premise_even=iseven(n), conclusion_square_even=iseven(n*n),
             implication_holds=implies(iseven(n), iseven(n*n))) for n in domain]
end

println("Truth table for implication, converse, and contrapositive")
for row in truth_table()
    println(row)
end

println("\nModus ponens demo: ", modus_ponens(true, true))

audit = finite_even_square_audit(-20:20)
println("\nFinite even-square audit all implication rows hold: ", all(row.implication_holds for row in audit))
println("Interpretation: finite audits are illustrative; direct proof handles arbitrary integers.")
