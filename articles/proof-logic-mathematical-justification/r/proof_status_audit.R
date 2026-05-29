#!/usr/bin/env Rscript

# Proof-status audit for "Proof and the Logic of Mathematical Justification"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

sum_first_n <- function(n) {
  sum(seq_len(n))
}

formula_sum_first_n <- function(n) {
  n * (n + 1) / 2
}

finite_induction_audit <- function(max_n) {
  n <- 1:max_n
  data.frame(
    n = n,
    computed_sum = sapply(n, sum_first_n),
    formula_value = formula_sum_first_n(n),
    agrees = sapply(n, sum_first_n) == formula_sum_first_n(n),
    proof_status = "finite evidence only; induction proves generality"
  )
}

alternating_counterexample <- function(n) {
  index <- 0:(n - 1)
  value <- (-1) ^ index
  data.frame(
    index = index,
    value = value,
    bounded = abs(value) <= 1,
    interpretation = "bounded but nonconvergent oscillation"
  )
}

audit <- finite_induction_audit(100)
counterexample <- alternating_counterexample(40)

write.csv(audit, file.path(out_dir, "r_induction_finite_audit.csv"), row.names = FALSE)
write.csv(counterexample, file.path(out_dir, "r_bounded_sequence_counterexample.csv"), row.names = FALSE)

cat("All checked sum cases agree:", all(audit$agrees), "\n")
cat("Interpretation: finite evidence supports the theorem; proof supplies justification.\n")
