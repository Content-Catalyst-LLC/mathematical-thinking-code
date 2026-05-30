# Represent-relate-test-revise demo for:
# "Mathematical Thinking and Scientific Modeling"

records = [
    ("predator-prey model", "mechanistic", "understanding", "interacting ecological populations"),
    ("epidemic transmission model", "simulation", "decision_support", "disease spread in a population"),
    ("climate scenario model", "hybrid", "scenario_analysis", "coupled Earth system and forcing pathways"),
    ("infrastructure resilience model", "systems", "decision_support", "interdependent infrastructure networks"),
    ("AI surrogate simulation model", "machine_learning_hybrid", "prediction", "expensive simulation emulator")
]

println("Represent-relate-test-revise scientific modeling records")
for item in records
    println((model=item[1], model_type=item[2], purpose=item[3], target=item[4]))
end

println("\nInterpretation: scientific modeling is iterative: represent the system, relate variables, test against evidence, and revise under uncertainty.")
