#!/usr/bin/env Rscript

# Unity summary for:
# "Historical Development and the Unity of Mathematical Ideas"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

ideas <- read.csv(file.path(data_dir, "mathematical_ideas.csv"), stringsAsFactors = FALSE)
connections <- read.csv(file.path(data_dir, "cross_field_connections.csv"), stringsAsFactors = FALSE)
warnings <- read.csv(file.path(data_dir, "responsible_generalization_warnings.csv"), stringsAsFactors = FALSE)

field_counts <- aggregate(
  idea_id ~ primary_field,
  data = ideas,
  FUN = length
)
names(field_counts)[2] <- "idea_count"
field_counts$interpretation <- "synthetic counts support coverage review, not field importance ranking"

connection_summary <- data.frame(
  source_idea = connections$source_idea,
  target_idea = connections$target_idea,
  connection_type = connections$connection_type,
  preserved_structure = connections$preserved_structure,
  caution = connections$caution_note,
  interpretation = "conceptual migration should not be treated as contextual sameness"
)

warning_summary <- data.frame(
  topic = warnings$topic,
  warning = warnings$warning,
  mitigation = warnings$mitigation,
  interpretation = "responsible mathematical unity requires checking preservation, omission, and context"
)

write.csv(field_counts, file.path(out_dir, "r_idea_field_counts.csv"), row.names = FALSE)
write.csv(connection_summary, file.path(out_dir, "r_cross_field_connection_summary.csv"), row.names = FALSE)
write.csv(warning_summary, file.path(out_dir, "r_responsible_generalization_warnings.csv"), row.names = FALSE)

cat("Unity R summaries written.\n")
