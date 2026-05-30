.PHONY: python r sql haskell cpp c clean

python:
	python3 python/foundations_structure_workflow.py
	python3 python/responsible_abstraction_audit.py

r:
	Rscript r/foundation_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/foundations_structure_reimagining.sqlite < sql/schema.sql
	sqlite3 outputs/tables/foundations_structure_reimagining.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/foundation_structure_counts.c -o c/foundation_structure_counts
	./c/foundation_structure_counts > outputs/tables/c_foundation_structure_counts.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/structure_counts c/foundation_structure_counts
	$(MAKE) -C haskell clean || true
