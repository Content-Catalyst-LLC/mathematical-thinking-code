#!/usr/bin/env Rscript

# Historiography summary for:
# "The Historical Understanding of Mathematics"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

practices <- read.csv(file.path(data_dir, "historical_practices.csv"), stringsAsFactors = FALSE)
risks <- read.csv(file.path(data_dir, "historiographic_risks.csv"), stringsAsFactors = FALSE)
notation <- read.csv(file.path(data_dir, "notation_history.csv"), stringsAsFactors = FALSE)
transmission <- read.csv(file.path(data_dir, "mathematical_transmissions.csv"), stringsAsFactors = FALSE)

method_counts <- aggregate(
  practice_id ~ method,
  data = practices,
  FUN = length
)
names(method_counts)[2] <- "practice_count"
method_counts$interpretation <- "method counts support scaffold coverage, not historical ranking"

risk_summary <- data.frame(
  risk = risks$risk_name,
  problem = risks$problem,
  mitigation = risks$mitigation,
  interpretation = "historiographic risks should be made explicit in mathematical-history work"
)

notation_summary <- data.frame(
  notation_or_medium = notation$notation_or_medium,
  mathematical_function = notation$mathematical_function,
  historical_effect = notation$historical_effect,
  warning = notation$anachronism_warning,
  interpretation = "notation is historical infrastructure, not neutral decoration"
)

transmission_summary <- data.frame(
  source_context = transmission$source_context,
  target_context = transmission$target_context,
  preserved_content = transmission$preserved_content,
  transformed_content = transmission$transformed_content,
  interpretation = "transmission preserves and transforms mathematical knowledge"
)

write.csv(method_counts, file.path(out_dir, "r_method_counts.csv"), row.names = FALSE)
write.csv(risk_summary, file.path(out_dir, "r_historiographic_risk_summary.csv"), row.names = FALSE)
write.csv(notation_summary, file.path(out_dir, "r_notation_summary.csv"), row.names = FALSE)
write.csv(transmission_summary, file.path(out_dir, "r_transmission_summary.csv"), row.names = FALSE)

cat("Historiography R summaries written.\n")
