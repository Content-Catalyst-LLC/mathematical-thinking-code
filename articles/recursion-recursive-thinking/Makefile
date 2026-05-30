.PHONY: python r sql haskell cpp c clean

python:
	python3 python/recursive_structure_workflow.py
	python3 python/recursive_model_audit.py

r:
	Rscript r/recurrence_growth_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/recursion_recursive_thinking.sqlite < sql/schema.sql
	sqlite3 outputs/tables/recursion_recursive_thinking.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/recursion_utils.c -o c/recursion_utils
	./c/recursion_utils > outputs/tables/c_recursion_utils.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/recursion_audit c/recursion_utils
	$(MAKE) -C haskell clean || true
