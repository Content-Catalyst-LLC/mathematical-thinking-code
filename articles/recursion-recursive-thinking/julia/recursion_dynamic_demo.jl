# Recursion, memoization, tree traversal, and divide-and-conquer demo for:
# "Recursion and Recursive Thinking"

struct Tree
    label::String
    children::Vector{Tree}
end

function factorial_recursive(n)
    n < 0 && error("factorial requires nonnegative input")
    n == 0 && return big(1)
    return big(n) * factorial_recursive(n - 1)
end

function fibonacci_memo(n, memo=Dict{Int, BigInt}())
    n < 0 && error("fibonacci requires nonnegative input")
    if n == 0
        return big(0)
    elseif n == 1
        return big(1)
    elseif haskey(memo, n)
        return memo[n]
    end

    memo[n] = fibonacci_memo(n - 1, memo) + fibonacci_memo(n - 2, memo)
    return memo[n]
end

function tree_size(tree::Tree)
    return 1 + sum(tree_size(child) for child in tree.children; init=0)
end

function tree_depth(tree::Tree)
    isempty(tree.children) && return 1
    return 1 + maximum(tree_depth(child) for child in tree.children)
end

function merge_sort(values)
    length(values) <= 1 && return values
    midpoint = length(values) ÷ 2
    left = merge_sort(values[1:midpoint])
    right = merge_sort(values[(midpoint + 1):end])
    return sort(vcat(left, right))
end

proof_tree = Tree("theorem", [
    Tree("lemma", [Tree("definition", Tree[]), Tree("case_analysis", Tree[])]),
    Tree("corollary", Tree[])
])

println("10! = ", factorial_recursive(10))
println("Fibonacci(40) = ", fibonacci_memo(40))
println("Tree size = ", tree_size(proof_tree))
println("Tree depth = ", tree_depth(proof_tree))
println("Sorted values = ", merge_sort([5, 2, 8, 1, 3, 7]))
println("Interpretation: recursion turns base cases and reduction rules into executable structure.")
