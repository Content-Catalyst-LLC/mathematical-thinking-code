#!/usr/bin/env Rscript

# Algebraic equivalence audit for:
# "What Makes Algebraic Thinking Distinct"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

domain <- -10:10

expanded_linear <- function(x) {
  2 * x + 6
}

factored_linear <- function(x) {
  2 * (x + 3)
}

quadratic_expanded <- function(x) {
  x^2 + 5*x + 6
}

quadratic_factored <- function(x) {
  (x + 2) * (x + 3)
}

equivalence_audit <- data.frame(
  x = domain,
  expanded_linear = expanded_linear(domain),
  factored_linear = factored_linear(domain),
  linear_agrees = expanded_linear(domain) == factored_linear(domain),
  quadratic_expanded = quadratic_expanded(domain),
  quadratic_factored = quadratic_factored(domain),
  quadratic_agrees = quadratic_expanded(domain) == quadratic_factored(domain),
  interpretation = "sampled agreement supports equivalence but symbolic proof establishes identity"
)

variable_roles <- data.frame(
  symbol = c("x", "n", "x", "m", "a_n"),
  role = c("unknown", "generalized number", "function input", "parameter", "sequence term"),
  example = c("x+3=10", "n+n=2n", "f(x)=3x+2", "y=mx+b", "a_n=2n+1"),
  learning_note = c(
    "solve under conditions",
    "reason generally",
    "analyze input-output dependence",
    "compare family behavior",
    "analyze sequence position"
  )
)

write.csv(equivalence_audit, file.path(out_dir, "r_equivalence_audit.csv"), row.names = FALSE)
write.csv(variable_roles, file.path(out_dir, "r_variable_roles.csv"), row.names = FALSE)

cat("All sampled linear values agree:", all(equivalence_audit$linear_agrees), "\n")
cat("All sampled quadratic values agree:", all(equivalence_audit$quadratic_agrees), "\n")
cat("Interpretation: finite checks support algebraic equivalence, but proof establishes identity.\n")
