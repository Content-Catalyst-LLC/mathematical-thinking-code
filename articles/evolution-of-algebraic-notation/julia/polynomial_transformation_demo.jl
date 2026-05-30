# Polynomial transformation demo for:
# "The Evolution of Algebraic Notation"

function expanded(x)
    return x^2 + 2x + 1
end

function factored(x)
    return (x + 1)^2
end

println("Polynomial identity audit: x^2 + 2x + 1 = (x+1)^2")
for x in -10:10
    println((x=x, expanded=expanded(x), factored=factored(x), holds=expanded(x) == factored(x)))
end

println("\nSymbolic interpretation:")
println("Finite checks illustrate a pattern; symbolic proof explains why the identity holds generally.")

A = [2.0 1.0; 1.0 3.0]
b = [5.0, 7.0]
x = A \ b

println("\nMatrix notation Ax=b demonstration")
println((A=A, b=b, solution=x))
println("Matrix notation compresses a system of linear equations into one symbolic form.")
