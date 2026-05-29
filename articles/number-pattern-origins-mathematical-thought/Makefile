.PHONY: python r sql haskell cpp c clean

python:
	python3 python/number_pattern_workflow.py
	python3 python/pattern_interpretation_audit.py

r:
	Rscript r/sequence_pattern_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/number_pattern_origins.sqlite < sql/schema.sql
	sqlite3 outputs/tables/number_pattern_origins.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/number_pattern_utils.c -o c/number_pattern_utils
	./c/number_pattern_utils > outputs/tables/c_number_pattern_utils.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/sequence_pattern c/number_pattern_utils
	$(MAKE) -C haskell clean || true
