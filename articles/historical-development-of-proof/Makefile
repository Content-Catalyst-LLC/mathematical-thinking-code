.PHONY: python r sql haskell cpp c clean

python:
	python3 python/proof_history_workflow.py
	python3 python/historiography_audit.py

r:
	Rscript r/proof_history_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/historical_development_of_proof.sqlite < sql/schema.sql
	sqlite3 outputs/tables/historical_development_of_proof.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/proof_history_counts.c -o c/proof_history_counts
	./c/proof_history_counts > outputs/tables/c_proof_history_counts.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/proof_style_counts c/proof_history_counts
	$(MAKE) -C haskell clean || true
