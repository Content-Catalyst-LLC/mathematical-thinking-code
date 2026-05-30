#!/usr/bin/env Rscript

# Notation summary for:
# "The Evolution of Algebraic Notation"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

styles <- read.csv(file.path(data_dir, "notation_styles.csv"), stringsAsFactors = FALSE)
milestones <- read.csv(file.path(data_dir, "notation_milestones.csv"), stringsAsFactors = FALSE)
warnings <- read.csv(file.path(data_dir, "notation_warnings.csv"), stringsAsFactors = FALSE)

style_counts <- aggregate(
  milestone_id ~ style_id,
  data = milestones,
  FUN = length
)
names(style_counts)[2] <- "milestone_count"

style_summary <- merge(styles, style_counts, by = "style_id", all.x = TRUE)
style_summary$milestone_count[is.na(style_summary$milestone_count)] <- 0
style_summary$interpretation <- "synthetic milestone count supports teaching, not historical prevalence"

warning_summary <- data.frame(
  topic = warnings$topic,
  warning = warnings$warning,
  mitigation = warnings$mitigation,
  interpretation = "notation should be taught as meaningful historical and mathematical infrastructure"
)

write.csv(style_summary, file.path(out_dir, "r_notation_style_summary.csv"), row.names = FALSE)
write.csv(warning_summary, file.path(out_dir, "r_notation_warning_summary.csv"), row.names = FALSE)

cat("Notation R summaries written.\n")
