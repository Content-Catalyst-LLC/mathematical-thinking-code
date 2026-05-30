# Proof-layer demo for:
# "Mathematical Thinking and Proof Assistants"

layers = [
    ("Define", "encode objects and structures", "bad definitions make proofs awkward"),
    ("State", "formalize the intended theorem", "formal statement misses informal meaning"),
    ("Prove", "construct derivation", "proof script becomes opaque"),
    ("Check", "verify formal derivation", "trust boundary misunderstood"),
    ("Interpret", "explain scope and significance", "formal correctness replaces explanation")
]

println("Define-state-prove-check-interpret workflow")
for item in layers
    println((stage=item[1], work=item[2], failure_mode=item[3]))
end

println("\nInterpretation: proof assistants check formal derivations, while humans remain responsible for meaning and use.")
