.PHONY: python r sql haskell cpp c clean

python:
	python3 python/category_abstraction_workflow.py
	python3 python/responsible_abstraction_audit.py

r:
	Rscript r/category_abstraction_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/mathematical_thinking_category_abstraction.sqlite < sql/schema.sql
	sqlite3 outputs/tables/mathematical_thinking_category_abstraction.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/category_record_index.c -o c/category_record_index
	./c/category_record_index > outputs/tables/c_category_record_index.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/category_structure_counts c/category_record_index
	$(MAKE) -C haskell clean || true
