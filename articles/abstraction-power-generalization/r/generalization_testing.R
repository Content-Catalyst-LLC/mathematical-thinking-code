#!/usr/bin/env Rscript

# Generalization testing for "Abstraction and the Power of Generalization"
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

finite_case_audit <- function(max_n) {
  n <- 1:max_n
  data.frame(
    n = n,
    computed_sum = sapply(n, sum_first_n),
    formula_value = formula_sum_first_n(n),
    agrees = sapply(n, sum_first_n) == formula_sum_first_n(n),
    interpretation = "finite evidence supports conjecture but does not replace proof"
  )
}

bounded_nonconvergent <- function(n) {
  index <- 0:(n - 1)
  value <- (-1) ^ index
  data.frame(
    index = index,
    value = value,
    bounded = abs(value) <= 1
  )
}

audit <- finite_case_audit(100)
counterexample <- bounded_nonconvergent(40)

write.csv(audit, file.path(out_dir, "r_finite_case_audit.csv"), row.names = FALSE)
write.csv(counterexample, file.path(out_dir, "r_bounded_nonconvergent_counterexample.csv"), row.names = FALSE)

cat("All finite test cases agree for sum formula:", all(audit$agrees), "\n")
cat("Interpretation: finite agreement supports the conjecture; proof establishes the theorem.\n")
