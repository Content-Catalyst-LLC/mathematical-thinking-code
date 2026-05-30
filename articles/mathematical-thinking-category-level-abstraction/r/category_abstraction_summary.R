#!/usr/bin/env Rscript

# Category abstraction summary for:
# "Mathematical Thinking and Category-Level Abstraction"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

categories <- read.csv(file.path(data_dir, "category_records.csv"), stringsAsFactors = FALSE)
functors <- read.csv(file.path(data_dir, "functor_records.csv"), stringsAsFactors = FALSE)
risks <- read.csv(file.path(data_dir, "abstraction_risks.csv"), stringsAsFactors = FALSE)
properties <- read.csv(file.path(data_dir, "universal_property_records.csv"), stringsAsFactors = FALSE)

category_summary <- data.frame(
  category = categories$category_name,
  objects = categories$objects,
  morphisms = categories$morphisms,
  preserved_structure = categories$preserved_structure,
  composition_rule = categories$composition_rule,
  interpretation = "chosen morphisms determine the visible structure of a category"
)

functor_summary <- data.frame(
  functor = functors$functor_name,
  source_category = functors$source_category,
  target_category = functors$target_category,
  preserved_property = functors$preserved_property,
  forgotten_or_added_structure = functors$forgotten_or_added_structure,
  interpretation = "functors preserve identity and composition while often forgetting or adding structure"
)

risk_summary <- data.frame(
  risk = risks$risk_name,
  problem = risks$problem,
  mitigation = risks$mitigation,
  interpretation = "category-level abstraction should remain grounded in examples and responsible interpretation"
)

universal_summary <- data.frame(
  construction = properties$construction_name,
  diagram_shape = properties$diagram_shape,
  universal_role = properties$universal_role,
  uniqueness_condition = properties$uniqueness_condition,
  interpretation = "universal properties define constructions by mapping role"
)

write.csv(category_summary, file.path(out_dir, "r_category_summary.csv"), row.names = FALSE)
write.csv(functor_summary, file.path(out_dir, "r_functor_summary.csv"), row.names = FALSE)
write.csv(risk_summary, file.path(out_dir, "r_abstraction_risk_summary.csv"), row.names = FALSE)
write.csv(universal_summary, file.path(out_dir, "r_universal_property_summary.csv"), row.names = FALSE)

cat("Category abstraction R summaries written.\n")
