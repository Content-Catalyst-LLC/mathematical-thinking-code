.PHONY: python r sql cpp c clean

python:
	python3 python/pattern_classification_workflow.py
	python3 python/graph_dynamic_probability_workflow.py

r:
	Rscript r/pattern_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/mathematics_science_patterns.sqlite < sql/schema.sql
	sqlite3 outputs/tables/mathematics_science_patterns.sqlite < sql/analysis_queries.sql

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/sequence_pattern_features.c -o c/sequence_pattern_features
	./c/sequence_pattern_features > outputs/tables/c_sequence_pattern_features.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/pattern_invariants c/sequence_pattern_features

haskell:
	$(MAKE) -C haskell run

