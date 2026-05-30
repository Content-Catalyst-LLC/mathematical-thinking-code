.PHONY: python r sql haskell cpp c clean

python:
	python3 python/unity_workflow.py
	python3 python/responsible_generalization_audit.py

r:
	Rscript r/unity_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/historical_development_unity.sqlite < sql/schema.sql
	sqlite3 outputs/tables/historical_development_unity.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/mathematical_idea_index.c -o c/mathematical_idea_index
	./c/mathematical_idea_index > outputs/tables/c_mathematical_idea_index.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/cross_field_counts c/mathematical_idea_index
	$(MAKE) -C haskell clean || true
