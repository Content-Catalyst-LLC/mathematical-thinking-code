#!/usr/bin/env Rscript

# Quantification ethics summary for:
# "Mathematical Thinking and the Ethics of Quantification"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

metrics <- read.csv(file.path(data_dir, "metric_records.csv"), stringsAsFactors = FALSE)
risks <- read.csv(file.path(data_dir, "metric_risks.csv"), stringsAsFactors = FALSE)
validity <- read.csv(file.path(data_dir, "validity_reviews.csv"), stringsAsFactors = FALSE)
governance <- read.csv(file.path(data_dir, "governance_checks.csv"), stringsAsFactors = FALSE)
uncertainty <- read.csv(file.path(data_dir, "uncertainty_reviews.csv"), stringsAsFactors = FALSE)

metric_summary <- data.frame(
  metric_name = metrics$metric_name,
  metric_type = metrics$metric_type,
  target_concept = metrics$target_concept,
  consequence_level = metrics$consequence_level,
  intended_use = metrics$intended_use,
  invalid_use_warning = metrics$invalid_use_warning,
  interpretation = "a metric should be interpreted by target concept, method, consequence level, and valid use"
)

risk_summary <- data.frame(
  metric_id = risks$metric_id,
  risk = risks$risk_name,
  problem = risks$problem,
  mitigation = risks$mitigation,
  interpretation = "metric risks require validity review, incentive review, uncertainty review, and governance controls"
)

validity_summary <- data.frame(
  metric_id = validity$metric_id,
  construct_validity_note = validity$construct_validity_note,
  uncertainty_note = validity$uncertainty_note,
  subgroup_review_note = validity$subgroup_review_note,
  context_note = validity$context_note,
  interpretation = "validity review connects target concept, proxy, uncertainty, subgroup effects, and context"
)

governance_summary <- data.frame(
  metric_id = governance$metric_id,
  documentation_available = governance$documentation_available,
  contestability_mechanism = governance$contestability_mechanism,
  audit_frequency = governance$audit_frequency,
  invalid_use_warning = governance$invalid_use_warning,
  interpretation = "accountable metrics need documentation, contestability, audit cadence, and invalid-use warnings"
)

uncertainty_summary <- data.frame(
  metric_id = uncertainty$metric_id,
  uncertainty_source = uncertainty$uncertainty_source,
  description = uncertainty$description,
  communication_method = uncertainty$communication_method,
  interpretation = "uncertainty should be communicated as part of the metric rather than as an afterthought"
)

write.csv(metric_summary, file.path(out_dir, "r_metric_summary.csv"), row.names = FALSE)
write.csv(risk_summary, file.path(out_dir, "r_metric_risk_summary.csv"), row.names = FALSE)
write.csv(validity_summary, file.path(out_dir, "r_validity_summary.csv"), row.names = FALSE)
write.csv(governance_summary, file.path(out_dir, "r_governance_summary.csv"), row.names = FALSE)
write.csv(uncertainty_summary, file.path(out_dir, "r_uncertainty_summary.csv"), row.names = FALSE)

cat("Quantification ethics R summaries written.\n")
