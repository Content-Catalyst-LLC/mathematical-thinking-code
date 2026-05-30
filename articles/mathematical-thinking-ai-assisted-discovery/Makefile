.PHONY: python r sql haskell cpp c clean

python:
	python3 python/ai_discovery_workflow.py
	python3 python/responsible_ai_discovery_audit.py

r:
	Rscript r/ai_discovery_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/mathematical_thinking_ai_discovery.sqlite < sql/schema.sql
	sqlite3 outputs/tables/mathematical_thinking_ai_discovery.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/discovery_candidate_index.c -o c/discovery_candidate_index
	./c/discovery_candidate_index > outputs/tables/c_discovery_candidate_index.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/candidate_status_counts c/discovery_candidate_index
	$(MAKE) -C haskell clean || true
