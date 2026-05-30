.PHONY: python r sql haskell cpp c clean

python:
	python3 python/history_workflow.py
	python3 python/historiographic_audit.py

r:
	Rscript r/history_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/history_of_mathematical_thinking.sqlite < sql/schema.sql
	sqlite3 outputs/tables/history_of_mathematical_thinking.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/thinking_mode_counts.c -o c/thinking_mode_counts
	./c/thinking_mode_counts > outputs/tables/c_thinking_mode_counts.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/thinking_mode_counts c/thinking_mode_counts
	$(MAKE) -C haskell clean || true
