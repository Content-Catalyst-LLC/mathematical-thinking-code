.PHONY: python r sql haskell cpp c clean

python:
	python3 python/geometric_reasoning_workflow.py
	python3 python/transformation_diagram_audit.py

r:
	Rscript r/coordinate_transformation_audit.R

sql:
	mkdir -p outputs/tables
	sqlite3 outputs/tables/geometry_visual_mind.sqlite < sql/schema.sql
	sqlite3 outputs/tables/geometry_visual_mind.sqlite < sql/analysis_queries.sql

haskell:
	$(MAKE) -C haskell run

cpp:
	$(MAKE) -C cpp run

c:
	cc -std=c11 c/geometry_utils.c -lm -o c/geometry_utils
	./c/geometry_utils > outputs/tables/c_geometry_utils.csv

clean:
	rm -f outputs/tables/*.csv outputs/tables/*.sqlite outputs/figures/*.dot
	rm -f cpp/geometry_primitives c/geometry_utils
	$(MAKE) -C haskell clean || true
