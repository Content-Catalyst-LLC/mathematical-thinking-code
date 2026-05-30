#!/usr/bin/env Rscript

# Foundation summary for:
# "Foundations, Structure, and the Reimagining of Mathematics"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

views <- read.csv(file.path(data_dir, "foundation_views.csv"), stringsAsFactors = FALSE)
structures <- read.csv(file.path(data_dir, "mathematical_structures.csv"), stringsAsFactors = FALSE)
warnings <- read.csv(file.path(data_dir, "abstraction_warnings.csv"), stringsAsFactors = FALSE)

foundation_summary <- data.frame(
  view = views$name,
  central_question = views$central_question,
  strength = views$mathematical_strength,
  limitation = views$limitation_note,
  interpretation = "foundation views clarify different aspects of mathematics but do not exhaust practice"
)

structure_summary <- data.frame(
  structure = structures$name,
  objects = structures$objects,
  operations = structures$relations_or_operations,
  preserved_by = structures$preserved_by,
  interpretation = "structures are studied by objects, operations, laws, and preservation maps"
)

warning_summary <- data.frame(
  topic = warnings$topic,
  warning = warnings$warning,
  mitigation = warnings$mitigation,
  interpretation = "responsible abstraction requires assumptions, access, interpretation, and consequence review"
)

write.csv(foundation_summary, file.path(out_dir, "r_foundation_summary.csv"), row.names = FALSE)
write.csv(structure_summary, file.path(out_dir, "r_structure_summary.csv"), row.names = FALSE)
write.csv(warning_summary, file.path(out_dir, "r_abstraction_warning_summary.csv"), row.names = FALSE)

cat("Foundation R summaries written.\n")
