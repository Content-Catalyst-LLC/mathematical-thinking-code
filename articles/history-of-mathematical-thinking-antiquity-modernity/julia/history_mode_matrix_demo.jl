# Historical mode matrix demo for:
# "The History of Mathematical Thinking from Antiquity to Modernity"

periods = [
    "Antiquity",
    "Classical",
    "Classical-medieval",
    "Medieval",
    "Renaissance",
    "Early modern",
    "Nineteenth",
    "Twentieth",
    "Contemporary"
]

modes = [
    "procedural",
    "diagrammatic",
    "deductive",
    "algebraic",
    "analytic",
    "structural",
    "computational",
    "formal_verified"
]

# Synthetic teaching matrix: 1 marks centrality in this simplified scaffold.
matrix = [
    1 1 0 0 0 0 0 0;
    0 1 1 0 1 0 0 0;
    1 1 0 1 1 0 0 0;
    1 0 1 1 0 0 0 0;
    1 1 0 1 0 0 0 0;
    0 0 0 1 1 0 0 0;
    0 0 1 0 1 1 0 1;
    0 0 1 0 0 1 1 1;
    0 0 0 0 0 1 1 1
]

println("Historical mode matrix")
for (i, period) in enumerate(periods)
    active = [modes[j] for j in eachindex(modes) if matrix[i, j] == 1]
    println((period=period, modes=active))
end

println("\nStructural abstraction examples:")
structures = ["group", "vector space", "topological space", "graph", "category", "formal system"]
for structure in structures
    println((structure=structure, interpretation="objects, relations, operations, and laws"))
end

println("\nInterpretation: the matrix is a synthetic teaching scaffold, not a civilizational ranking or exhaustive historical account.")
