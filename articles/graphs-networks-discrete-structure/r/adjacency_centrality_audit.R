#!/usr/bin/env Rscript

# Adjacency, degree, and centrality audit for:
# "Graphs, Networks, and Discrete Structure"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

vertices <- c("A", "B", "C", "D", "E")

edges <- data.frame(
  source = c("A", "A", "B"),
  target = c("B", "C", "D"),
  stringsAsFactors = FALSE
)

adjacency <- matrix(0, nrow = length(vertices), ncol = length(vertices))
rownames(adjacency) <- vertices
colnames(adjacency) <- vertices

for (i in seq_len(nrow(edges))) {
  s <- edges$source[i]
  t <- edges$target[i]
  adjacency[s, t] <- 1
  adjacency[t, s] <- 1
}

degree_audit <- data.frame(
  vertex = vertices,
  degree = rowSums(adjacency),
  isolated = rowSums(adjacency) == 0,
  interpretation = "degree counts local adjacency in an undirected graph"
)

handshaking <- data.frame(
  degree_sum = sum(rowSums(adjacency)),
  edge_count = nrow(edges),
  twice_edge_count = 2 * nrow(edges),
  agrees = sum(rowSums(adjacency)) == 2 * nrow(edges),
  interpretation = "sum of degrees equals twice the number of edges in an undirected graph"
)

write.csv(as.data.frame(adjacency), file.path(out_dir, "r_adjacency_matrix.csv"))
write.csv(degree_audit, file.path(out_dir, "r_degree_audit.csv"), row.names = FALSE)
write.csv(handshaking, file.path(out_dir, "r_handshaking_audit.csv"), row.names = FALSE)

cat("Degree audit written.\n")
print(degree_audit)
