#!/usr/bin/env Rscript

# Scientific modeling summary for:
# "Mathematical Thinking and Scientific Modeling"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

models <- read.csv(file.path(data_dir, "scientific_model_records.csv"), stringsAsFactors = FALSE)
risks <- read.csv(file.path(data_dir, "model_risks.csv"), stringsAsFactors = FALSE)
validation <- read.csv(file.path(data_dir, "validation_records.csv"), stringsAsFactors = FALSE)
uncertainty <- read.csv(file.path(data_dir, "uncertainty_sources.csv"), stringsAsFactors = FALSE)

model_summary <- data.frame(
  model_name = models$model_name,
  model_type = models$model_type,
  purpose = models$purpose,
  target_system = models$target_system,
  intended_use = models$intended_use,
  scope_limit = models$scope_limit,
  interpretation = "a scientific model should be evaluated in relation to its purpose and validity domain"
)

risk_summary <- data.frame(
  risk = risks$risk_name,
  problem = risks$problem,
  mitigation = risks$mitigation,
  interpretation = "model risks require transparent assumptions, uncertainty, validation, and decision-support clarity"
)

validation_summary <- data.frame(
  model_id = validation$model_id,
  validation_type = validation$validation_type,
  evidence_used = validation$evidence_used,
  limitation = validation$limitation,
  credibility_note = validation$credibility_note,
  interpretation = "validation is purpose-specific and should state limitations"
)

uncertainty_summary <- data.frame(
  model_id = uncertainty$model_id,
  source_type = uncertainty$source_type,
  description = uncertainty$description,
  mitigation = uncertainty$mitigation,
  interpretation = "uncertainty sources should be identified and communicated separately"
)

write.csv(model_summary, file.path(out_dir, "r_model_summary.csv"), row.names = FALSE)
write.csv(risk_summary, file.path(out_dir, "r_model_risk_summary.csv"), row.names = FALSE)
write.csv(validation_summary, file.path(out_dir, "r_validation_summary.csv"), row.names = FALSE)
write.csv(uncertainty_summary, file.path(out_dir, "r_uncertainty_summary.csv"), row.names = FALSE)

cat("Scientific modeling R summaries written.\n")
