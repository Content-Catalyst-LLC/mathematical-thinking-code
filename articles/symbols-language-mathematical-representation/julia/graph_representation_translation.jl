# Graph representation translation for:
# "Symbols, Language, and Mathematical Representation"

vertices = ["a", "b", "c", "d"]
edges = [("a", "b"), ("b", "c"), ("c", "d"), ("d", "a")]

function adjacency_matrix(vertices, edges)
    index = Dict(v => i for (i, v) in enumerate(vertices))
    matrix = zeros(Int, length(vertices), length(vertices))

    for (u, v) in edges
        i = index[u]
        j = index[v]
        matrix[i, j] = 1
        matrix[j, i] = 1
    end

    return matrix
end

abstract type Expr end

struct Var <: Expr
    name::String
end

struct Const <: Expr
    value::Float64
end

struct Add <: Expr
    left::Expr
    right::Expr
end

struct Mul <: Expr
    left::Expr
    right::Expr
end

function render(expr::Expr)
    if expr isa Var
        return expr.name
    elseif expr isa Const
        return string(expr.value)
    elseif expr isa Add
        return "(" * render(expr.left) * " + " * render(expr.right) * ")"
    elseif expr isa Mul
        return "(" * render(expr.left) * " * " * render(expr.right) * ")"
    else
        error("unknown expression")
    end
end

function evaluate(expr::Expr, env::Dict{String, Float64})
    if expr isa Var
        return env[expr.name]
    elseif expr isa Const
        return expr.value
    elseif expr isa Add
        return evaluate(expr.left, env) + evaluate(expr.right, env)
    elseif expr isa Mul
        return evaluate(expr.left, env) * evaluate(expr.right, env)
    else
        error("unknown expression")
    end
end

println("Adjacency matrix for C4:")
println(adjacency_matrix(vertices, edges))

expr = Mul(Add(Var("x"), Const(2.0)), Var("y"))
println("Rendered expression: ", render(expr))
println("Evaluated expression: ", evaluate(expr, Dict("x" => 3.0, "y" => 4.0)))
println("Interpretation: symbolic and graph representations preserve selected structures for computation.")
