#!/usr/bin/env Rscript

# Binomial and possibility audit for:
# "Combinatorics and the Mathematics of Possibility"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

pascal_row <- function(n) {
  sapply(0:n, function(k) choose(n, k))
}

rows <- lapply(0:12, pascal_row)

pascal_audit <- data.frame(
  n = 0:12,
  row_sum = sapply(rows, sum),
  expected_power_of_two = 2^(0:12),
  agrees = sapply(rows, sum) == 2^(0:12),
  interpretation = "row sums of Pascal's triangle count all subsets of an n-element set"
)

n_total <- 100
multiples_of_2 <- floor(n_total / 2)
multiples_of_3 <- floor(n_total / 3)
multiples_of_6 <- floor(n_total / 6)

inclusion_exclusion <- data.frame(
  total_domain = n_total,
  multiples_of_2 = multiples_of_2,
  multiples_of_3 = multiples_of_3,
  overlap_multiples_of_6 = multiples_of_6,
  count_multiples_2_or_3 = multiples_of_2 + multiples_of_3 - multiples_of_6,
  interpretation = "subtract overlap to avoid double-counting"
)

search_growth <- data.frame(
  n = 1:15,
  subsets = 2^(1:15),
  permutations = factorial(1:15),
  interpretation = "combinatorial possibility spaces grow rapidly"
)

write.csv(pascal_audit, file.path(out_dir, "r_pascal_audit.csv"), row.names = FALSE)
write.csv(inclusion_exclusion, file.path(out_dir, "r_inclusion_exclusion_audit.csv"), row.names = FALSE)
write.csv(search_growth, file.path(out_dir, "r_search_space_growth.csv"), row.names = FALSE)

cat("Pascal row sum check for n=12:", pascal_audit$row_sum[pascal_audit$n == 12], "\n")
cat("Multiples of 2 or 3 through 100:", inclusion_exclusion$count_multiples_2_or_3, "\n")
