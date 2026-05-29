#!/usr/bin/env Rscript

# Pattern audit for "Mathematics as the Science of Patterns"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

finite_differences <- function(values) {
  diff(values)
}

classify_sequence <- function(values) {
  d1 <- finite_differences(values)
  d2 <- finite_differences(d1)

  if (length(unique(d1)) == 1) {
    return("arithmetic")
  }

  if (length(d2) > 0 && length(unique(d2)) == 1) {
    return("quadratic")
  }

  if (all(values[-length(values)] != 0)) {
    ratios <- values[-1] / values[-length(values)]
    if (length(unique(round(ratios, 10))) == 1) {
      return("geometric")
    }
  }

  return("undetermined finite pattern")
}

patterns <- list(
  arithmetic = c(2, 5, 8, 11, 14, 17),
  quadratic = c(1, 4, 9, 16, 25, 36),
  triangular = c(1, 3, 6, 10, 15, 21),
  powers_two = c(1, 2, 4, 8, 16, 32),
  misleading = c(1, 2, 4, 8, 16, 31)
)

audit <- data.frame(
  name = names(patterns),
  terms = sapply(patterns, function(x) paste(x, collapse = " ")),
  classification = sapply(patterns, classify_sequence),
  first_differences = sapply(patterns, function(x) paste(diff(x), collapse = " ")),
  second_differences = sapply(patterns, function(x) paste(diff(x, differences = 2), collapse = " "))
)

set.seed(20260529)
n <- 1000
coin <- rbinom(n, size = 1, prob = 0.5)
checkpoints <- c(10, 25, 50, 100, 250, 500, 1000)
probability_table <- data.frame(
  trial = checkpoints,
  successes = sapply(checkpoints, function(k) sum(coin[1:k])),
  observed_frequency = sapply(checkpoints, function(k) mean(coin[1:k])),
  expected_probability = 0.5
)

write.csv(audit, file.path(out_dir, "r_sequence_pattern_audit.csv"), row.names = FALSE)
write.csv(probability_table, file.path(out_dir, "r_probability_regularities.csv"), row.names = FALSE)

cat("Wrote R pattern audit outputs to:", out_dir, "\n")
cat("Finite classification is heuristic; proof status must be tracked separately.\n")
