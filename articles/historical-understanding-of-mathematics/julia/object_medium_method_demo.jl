# Object-medium-method-meaning demo for:
# "The Historical Understanding of Mathematics"

practices = [
    ("scribal calculation", "quantity", "tablet/table", "procedure", "administrative reliability"),
    ("Euclidean geometry", "space and relation", "diagram/proposition", "demonstration", "necessity under assumptions"),
    ("symbolic algebra", "unknowns and equations", "notation", "symbolic transformation", "general form"),
    ("mathematical modeling", "formal structure", "equation/graph/matrix", "interpretation and validation", "target-system representation"),
    ("proof assistant formalization", "formal theorem", "proof script/library", "machine check", "verified infrastructure")
]

println("Object-medium-method-meaning examples")
for item in practices
    println((practice=item[1], object=item[2], medium=item[3], method=item[4], meaning=item[5]))
end

println("\nInterpretation: historical understanding asks what is being studied, how it is represented, how reasoning proceeds, and what the practice means in context.")
