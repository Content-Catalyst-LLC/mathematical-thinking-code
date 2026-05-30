.PHONY: python r sql haskell cpp c clean

python:
	python3 python/proof_assistant_workflow.py
	python3 python/responsible_verification_audit.py

r:
	Rscript r/proof_assistant_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/mathematical_thinking_proof_assistants.sqlite < sql/schema.sql
	sqlite3 outputs/tables/mathematical_thinking_proof_assistants.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/formalization_index.c -o c/formalization_index
	./c/formalization_index > outputs/tables/c_formalization_index.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/proof_boundary_counts c/formalization_index
	$(MAKE) -C haskell clean || true
