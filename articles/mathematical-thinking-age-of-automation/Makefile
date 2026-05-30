.PHONY: python r sql haskell cpp c clean

python:
	python3 python/automation_workflow.py
	python3 python/responsible_automation_audit.py

r:
	Rscript r/automation_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/mathematical_thinking_automation.sqlite < sql/schema.sql
	sqlite3 outputs/tables/mathematical_thinking_automation.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/automation_task_index.c -o c/automation_task_index
	./c/automation_task_index > outputs/tables/c_automation_task_index.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/evidence_standard_counts c/automation_task_index
	$(MAKE) -C haskell clean || true
