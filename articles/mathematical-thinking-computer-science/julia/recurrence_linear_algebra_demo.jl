# Recurrence, complexity, and linear algebra demo for:
# "Mathematical Thinking for Computer Science"

function merge_sort_cost(n)
    n <= 1 && return 1
    return 2 * merge_sort_cost(n ÷ 2) + n
end

function binary_search_cost(n)
    n <= 1 && return 1
    return binary_search_cost(n ÷ 2) + 1
end

function matrix_transform_demo()
    A = [2.0 0.0; 0.0 3.0]
    x = [4.0, 5.0]
    return A * x
end

function adjacency_matrix_demo()
    A = [
        0 1 1 0;
        1 0 0 1;
        1 0 0 0;
        0 1 0 0
    ]
    degrees = sum(A, dims=2)
    return A, degrees
end

println("Divide-and-conquer recurrence costs:")
for n in [1, 2, 4, 8, 16, 32, 64, 128]
    println((n=n, merge_sort_cost=merge_sort_cost(n), binary_search_cost=binary_search_cost(n)))
end

println("Matrix transform y = Ax: ", matrix_transform_demo())
matrix, degrees = adjacency_matrix_demo()
println("Adjacency matrix: ", matrix)
println("Degrees: ", degrees)
println("Interpretation: matrices encode transformations, data, and graph structure.")
