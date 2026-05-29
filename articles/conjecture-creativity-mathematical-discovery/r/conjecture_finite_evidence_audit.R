#!/usr/bin/env Rscript

# Finite evidence audit for:
# "Conjecture, Creativity, and Mathematical Discovery"
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

finite_sum_audit <- function(max_n) {
  n <- 1:max_n
  data.frame(
    n = n,
    computed_sum = sapply(n, sum_first_n),
    conjectured_formula = formula_sum_first_n(n),
    agrees = sapply(n, sum_first_n) == formula_sum_first_n(n),
    evidence_status = "finite evidence only",
    proof_note = "induction required for universal theorem"
  )
}

bounded_counterexample <- function(n) {
  index <- 0:(n - 1)
  value <- (-1) ^ index
  data.frame(
    index = index,
    value = value,
    bounded = abs(value) <= 1,
    convergence_note = "bounded but nonconvergent alternating sequence"
  )
}

audit <- finite_sum_audit(100)
counterexample <- bounded_counterexample(50)

write.csv(audit, file.path(out_dir, "r_sum_conjecture_finite_audit.csv"), row.names = FALSE)
write.csv(counterexample, file.path(out_dir, "r_bounded_counterexample_trace.csv"), row.names = FALSE)

cat("All tested sum cases agree:", all(audit$agrees), "\n")
cat("Interpretation: finite agreement supports conjecture; proof supplies justification.\n")
