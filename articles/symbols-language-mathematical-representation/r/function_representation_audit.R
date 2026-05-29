#!/usr/bin/env Rscript

# Function representation audit for:
# "Symbols, Language, and Mathematical Representation"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

domain <- seq(-5, 5, by = 1)

f <- function(x) x^2
g <- function(x) abs(x)^2
h <- function(x) x^2 + 0

table_representation <- data.frame(
  x = domain,
  f_formula = "x^2",
  g_formula = "abs(x)^2",
  h_formula = "x^2 + 0",
  f_value = f(domain),
  g_value = g(domain),
  h_value = h(domain),
  f_equals_g_on_sample = f(domain) == g(domain),
  f_equals_h_on_sample = f(domain) == h(domain),
  interpretation = "finite sampled table supports comparison but does not replace symbolic proof over intended domain"
)

notation_audit <- data.frame(
  notation = c("f(x)=x^2", "f:X->Y", "sum_i a_i", "A^{-1}", "G=(V,E)"),
  preserves = c("symbolic rule", "domain and codomain", "indexed accumulation", "inverse-like operation", "graph structure"),
  risk = c("domain hidden", "rule hidden", "index scope ambiguity", "context-dependent meaning", "edge semantics may be omitted"),
  mitigation = c("record domain and codomain", "define rule explicitly", "state bounds and convergence", "clarify inverse type", "document vertex and edge meaning")
)

write.csv(table_representation, file.path(out_dir, "r_function_representation_table.csv"), row.names = FALSE)
write.csv(notation_audit, file.path(out_dir, "r_notation_audit.csv"), row.names = FALSE)

cat("All sampled f/g values agree:", all(table_representation$f_equals_g_on_sample), "\n")
cat("Interpretation: sampled equality supports conjecture; proof establishes full-domain equality.\n")
