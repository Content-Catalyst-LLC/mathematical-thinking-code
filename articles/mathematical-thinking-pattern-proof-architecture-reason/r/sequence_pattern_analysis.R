#!/usr/bin/env Rscript

# Sequence pattern analysis for "What Is Mathematical Thinking?"
# Uses base R only for portability.

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

fibonacci <- function(n) {
  if (n <= 0) return(numeric(0))
  if (n == 1) return(c(0))
  values <- numeric(n)
  values[1] <- 0
  values[2] <- 1
  for (i in 3:n) {
    values[i] <- values[i - 1] + values[i - 2]
  }
  values
}

lucas <- function(n) {
  if (n <= 0) return(numeric(0))
  if (n == 1) return(c(2))
  values <- numeric(n)
  values[1] <- 2
  values[2] <- 1
  for (i in 3:n) {
    values[i] <- values[i - 1] + values[i - 2]
  }
  values
}

summarize_sequence <- function(name, values) {
  data.frame(
    sequence = name,
    index = seq_along(values) - 1,
    value = values,
    parity = values %% 2,
    mod_3 = values %% 3,
    ratio_to_previous = c(NA, values[-1] / values[-length(values)])
  )
}

n <- 30
table <- rbind(
  summarize_sequence("fibonacci", fibonacci(n)),
  summarize_sequence("lucas", lucas(n))
)

write.csv(table, file.path(out_dir, "r_sequence_pattern_table.csv"), row.names = FALSE)

summary_table <- aggregate(
  value ~ sequence + parity,
  data = table,
  FUN = length
)
names(summary_table)[names(summary_table) == "value"] <- "count"

write.csv(summary_table, file.path(out_dir, "r_sequence_parity_summary.csv"), row.names = FALSE)

cat("Wrote R sequence pattern outputs to:", out_dir, "\n")
