# Proof style matrix demo for:
# "The Historical Development of Proof"

styles = [
    "procedural",
    "diagrammatic",
    "deductive",
    "algebraic",
    "analytic",
    "formal",
    "machine"
]

traditions = [
    "Mesopotamian",
    "Egyptian",
    "Greek",
    "Indian",
    "Chinese",
    "Islamic",
    "Modern analysis",
    "Foundations",
    "Computer proof"
]

# Synthetic teaching matrix: 1 means the style is central in this simplified model.
matrix = [
    1 0 0 0 0 0 0;
    1 1 0 0 0 0 0;
    0 1 1 0 0 0 0;
    1 0 0 1 1 0 0;
    1 1 0 0 0 0 0;
    1 1 1 1 0 0 0;
    0 0 0 0 1 0 0;
    0 0 1 0 1 1 0;
    0 0 0 0 0 1 1
]

println("Proof-style matrix")
for (i, tradition) in enumerate(traditions)
    active = [styles[j] for j in eachindex(styles) if matrix[i, j] == 1]
    println((tradition=tradition, styles=active))
end

println("Interpretation: this is a synthetic classification scaffold, not a historical ranking.")
