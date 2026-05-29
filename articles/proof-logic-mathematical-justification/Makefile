.PHONY: python r sql cpp c clean

python:
	python3 python/proof_dependency_analysis.py
	python3 python/induction_counterexample_audit.py

r:
	Rscript r/proof_status_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/proof_logic.sqlite < sql/schema.sql
	sqlite3 outputs/tables/proof_logic.sqlite < sql/analysis_queries.sql

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/proof_audit.c -o c/proof_audit
	./c/proof_audit > outputs/tables/c_proof_audit.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/proof_graph_induction c/proof_audit

haskell:
	$(MAKE) -C haskell run

