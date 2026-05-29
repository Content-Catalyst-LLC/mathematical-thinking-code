.PHONY: python r sql cpp c clean

python:
	python3 python/equivalence_invariant_analysis.py
	python3 python/generalization_counterexample_workflow.py

r:
	Rscript r/generalization_testing.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/abstraction_generalization.sqlite < sql/schema.sql
	sqlite3 outputs/tables/abstraction_generalization.sqlite < sql/analysis_queries.sql

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/equivalence_invariants.c -o c/equivalence_invariants
	./c/equivalence_invariants > outputs/tables/c_fraction_normalization.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/abstraction_invariants c/equivalence_invariants
