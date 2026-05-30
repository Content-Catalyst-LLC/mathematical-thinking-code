#!/usr/bin/env Rscript

# AI-assisted discovery summary for:
# "Mathematical Thinking and AI-Assisted Discovery"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

candidates <- read.csv(file.path(data_dir, "discovery_candidates.csv"), stringsAsFactors = FALSE)
risks <- read.csv(file.path(data_dir, "discovery_risks.csv"), stringsAsFactors = FALSE)
verification <- read.csv(file.path(data_dir, "verification_records.csv"), stringsAsFactors = FALSE)
interpretation <- read.csv(file.path(data_dir, "human_interpretation_records.csv"), stringsAsFactors = FALSE)

candidate_status <- aggregate(
  candidate_id ~ current_status,
  data = candidates,
  FUN = length
)
names(candidate_status)[2] <- "candidate_count"
candidate_status$interpretation <- "candidate status is workflow evidence, not mathematical authority"

risk_summary <- data.frame(
  risk = risks$risk_name,
  mathematical_problem = risks$mathematical_problem,
  mitigation = risks$mitigation,
  interpretation = "AI-assisted discovery risks should be documented and mitigated"
)

verification_summary <- data.frame(
  candidate_id = verification$candidate_id,
  verification_method = verification$verification_method,
  evidence_standard = verification$evidence_standard,
  remaining_question = verification$remaining_question,
  interpretation = "different AI-generated outputs require different evidence standards"
)

interpretation_summary <- data.frame(
  candidate_id = interpretation$candidate_id,
  novelty_review = interpretation$novelty_review,
  significance_review = interpretation$significance_review,
  proof_status = interpretation$proof_status,
  interpretation = "human review preserves novelty, significance, proof status, and credit"
)

write.csv(candidate_status, file.path(out_dir, "r_candidate_status_summary.csv"), row.names = FALSE)
write.csv(risk_summary, file.path(out_dir, "r_discovery_risk_summary.csv"), row.names = FALSE)
write.csv(verification_summary, file.path(out_dir, "r_verification_summary.csv"), row.names = FALSE)
write.csv(interpretation_summary, file.path(out_dir, "r_human_interpretation_summary.csv"), row.names = FALSE)

cat("AI-assisted discovery R summaries written.\n")
