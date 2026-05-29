.PHONY: python r sql cpp c clean

python:
	python3 python/truth_table_inference.py
	python3 python/derivation_graph_analysis.py

r:
	Rscript r/quantifier_counterexample_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/formal_inference.sqlite < sql/schema.sql
	sqlite3 outputs/tables/formal_inference.sqlite < sql/analysis_queries.sql

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/logic_connectives.c -o c/logic_connectives
	./c/logic_connectives > outputs/tables/c_logic_connectives.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/formal_inference c/logic_connectives

haskell:
	$(MAKE) -C haskell run

