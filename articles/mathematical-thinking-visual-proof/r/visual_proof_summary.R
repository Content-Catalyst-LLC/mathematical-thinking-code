#!/usr/bin/env Rscript

# Visual proof summary for:
# "Mathematical Thinking and Visual Proof"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

records <- read.csv(file.path(data_dir, "visual_proof_records.csv"), stringsAsFactors = FALSE)
risks <- read.csv(file.path(data_dir, "visual_risks.csv"), stringsAsFactors = FALSE)
accessibility <- read.csv(file.path(data_dir, "accessibility_reviews.csv"), stringsAsFactors = FALSE)
relations <- read.csv(file.path(data_dir, "diagram_relations.csv"), stringsAsFactors = FALSE)

role_counts <- aggregate(record_id ~ visual_role, data = records, FUN = length)
names(role_counts)[2] <- "record_count"
role_counts$interpretation <- "visual role distinguishes illustration, evidence, heuristic, argument, and formal diagrammatic proof"

risk_summary <- data.frame(
  risk = risks$risk_name,
  problem = risks$problem,
  mitigation = risks$mitigation,
  interpretation = "visual risks require explicit review before visual authority is trusted"
)

accessibility_summary <- data.frame(
  record_id = accessibility$record_id,
  visual_dependency = accessibility$visual_dependency,
  alternative_description = accessibility$alternative_description,
  accessibility_note = accessibility$accessibility_note,
  interpretation = "visual proof should be accessible through structural description and nonvisual equivalents"
)

relation_summary <- data.frame(
  record_id = relations$record_id,
  visual_feature = relations$visual_feature,
  mathematical_relation = relations$mathematical_relation,
  proof_requirement = relations$proof_requirement,
  interpretation = "visual features need explicit mathematical relations and proof requirements"
)

write.csv(role_counts, file.path(out_dir, "r_visual_role_counts.csv"), row.names = FALSE)
write.csv(risk_summary, file.path(out_dir, "r_visual_risk_summary.csv"), row.names = FALSE)
write.csv(accessibility_summary, file.path(out_dir, "r_accessibility_summary.csv"), row.names = FALSE)
write.csv(relation_summary, file.path(out_dir, "r_diagram_relation_summary.csv"), row.names = FALSE)

cat("Visual proof R summaries written.\n")
