.PHONY: python r sql haskell cpp c clean

python:
	python3 python/reasoning_move_audit.py
	python3 python/ai_output_verification.py

r:
	Rscript r/reasoning_assessment_analysis.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/non_algorithmic_reasoning.sqlite < sql/schema.sql
	sqlite3 outputs/tables/non_algorithmic_reasoning.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/residual_audit.c -lm -o c/residual_audit
	./c/residual_audit > outputs/tables/c_residual_audit.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/procedure_verification c/residual_audit
	$(MAKE) -C haskell clean || true
