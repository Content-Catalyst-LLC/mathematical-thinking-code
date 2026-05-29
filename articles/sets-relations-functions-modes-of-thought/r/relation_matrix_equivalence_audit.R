#!/usr/bin/env Rscript

# Relation matrix and equivalence-class audit for:
# "Sets, Relations, and Functions as Modes of Thought"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

domain <- 1:8

mod3_relation <- outer(domain, domain, Vectorize(function(x, y) {
  x %% 3 == y %% 3
}))

rownames(mod3_relation) <- domain
colnames(mod3_relation) <- domain

equivalence_classes <- split(domain, domain %% 3)

class_table <- data.frame(
  class_label = paste0("residue_", names(equivalence_classes)),
  members = sapply(equivalence_classes, paste, collapse = " "),
  interpretation = "modular equivalence partitions the domain into disjoint classes",
  row.names = NULL
)

domain_function <- 1:4
double_values <- 2 * domain_function

function_table <- data.frame(
  input = domain_function,
  output = double_values,
  codomain = "2 4 6 8",
  output_in_codomain = double_values %in% c(2, 4, 6, 8),
  interpretation = "domain/codomain validation is part of function definition"
)

write.csv(as.data.frame(mod3_relation), file.path(out_dir, "r_mod3_relation_matrix.csv"))
write.csv(class_table, file.path(out_dir, "r_equivalence_classes.csv"), row.names = FALSE)
write.csv(function_table, file.path(out_dir, "r_function_mapping_table.csv"), row.names = FALSE)

cat("Equivalence classes modulo 3:\n")
print(class_table)
