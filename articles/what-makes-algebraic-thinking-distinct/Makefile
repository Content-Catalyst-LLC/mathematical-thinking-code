.PHONY: python r sql haskell cpp c clean

python:
	python3 python/algebraic_expression_workflow.py
	python3 python/equivalence_equation_audit.py

r:
	Rscript r/algebraic_equivalence_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/algebraic_thinking.sqlite < sql/schema.sql
	sqlite3 outputs/tables/algebraic_thinking.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/residual_audit.c -lm -o c/residual_audit
	./c/residual_audit > outputs/tables/c_residual_audit.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/algebraic_expression c/residual_audit
	$(MAKE) -C haskell clean || true
