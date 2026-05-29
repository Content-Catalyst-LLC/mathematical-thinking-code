#!/usr/bin/env Rscript

# Sequence pattern audit for:
# "Number, Pattern, and the Origins of Mathematical Thought"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

triangular <- c(1, 3, 6, 10, 15, 21, 28)
even <- c(2, 4, 6, 8, 10, 12, 14)
cycle <- rep(0:3, 4)

audit_sequence <- function(sequence_id, values, rule_note) {
  n <- seq_along(values)
  data.frame(
    sequence_id = sequence_id,
    index = n,
    value = values,
    first_difference = c(NA, diff(values)),
    second_difference = c(NA, NA, diff(diff(values))),
    rule_note = rule_note,
    interpretation = "finite sequence evidence can suggest pattern but proof establishes generality"
  )
}

triangular_audit <- audit_sequence("triangular", triangular, "candidate rule n(n+1)/2")
even_audit <- audit_sequence("even", even, "candidate rule 2n")
cycle_audit <- data.frame(
  index = seq_along(cycle) - 1,
  value = cycle,
  period = 4,
  formula_note = "n mod 4",
  interpretation = "modular arithmetic formalizes repeated rhythm"
)

write.csv(triangular_audit, file.path(out_dir, "r_triangular_pattern_audit.csv"), row.names = FALSE)
write.csv(even_audit, file.path(out_dir, "r_even_pattern_audit.csv"), row.names = FALSE)
write.csv(cycle_audit, file.path(out_dir, "r_cycle_pattern_audit.csv"), row.names = FALSE)

cat("Triangular second differences:", paste(na.omit(triangular_audit$second_difference), collapse = " "), "\n")
cat("Even first differences:", paste(na.omit(even_audit$first_difference), collapse = " "), "\n")
cat("Cycle period:", 4, "\n")
