# Non-Algorithmic Reasoning and the Future of Mathematics Learning

This companion folder supports the article **“Non-Algorithmic Reasoning and the Future of Mathematics Learning.”** It provides a reproducible mathematical-thinking scaffold for reasoning moves, strategy selection, representation choice, proof judgment, metacognitive self-monitoring, assessment metadata, misconception diagnosis, AI-output verification, and tool-assisted mathematics learning.

The folder is designed for serious mathematical, educational, and computational use: mathematics education research, proof-literacy design, AI-assisted learning audit trails, reasoning assessment, concept inventories, representation-choice analysis, strategy classification, and reproducible documentation of mathematical thinking beyond answer checking.

## Folder structure

```text
articles/non-algorithmic-reasoning-future-mathematics-learning/
python/   reasoning-move audits, strategy selection, assessment scoring, AI-output verification
r/        rubric analysis, reasoning-dimension scoring, and student-work audit examples
julia/    procedure-versus-verification examples and strategy-testing demonstrations
sql/      reasoning move, task, assessment, misconception, AI-output, and solution-audit schemas
haskell/  algebraic data types for reasoning stages, strategy, solution audits, and proof-status judgment
rust/     command-line reasoning-audit utility scaffold
go/       task and reasoning metadata analysis scaffold
cpp/      efficient verification and plausibility-check examples
fortran/  numerical procedure and verification examples
c/        low-level solution-check and residual-audit utilities
docs/     pedagogy notes, AI verification notes, assessment notes, validation plan
data/     synthetic mathematics-learning and reasoning datasets
outputs/  generated tables and audit artifacts
```

## Mathematical themes

- non-algorithmic reasoning as mathematical judgment
- problem framing before problem solving
- representation choice as reasoning
- proof as justification rather than template
- metacognition and strategy monitoring
- procedural fluency joined to conceptual understanding
- assessment beyond answer correctness
- AI-output verification and responsible mathematics learning
- Haskell algebraic data types for reasoning structures

## Suggested run order

From this article folder:

```bash
python3 python/reasoning_move_audit.py
python3 python/ai_output_verification.py

Rscript r/reasoning_assessment_analysis.R

julia julia/procedure_verification_demo.jl

sqlite3 outputs/tables/non_algorithmic_reasoning.sqlite < sql/schema.sql
sqlite3 outputs/tables/non_algorithmic_reasoning.sqlite < sql/analysis_queries.sql

cd haskell && make run
cd ../rust && cargo run -- ../data/raw/reasoning_moves.csv
cd ../go && go run .
cd ../cpp && make run
cd ../fortran && gfortran procedure_verification.f90 -o procedure_verification && ./procedure_verification
cd ../c && cc -std=c11 residual_audit.c -o residual_audit && ./residual_audit
```

## Interpretation

The generated outputs make reasoning processes visible: problem framing, representation choice, assumption checking, justification, reflection, and AI-output verification. They do not replace teaching judgment, mathematical expertise, peer review, or student-centered interpretation.
