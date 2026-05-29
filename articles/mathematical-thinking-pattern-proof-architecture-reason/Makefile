.PHONY: python r sql cpp c clean

python:
	python3 python/sequence_recursion_analysis.py
	python3 python/proof_graph_analysis.py

r:
	Rscript r/sequence_pattern_analysis.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/mathematical_thinking.sqlite < sql/schema.sql
	sqlite3 outputs/tables/mathematical_thinking.sqlite < sql/analysis_queries.sql

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/sequence_graph_utils.c -o c/sequence_graph_utils
	./c/sequence_graph_utils > outputs/tables/c_sequence_residues.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/discrete_structures c/sequence_graph_utils
