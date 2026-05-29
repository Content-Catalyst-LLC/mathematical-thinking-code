.PHONY: python r sql haskell cpp c clean

python:
	python3 python/symbolic_expression_workflow.py
	python3 python/representation_translation_audit.py

r:
	Rscript r/function_representation_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/representation_metadata.sqlite < sql/schema.sql
	sqlite3 outputs/tables/representation_metadata.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/representation_utils.c -o c/representation_utils
	./c/representation_utils > outputs/tables/c_adjacency_matrix.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/expression_representation c/representation_utils
	$(MAKE) -C haskell clean || true
