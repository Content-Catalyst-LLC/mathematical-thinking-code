# Procedure-versus-verification demonstration for:
# "Non-Algorithmic Reasoning and the Future of Mathematics Learning"

function quadratic_formula(a, b, c)
    discriminant = b^2 - 4a*c
    if discriminant < 0
        return nothing
    end
    return ((-b + sqrt(discriminant)) / (2a),
            (-b - sqrt(discriminant)) / (2a))
end

function residual(a, b, c, x)
    return a*x^2 + b*x + c
end

function verify_roots(a, b, c, roots)
    if roots === nothing
        return ["no real roots"]
    end
    return [(root=r, residual=residual(a,b,c,r), passes=abs(residual(a,b,c,r)) < 1e-10) for r in roots]
end

function reasoning_quality(assumptions_checked, interpretation_given, justification_given)
    if assumptions_checked && interpretation_given && justification_given
        return "strong reasoning"
    elseif justification_given
        return "partially justified"
    else
        return "procedural or incomplete"
    end
end

roots = quadratic_formula(1.0, -5.0, 6.0)

println("Computed roots: ", roots)
println("Residual checks: ", verify_roots(1.0, -5.0, 6.0, roots))
println("Reasoning quality example: ", reasoning_quality(true, false, true))
println("Interpretation: procedure provides candidates; verification and interpretation create mathematical accountability.")
