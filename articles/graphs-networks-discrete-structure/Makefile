.PHONY: python r sql haskell cpp c clean

python:
	python3 python/graph_network_workflow.py
	python3 python/network_interpretation_audit.py

r:
	Rscript r/adjacency_centrality_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/graphs_networks.sqlite < sql/schema.sql
	sqlite3 outputs/tables/graphs_networks.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/graph_utils.c -o c/graph_utils
	./c/graph_utils > outputs/tables/c_graph_utils.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/graph_audit c/graph_utils
	$(MAKE) -C haskell clean || true
