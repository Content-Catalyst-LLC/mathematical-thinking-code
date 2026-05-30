.PHONY: python r sql haskell cpp c clean

python:
	python3 python/scientific_modeling_workflow.py
	python3 python/responsible_modeling_audit.py

r:
	Rscript r/scientific_modeling_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/mathematical_thinking_scientific_modeling.sqlite < sql/schema.sql
	sqlite3 outputs/tables/mathematical_thinking_scientific_modeling.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/scientific_model_index.c -o c/scientific_model_index
	./c/scientific_model_index > outputs/tables/c_scientific_model_index.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/model_type_counts c/scientific_model_index
	$(MAKE) -C haskell clean || true
