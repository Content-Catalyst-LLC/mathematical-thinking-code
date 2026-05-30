# Define-measure-contextualize-govern demo for:
# "Mathematical Thinking and the Ethics of Quantification"

records = [
    ("student test score", "proxy", "learning", "high_stakes"),
    ("research citation count", "indicator", "research influence or attention", "moderate_stakes"),
    ("AI benchmark score", "benchmark", "model capability or reliability", "high_stakes"),
    ("composite sustainability score", "score", "sustainability performance", "high_stakes"),
    ("credit risk score", "risk_score", "loan repayment risk", "high_stakes")
]

println("Define-measure-contextualize-govern metric records")
for item in records
    println((metric=item[1], metric_type=item[2], target=item[3], consequence=item[4]))
end

println("\nInterpretation: ethical quantification defines the concept, measures with care, contextualizes uncertainty, and governs use.")
