# Typed-function validation demo for:
# "Sets, Relations, and Functions as Modes of Thought"

struct TypedFunction
    name::String
    domain::Vector{String}
    codomain::Vector{String}
    mapping::Dict{String,String}
end

function validate_total_function(f::TypedFunction)
    for x in f.domain
        if !haskey(f.mapping, x)
            return (false, "missing output for input $(x)")
        end
        y = f.mapping[x]
        if !(y in f.codomain)
            return (false, "output $(y) is outside codomain")
        end
    end

    for x in keys(f.mapping)
        if !(x in f.domain)
            return (false, "mapping includes input $(x) outside domain")
        end
    end

    return (true, "valid total function on stated domain and codomain")
end

function compose_label_after_double(x::Int)
    y = 2x
    label = y <= 2 ? "low" : y <= 6 ? "medium" : "high"
    return (input=x, after_double=y, after_label=label)
end

double = TypedFunction(
    "double",
    ["1", "2", "3", "4"],
    ["2", "4", "6", "8"],
    Dict("1"=>"2", "2"=>"4", "3"=>"6", "4"=>"8")
)

bad_square = TypedFunction(
    "restricted square",
    ["1", "2", "3", "4"],
    ["1", "2", "3", "4", "6", "12"],
    Dict("1"=>"1", "2"=>"4", "3"=>"9", "4"=>"16")
)

println(validate_total_function(double))
println(validate_total_function(bad_square))
println(compose_label_after_double(3))
println("Interpretation: domain and codomain are part of the mapping, not optional decoration.")
