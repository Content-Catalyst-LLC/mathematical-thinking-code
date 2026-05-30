.PHONY: python r sql haskell cpp c clean

python:
	python3 python/quantification_ethics_workflow.py
	python3 python/responsible_quantification_audit.py

r:
	Rscript r/quantification_ethics_summary.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/mathematical_thinking_ethics_quantification.sqlite < sql/schema.sql
	sqlite3 outputs/tables/mathematical_thinking_ethics_quantification.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/metric_record_index.c -o c/metric_record_index
	./c/metric_record_index > outputs/tables/c_metric_record_index.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/metric_type_counts c/metric_record_index
	$(MAKE) -C haskell clean || true
