#!/usr/bin/env Rscript

# Recurrence growth audit for:
# "Recursion and Recursive Thinking"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

fib_iter <- function(n) {
  if (n == 0) return(0)
  if (n == 1) return(1)
  previous <- 0
  current <- 1
  for (i in 2:n) {
    next_value <- previous + current
    previous <- current
    current <- next_value
  }
  current
}

merge_sort_cost <- function(n) {
  if (n <= 1) return(1)
  2 * RecallMethod(n %/% 2) + n
}

RecallMethod <- function(n) {
  if (n <= 1) return(1)
  2 * RecallMethod(n %/% 2) + n
}

n_values <- 0:20

recurrence_audit <- data.frame(
  n = n_values,
  fibonacci = sapply(n_values, fib_iter),
  factorial = factorial(n_values),
  arithmetic = 3 + 5 * n_values,
  geometric = 2 * 3^n_values,
  interpretation = "recursive definitions can be audited through generated tables"
)

powers_two <- 2^(0:10)
divide_conquer_audit <- data.frame(
  n = powers_two,
  merge_sort_cost = sapply(powers_two, RecallMethod),
  n_log2_n = powers_two * log2(powers_two),
  interpretation = "divide-and-conquer recurrences produce n log n style growth"
)

write.csv(recurrence_audit, file.path(out_dir, "r_recurrence_growth_audit.csv"), row.names = FALSE)
write.csv(divide_conquer_audit, file.path(out_dir, "r_divide_conquer_audit.csv"), row.names = FALSE)

cat("Fibonacci(20):", fib_iter(20), "\n")
cat("20!:", factorial(20), "\n")
