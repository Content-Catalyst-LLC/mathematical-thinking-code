.PHONY: python r sql haskell cpp c clean

python:
	python3 python/notation_history_workflow.py
	python3 python/symbolic_expression_audit.py

r:
	Rscript r/notation_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/evolution_of_algebraic_notation.sqlite < sql/schema.sql
	sqlite3 outputs/tables/evolution_of_algebraic_notation.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/notation_tokens.c -o c/notation_tokens
	./c/notation_tokens > outputs/tables/c_notation_tokens.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/expression_tree_demo c/notation_tokens
	$(MAKE) -C haskell clean || true
