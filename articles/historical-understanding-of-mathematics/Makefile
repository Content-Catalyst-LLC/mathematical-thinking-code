.PHONY: python r sql haskell cpp c clean

python:
	python3 python/historical_understanding_workflow.py
	python3 python/historiographic_responsibility_audit.py

r:
	Rscript r/historiography_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/historical_understanding.sqlite < sql/schema.sql
	sqlite3 outputs/tables/historical_understanding.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/historical_practice_index.c -o c/historical_practice_index
	./c/historical_practice_index > outputs/tables/c_historical_practice_index.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/proof_style_counts c/historical_practice_index
	$(MAKE) -C haskell clean || true
