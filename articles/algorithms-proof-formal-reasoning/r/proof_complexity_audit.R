#!/usr/bin/env Rscript

# Proof and complexity audit for:
# "Algorithms, Proof, and Formal Reasoning"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

n <- 1:30

complexity_table <- data.frame(
  n = n,
  log2_n = log2(n),
  linear = n,
  n_log2_n = n * log2(n),
  quadratic = n^2,
  exponential = 2^n,
  interpretation = "complexity analysis compares growth patterns under an abstract cost model"
)

proof_obligations <- data.frame(
  algorithm = c("insertion sort", "binary search", "breadth-first search", "Dijkstra shortest path"),
  precondition = c(
    "finite comparable list",
    "sorted finite sequence",
    "valid unweighted graph and start vertex",
    "weighted graph with nonnegative weights"
  ),
  invariant = c(
    "processed prefix is sorted",
    "target remains in active interval if present",
    "queue processes vertices by distance layers",
    "settled vertices have final distances"
  ),
  proof_method = c(
    "loop invariant",
    "loop invariant and termination",
    "induction on graph distance",
    "greedy invariant"
  ),
  risk_note = c(
    "sorting proof does not validate ranking purpose",
    "unsorted input invalidates guarantee",
    "edge count may not represent real-world distance",
    "negative weights break proof"
  )
)

write.csv(complexity_table, file.path(out_dir, "r_complexity_growth_table.csv"), row.names = FALSE)
write.csv(proof_obligations, file.path(out_dir, "r_proof_obligation_table.csv"), row.names = FALSE)

cat("Proof and complexity audit written.\n")
