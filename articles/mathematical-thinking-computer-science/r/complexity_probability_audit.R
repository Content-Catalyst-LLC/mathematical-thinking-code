#!/usr/bin/env Rscript

# Complexity and probability audit for:
# "Mathematical Thinking for Computer Science"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

n <- 1:30

complexity_audit <- data.frame(
  n = n,
  log2_n = log2(n),
  linear = n,
  n_log2_n = n * log2(n),
  quadratic = n^2,
  exponential = 2^n,
  interpretation = "asymptotic growth explains scalability and feasibility"
)

probability_audit <- data.frame(
  case = c("fair_die_even", "two_dice_sum_7", "hash_bucket_idealized"),
  total_outcomes = c(6, 36, 10),
  favorable_outcomes = c(3, 6, 1),
  equally_likely_assumption = c(TRUE, TRUE, TRUE),
  probability = c(3/6, 6/36, 1/10),
  interpretation = c(
    "favorable outcomes over sample space",
    "ordered dice pairs are the equally likely outcomes",
    "idealized uniform hashing assumption"
  )
)

write.csv(complexity_audit, file.path(out_dir, "r_complexity_growth_audit.csv"), row.names = FALSE)
write.csv(probability_audit, file.path(out_dir, "r_probability_audit.csv"), row.names = FALSE)

cat("Complexity and probability audit written.\n")
