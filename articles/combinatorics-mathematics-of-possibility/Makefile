.PHONY: python r sql haskell cpp c clean

python:
	python3 python/combinatorics_workflow.py
	python3 python/possibility_interpretation_audit.py

r:
	Rscript r/binomial_possibility_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/combinatorics_possibility.sqlite < sql/schema.sql
	sqlite3 outputs/tables/combinatorics_possibility.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/combinatorics_utils.c -o c/combinatorics_utils
	./c/combinatorics_utils > outputs/tables/c_combinatorics_utils.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/combinatorics_audit c/combinatorics_utils
	$(MAKE) -C haskell clean || true
