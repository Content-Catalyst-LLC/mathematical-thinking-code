.PHONY: python r sql haskell cpp c clean

python:
	python3 python/discrete_structure_workflow.py
	python3 python/algorithm_boolean_audit.py

r:
	Rscript r/combinatorics_graph_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/discrete_structure.sqlite < sql/schema.sql
	sqlite3 outputs/tables/discrete_structure.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/discrete_utils.c -o c/discrete_utils
	./c/discrete_utils > outputs/tables/c_discrete_utils.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/discrete_structure c/discrete_utils
	$(MAKE) -C haskell clean || true
