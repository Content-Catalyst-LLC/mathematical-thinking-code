#!/usr/bin/env Rscript

# Reasoning assessment analysis for:
# "Non-Algorithmic Reasoning and the Future of Mathematics Learning"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

audits <- read.csv(file.path(data_dir, "student_solution_audits.csv"), stringsAsFactors = FALSE)

score_cols <- c(
  "framing_score",
  "representation_score",
  "strategy_score",
  "assumption_score",
  "justification_score",
  "reflection_score"
)

audits$total_score <- rowSums(audits[, score_cols])
audits$max_score <- 18
audits$reasoning_profile <- ifelse(
  audits$total_score >= 15,
  "strong non-algorithmic reasoning",
  ifelse(audits$total_score >= 9, "partial reasoning visible", "primarily procedural or incomplete")
)

dimension_summary <- data.frame(
  dimension = score_cols,
  mean_score = sapply(score_cols, function(col) mean(audits[[col]])),
  min_score = sapply(score_cols, function(col) min(audits[[col]])),
  max_score = sapply(score_cols, function(col) max(audits[[col]]))
)

task_summary <- aggregate(
  total_score ~ task_id,
  data = audits,
  FUN = mean
)
names(task_summary)[names(task_summary) == "total_score"] <- "mean_total_score"

write.csv(audits, file.path(out_dir, "r_student_reasoning_scores.csv"), row.names = FALSE)
write.csv(dimension_summary, file.path(out_dir, "r_dimension_summary.csv"), row.names = FALSE)
write.csv(task_summary, file.path(out_dir, "r_task_reasoning_summary.csv"), row.names = FALSE)

cat("Reasoning assessment analysis complete.\n")
cat("Mean total score:", mean(audits$total_score), "\n")
