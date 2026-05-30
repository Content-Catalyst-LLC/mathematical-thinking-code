#!/usr/bin/env Rscript

# Proof assistant summary for:
# "Mathematical Thinking and Proof Assistants"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

systems <- read.csv(file.path(data_dir, "proof_assistant_systems.csv"), stringsAsFactors = FALSE)
skills <- read.csv(file.path(data_dir, "proof_assistant_skills.csv"), stringsAsFactors = FALSE)
boundaries <- read.csv(file.path(data_dir, "proof_trust_boundaries.csv"), stringsAsFactors = FALSE)
layers <- read.csv(file.path(data_dir, "proof_layers.csv"), stringsAsFactors = FALSE)

system_summary <- data.frame(
  system = systems$system_name,
  foundation_or_logic = systems$foundation_or_logic,
  strength = systems$typical_strength,
  common_use = systems$common_use,
  trust_note = systems$trust_note,
  interpretation = "system choice affects foundations, library conventions, automation, and trust boundary"
)

skill_summary <- data.frame(
  skill = skills$skill_name,
  why_it_matters = skills$why_it_matters,
  review_question = skills$review_question,
  interpretation = "proof-assistant literacy requires formal and interpretive skills"
)

boundary_summary <- data.frame(
  trusted_component = boundaries$trusted_component,
  trust_question = boundaries$trust_question,
  review_note = boundaries$review_note,
  interpretation = "machine checking relocates trust rather than eliminating it"
)

layer_summary <- data.frame(
  layer = layers$layer_name,
  human_role = layers$human_role,
  machine_role = layers$machine_role,
  risk = layers$risk_or_limitation,
  interpretation = "formal checking is one layer in proof-assistant mathematics"
)

write.csv(system_summary, file.path(out_dir, "r_proof_assistant_system_summary.csv"), row.names = FALSE)
write.csv(skill_summary, file.path(out_dir, "r_proof_assistant_skill_summary.csv"), row.names = FALSE)
write.csv(boundary_summary, file.path(out_dir, "r_trust_boundary_summary.csv"), row.names = FALSE)
write.csv(layer_summary, file.path(out_dir, "r_proof_layer_summary.csv"), row.names = FALSE)

cat("Proof-assistant R summaries written.\n")
