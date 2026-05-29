.PHONY: python r sql haskell cpp c clean

python:
	python3 python/set_relation_function_workflow.py
	python3 python/mapping_validation_audit.py

r:
	Rscript r/relation_matrix_equivalence_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/sets_relations_functions.sqlite < sql/schema.sql
	sqlite3 outputs/tables/sets_relations_functions.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/set_relation_utils.c -o c/set_relation_utils
	./c/set_relation_utils > outputs/tables/c_set_relation_utils.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/relation_function_audit c/set_relation_utils
	$(MAKE) -C haskell clean || true
