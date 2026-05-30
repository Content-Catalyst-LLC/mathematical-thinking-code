# Generate-test-prove-interpret demo for:
# "Mathematical Thinking and AI-Assisted Discovery"

candidates = [
    ("possible graph invariant bound", "conjecture", "tested_on_examples", "needs proof or counterexample"),
    ("candidate combinatorial construction", "program", "tested_on_examples", "needs explanation and proof"),
    ("AI-generated proof outline", "proof_sketch", "untested", "needs line-by-line verification"),
    ("formalized lemma candidate", "formal_statement", "untested", "needs proof assistant workflow"),
    ("generated formal proof script", "formal_proof_script", "machine_check_required", "needs local proof assistant check")
]

println("Generate-test-prove-interpret discovery records")
for item in candidates
    println((title=item[1], output_type=item[2], status=item[3], next_review=item[4]))
end

println("\nInterpretation: AI-generated mathematical outputs remain candidates until tested, proved, and interpreted.")
