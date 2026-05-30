# Objects-arrows-structure-universality demo for:
# "Mathematical Thinking and Category-Level Abstraction"

records = [
    ("Set", "sets", "functions", "element assignment"),
    ("Grp", "groups", "group homomorphisms", "group operation"),
    ("Top", "topological spaces", "continuous maps", "topological continuity"),
    ("Vect", "vector spaces", "linear maps", "linear structure"),
    ("Poset", "partially ordered sets", "monotone maps", "order relation")
]

println("Objects-arrows-structure records")
for item in records
    println((category=item[1], objects=item[2], morphisms=item[3], preserved_structure=item[4]))
end

println("\nInterpretation: category-level abstraction begins by identifying objects, arrows, preserved structure, and composition.")
