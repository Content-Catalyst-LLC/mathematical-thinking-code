# Transformation and invariance demo for:
# "Historical Development and the Unity of Mathematical Ideas"

ideas = [
    ("proportion", "geometry", "scaling", "same relative relation"),
    ("derivative", "calculus", "differentiation", "local linear behavior"),
    ("group", "algebra", "homomorphism", "operation structure"),
    ("graph", "discrete mathematics", "graph morphism", "adjacency pattern"),
    ("proof", "logic", "formal derivation", "derivability under rules"),
    ("algorithm", "computation", "execution", "specified input-output behavior")
]

println("Idea / transformation / invariant catalog")
for item in ideas
    println((idea=item[1], field=item[2], transformation=item[3], invariant=item[4]))
end

println("\nDiscrete-continuous bridge example")
for n in [4, 8, 16, 32, 64]
    approximation = sum((1 / n) for _ in 1:n)
    println((partitions=n, unit_interval_sum=approximation))
end

println("\nInterpretation: unity comes from what transformations preserve, not from treating all contexts as identical.")
