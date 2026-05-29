# Structure-preserving maps for "Abstraction and the Power of Generalization"

struct ModElement
    value::Int
    modulus::Int
end

function normalize(x::ModElement)
    return mod(x.value, x.modulus)
end

function add_mod(a::ModElement, b::ModElement)
    a.modulus == b.modulus || error("Moduli must match.")
    return ModElement(a.value + b.value, a.modulus)
end

function mul_mod(a::ModElement, b::ModElement)
    a.modulus == b.modulus || error("Moduli must match.")
    return ModElement(a.value * b.value, a.modulus)
end

function preserves_addition(f, a::ModElement, b::ModElement)
    left = f(add_mod(a, b))
    right = add_mod(f(a), f(b))
    return normalize(left) == normalize(right)
end

function preserves_multiplication(f, a::ModElement, b::ModElement)
    left = f(mul_mod(a, b))
    right = mul_mod(f(a), f(b))
    return normalize(left) == normalize(right)
end

double_map(x::ModElement) = ModElement(2 * x.value, x.modulus)
square_map(x::ModElement) = ModElement(x.value * x.value, x.modulus)

function audit_map(name, f, modulus)
    println("\nMap: ", name, " on Z/", modulus, "Z")
    add_failures = 0
    mul_failures = 0

    for a in 0:(modulus - 1)
        for b in 0:(modulus - 1)
            x = ModElement(a, modulus)
            y = ModElement(b, modulus)
            if !preserves_addition(f, x, y)
                add_failures += 1
            end
            if !preserves_multiplication(f, x, y)
                mul_failures += 1
            end
        end
    end

    println("addition preservation failures: ", add_failures)
    println("multiplication preservation failures: ", mul_failures)
end

for modulus in [5, 7, 8]
    audit_map("double_map", double_map, modulus)
    audit_map("square_map", square_map, modulus)
end
