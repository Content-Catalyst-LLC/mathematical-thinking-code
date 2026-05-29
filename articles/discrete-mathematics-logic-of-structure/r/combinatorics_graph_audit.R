#!/usr/bin/env Rscript

# Combinatorics and graph audit for:
# "Discrete Mathematics and the Logic of Structure"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

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

vertices <- c("A", "B", "C", "D", "E")
edges <- data.frame(
  source = c("A", "A", "B"),
  target = c("B", "C", "D"),
  stringsAsFactors = FALSE
)

degree <- setNames(rep(0, length(vertices)), vertices)
for (i in seq_len(nrow(edges))) {
  degree[edges$source[i]] <- degree[edges$source[i]] + 1
  degree[edges$target[i]] <- degree[edges$target[i]] + 1
}

graph_audit <- data.frame(
  vertex = names(degree),
  degree = as.integer(degree),
  interpretation = "degree counts graph adjacency, independent of visual layout",
  row.names = NULL
)

boolean_audit <- expand.grid(P = c(FALSE, TRUE), Q = c(FALSE, TRUE))
boolean_audit$not_P <- !boolean_audit$P
boolean_audit$P_and_Q <- boolean_audit$P & boolean_audit$Q
boolean_audit$P_or_Q <- boolean_audit$P | boolean_audit$Q
boolean_audit$P_implies_Q <- (!boolean_audit$P) | boolean_audit$Q
boolean_audit$P_xor_Q <- xor(boolean_audit$P, boolean_audit$Q)
boolean_audit$interpretation <- "Boolean operations define discrete truth structure"

write.csv(inclusion_exclusion, file.path(out_dir, "r_inclusion_exclusion_audit.csv"), row.names = FALSE)
write.csv(graph_audit, file.path(out_dir, "r_graph_degree_audit.csv"), row.names = FALSE)
write.csv(boolean_audit, file.path(out_dir, "r_boolean_audit.csv"), row.names = FALSE)

cat("Inclusion-exclusion count:", inclusion_exclusion$count_multiples_2_or_3, "\n")
cat("Graph degree audit written.\n")
