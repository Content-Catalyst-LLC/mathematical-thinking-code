.PHONY: python r sql haskell cpp c clean

python:
	python3 python/conjecture_evidence_workflow.py
	python3 python/graph_invariant_discovery.py

r:
	Rscript r/conjecture_finite_evidence_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/conjecture_discovery.sqlite < sql/schema.sql
	sqlite3 outputs/tables/conjecture_discovery.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/counterexample_search.c -o c/counterexample_search
	./c/counterexample_search > outputs/tables/c_counterexample_search.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/conjecture_discovery c/counterexample_search
	$(MAKE) -C haskell clean || true
