.PHONY: python r sql haskell cpp c clean

python:
	python3 python/computer_science_foundations_workflow.py
	python3 python/responsible_computing_audit.py

r:
	Rscript r/complexity_probability_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/mathematical_thinking_computer_science.sqlite < sql/schema.sql
	sqlite3 outputs/tables/mathematical_thinking_computer_science.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/cs_utils.c -o c/cs_utils
	./c/cs_utils > outputs/tables/c_cs_utils.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/cs_math_audit c/cs_utils
	$(MAKE) -C haskell clean || true
