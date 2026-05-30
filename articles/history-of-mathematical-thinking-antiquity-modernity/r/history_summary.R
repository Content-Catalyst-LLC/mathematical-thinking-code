#!/usr/bin/env Rscript

# Historical summary for:
# "The History of Mathematical Thinking from Antiquity to Modernity"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

periods <- read.csv(file.path(data_dir, "historical_periods.csv"), stringsAsFactors = FALSE)
traditions <- read.csv(file.path(data_dir, "mathematical_traditions.csv"), stringsAsFactors = FALSE)
milestones <- read.csv(file.path(data_dir, "mathematical_milestones.csv"), stringsAsFactors = FALSE)
warnings <- read.csv(file.path(data_dir, "historiographic_warnings.csv"), stringsAsFactors = FALSE)

period_counts <- aggregate(
  milestone_id ~ period_id,
  data = milestones,
  FUN = length
)
names(period_counts)[2] <- "milestone_count"

period_summary <- merge(periods, period_counts, by = "period_id", all.x = TRUE)
period_summary$milestone_count[is.na(period_summary$milestone_count)] <- 0
period_summary$interpretation <- "synthetic milestone count supports teaching, not historical prevalence"

tradition_counts <- aggregate(
  milestone_id ~ tradition_id,
  data = milestones,
  FUN = length
)
names(tradition_counts)[2] <- "milestone_count"

tradition_summary <- merge(traditions, tradition_counts, by = "tradition_id", all.x = TRUE)
tradition_summary$milestone_count[is.na(tradition_summary$milestone_count)] <- 0
tradition_summary$interpretation <- "tradition count supports scaffold coverage, not civilizational ranking"

warning_summary <- data.frame(
  topic = warnings$topic,
  warning = warnings$warning,
  mitigation = warnings$mitigation,
  interpretation = "responsible mathematical history requires attention to canon, power, media, and context"
)

write.csv(period_summary, file.path(out_dir, "r_period_summary.csv"), row.names = FALSE)
write.csv(tradition_summary, file.path(out_dir, "r_tradition_summary.csv"), row.names = FALSE)
write.csv(warning_summary, file.path(out_dir, "r_historiographic_warning_summary.csv"), row.names = FALSE)

cat("Historical R summaries written.\n")
