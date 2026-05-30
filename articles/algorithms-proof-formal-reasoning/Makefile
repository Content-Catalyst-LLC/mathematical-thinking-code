.PHONY: python r sql haskell cpp c clean

python:
	python3 python/formal_reasoning_workflow.py
	python3 python/responsible_formal_reasoning_audit.py

r:
	Rscript r/proof_complexity_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/algorithms_proof_formal_reasoning.sqlite < sql/schema.sql
	sqlite3 outputs/tables/algorithms_proof_formal_reasoning.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/formal_reasoning_utils.c -o c/formal_reasoning_utils
	./c/formal_reasoning_utils > outputs/tables/c_formal_reasoning_utils.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/algorithm_proof_audit c/formal_reasoning_utils
	$(MAKE) -C haskell clean || true
