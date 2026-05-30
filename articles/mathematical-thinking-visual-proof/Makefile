.PHONY: python r sql haskell cpp c clean

python:
	python3 python/visual_proof_workflow.py
	python3 python/responsible_visual_argument_audit.py

r:
	Rscript r/visual_proof_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/mathematical_thinking_visual_proof.sqlite < sql/schema.sql
	sqlite3 outputs/tables/mathematical_thinking_visual_proof.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/visual_proof_index.c -o c/visual_proof_index
	./c/visual_proof_index > outputs/tables/c_visual_proof_index.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/visual_status_counts c/visual_proof_index
	$(MAKE) -C haskell clean || true
