# Termination and recurrence demo for:
# "Algorithms, Proof, and Formal Reasoning"

function binary_search(values, target)
    low = firstindex(values)
    high = lastindex(values)
    trace = []

    while low <= high
        interval_length = high - low + 1
        mid = low + (high - low) ÷ 2
        push!(trace, (low=low, high=high, mid=mid, interval_length=interval_length))

        if values[mid] == target
            return mid, trace
        elseif values[mid] < target
            low = mid + 1
        else
            high = mid - 1
        end
    end

    return nothing, trace
end

function merge_sort_cost(n)
    n <= 1 && return 1
    return 2 * merge_sort_cost(n ÷ 2) + n
end

function insertion_sort(values)
    result = copy(values)
    for i in 2:length(result)
        key = result[i]
        j = i - 1
        while j >= 1 && result[j] > key
            result[j + 1] = result[j]
            j -= 1
        end
        result[j + 1] = key
    end
    return result
end

values = [1, 2, 3, 5, 8, 13, 21]
index, trace = binary_search(values, 13)

println("Binary search index: ", index)
println("Trace: ", trace)

println("Insertion sort: ", insertion_sort([5, 2, 8, 1, 3, 2]))

println("Merge-sort recurrence costs:")
for n in [1, 2, 4, 8, 16, 32, 64, 128]
    println((n=n, cost=merge_sort_cost(n)))
end

println("Interpretation: formal reasoning documents invariants, termination measures, and complexity costs.")
