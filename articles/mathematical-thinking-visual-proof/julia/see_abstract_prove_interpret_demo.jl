# See-abstract-prove-interpret demo for:
# "Mathematical Thinking and Visual Proof"

records = [
    ("sum of odd numbers as square layers", "combinatorics", "diagrammatic_argument", "informally_justified"),
    ("area model for binomial square", "algebra", "diagrammatic_argument", "informally_justified"),
    ("dynamic geometry invariant", "geometry", "heuristic", "needs_generalization"),
    ("graph drawing of connected network", "graph_theory", "evidence", "needs_generalization"),
    ("derivative as limiting secant slope", "calculus", "heuristic", "needs_formal_limit")
]

println("See-abstract-prove-interpret visual proof records")
for item in records
    println((title=item[1], domain=item[2], role=item[3], proof_status=item[4]))
end

println("\nInterpretation: visual insight becomes mathematical proof through abstraction, generalization, and justification.")
