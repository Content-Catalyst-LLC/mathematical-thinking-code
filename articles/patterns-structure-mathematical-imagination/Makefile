.PHONY: python r sql cpp c clean

python:
	python3 python/pattern_structure_invariant_analysis.py
	python3 python/graph_invariant_workflow.py

r:
	Rscript r/pattern_feature_analysis.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/pattern_structure.sqlite < sql/schema.sql
	sqlite3 outputs/tables/pattern_structure.sqlite < sql/analysis_queries.sql

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/graph_sequence_features.c -o c/graph_sequence_features
	./c/graph_sequence_features > outputs/tables/c_graph_sequence_features.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/graph_invariants c/graph_sequence_features
