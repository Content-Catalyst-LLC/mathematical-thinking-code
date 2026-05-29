#!/usr/bin/env Rscript

# Quantifier and counterexample audit for
# "Logic and the Structure of Formal Inference"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

implies <- function(p, q) {
  (!p) | q
}

is_even <- function(n) {
  n %% 2 == 0
}

square_is_even <- function(n) {
  (n * n) %% 2 == 0
}

domain <- -50:50

implication_audit <- data.frame(
  n = domain,
  premise_even = is_even(domain),
  conclusion_square_even = square_is_even(domain),
  implication_holds = implies(is_even(domain), square_is_even(domain)),
  interpretation = "finite audit supports but does not replace universal proof"
)

bounded_counterexample <- data.frame(
  index = 0:40,
  value = (-1) ^ (0:40),
  bounded = abs((-1) ^ (0:40)) <= 1,
  convergence_note = "bounded alternating sequence does not converge"
)

truth_table <- expand.grid(P = c(FALSE, TRUE), Q = c(FALSE, TRUE))
truth_table$P_implies_Q <- implies(truth_table$P, truth_table$Q)
truth_table$contrapositive <- implies(!truth_table$Q, !truth_table$P)
truth_table$equivalent <- truth_table$P_implies_Q == truth_table$contrapositive

write.csv(implication_audit, file.path(out_dir, "r_implication_audit.csv"), row.names = FALSE)
write.csv(bounded_counterexample, file.path(out_dir, "r_bounded_counterexample.csv"), row.names = FALSE)
write.csv(truth_table, file.path(out_dir, "r_implication_truth_table.csv"), row.names = FALSE)

cat("All finite implication checks hold:", all(implication_audit$implication_holds), "\n")
cat("Contrapositive equivalent to implication in all truth-table rows:", all(truth_table$equivalent), "\n")
cat("Interpretation: finite audits and truth tables support formal reasoning, but domain theorems still require proof.\n")
