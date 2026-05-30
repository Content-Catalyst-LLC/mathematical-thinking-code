#!/usr/bin/env Rscript

# Automation summary for:
# "Mathematical Thinking in an Age of Automation"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

tools <- read.csv(file.path(data_dir, "automation_tools.csv"), stringsAsFactors = FALSE)
risks <- read.csv(file.path(data_dir, "automation_risks.csv"), stringsAsFactors = FALSE)
skills <- read.csv(file.path(data_dir, "human_judgment_skills.csv"), stringsAsFactors = FALSE)
verification <- read.csv(file.path(data_dir, "verification_records.csv"), stringsAsFactors = FALSE)

tool_literacy <- data.frame(
  tool = tools$tool_name,
  category = tools$tool_category,
  strength = tools$strength,
  human_review = tools$human_review,
  failure_mode = tools$failure_mode,
  interpretation = "tool literacy requires knowing strength, review requirement, and failure mode"
)

risk_summary <- data.frame(
  risk = risks$risk_name,
  mathematical_problem = risks$mathematical_problem,
  mitigation = risks$mitigation,
  interpretation = "automation risks require explicit mitigation and independent review"
)

skill_summary <- data.frame(
  skill = skills$skill_name,
  automation_context = skills$automation_context,
  why_it_matters = skills$why_it_matters,
  review_question = skills$review_question,
  interpretation = "human judgment becomes more important as automation expands"
)

verification_summary <- data.frame(
  task_id = verification$task_id,
  verification_method = verification$verification_method,
  evidence_standard = verification$evidence_standard,
  trust_boundary = verification$trust_boundary,
  interpretation = "each output type requires an appropriate evidence standard"
)

write.csv(tool_literacy, file.path(out_dir, "r_tool_literacy_summary.csv"), row.names = FALSE)
write.csv(risk_summary, file.path(out_dir, "r_automation_risk_summary.csv"), row.names = FALSE)
write.csv(skill_summary, file.path(out_dir, "r_human_judgment_skill_summary.csv"), row.names = FALSE)
write.csv(verification_summary, file.path(out_dir, "r_verification_summary.csv"), row.names = FALSE)

cat("Automation R summaries written.\n")
