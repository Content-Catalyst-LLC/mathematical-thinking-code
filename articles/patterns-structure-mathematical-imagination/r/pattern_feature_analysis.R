#!/usr/bin/env Rscript

# Pattern feature analysis for "Patterns, Structure, and the Mathematical Imagination"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

odd_sum_squares <- function(n) {
  cumulative <- cumsum(seq(1, by = 2, length.out = n))
  data.frame(
    n = 1:n,
    cumulative_odd_sum = cumulative,
    square = (1:n)^2,
    identity_holds = cumulative == (1:n)^2
  )
}

sequence_features <- function(name, values) {
  data.frame(
    sequence = name,
    index = seq_along(values) - 1,
    value = values,
    first_difference = c(NA, diff(values)),
    second_difference = c(NA, NA, diff(values, differences = 2)),
    parity = values %% 2,
    mod_3 = values %% 3
  )
}

triangular <- function(n) (1:n) * ((1:n) + 1) / 2
powers_two <- function(n) 2 ^ (0:(n - 1))

feature_table <- rbind(
  sequence_features("odd_sum_squares", odd_sum_squares(12)$square),
  sequence_features("triangular", triangular(12)),
  sequence_features("powers_two", powers_two(12))
)

write.csv(feature_table, file.path(out_dir, "r_pattern_feature_table.csv"), row.names = FALSE)
write.csv(odd_sum_squares(20), file.path(out_dir, "r_odd_sum_square_identity.csv"), row.names = FALSE)

cat("Wrote R pattern outputs to:", out_dir, "\n")
