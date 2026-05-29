#!/usr/bin/env Rscript

# Coordinate transformation audit for:
# "Geometry and the Visual Mind in Mathematics"
# Uses base R only for portability.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = FALSE)
data_dir <- file.path(root, "data", "raw")
out_dir <- file.path(root, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

points <- read.csv(file.path(data_dir, "points.csv"), stringsAsFactors = FALSE)

rotate_90 <- function(x, y) {
  data.frame(x_t = -y, y_t = x)
}

reflected_x <- function(x, y) {
  data.frame(x_t = x, y_t = -y)
}

rot <- rotate_90(points$x, points$y)
ref <- reflected_x(points$x, points$y)

rotation_audit <- data.frame(
  point_id = points$point_id,
  x = points$x,
  y = points$y,
  x_rot = rot$x_t,
  y_rot = rot$y_t,
  squared_distance_before = points$x^2 + points$y^2,
  squared_distance_after = rot$x_t^2 + rot$y_t^2,
  distance_preserved = (points$x^2 + points$y^2) == (rot$x_t^2 + rot$y_t^2),
  interpretation = "rotation changes coordinates but preserves distance from the origin"
)

reflection_audit <- data.frame(
  point_id = points$point_id,
  x = points$x,
  y = points$y,
  x_ref = ref$x_t,
  y_ref = ref$y_t,
  squared_distance_before = points$x^2 + points$y^2,
  squared_distance_after = ref$x_t^2 + ref$y_t^2,
  distance_preserved = (points$x^2 + points$y^2) == (ref$x_t^2 + ref$y_t^2),
  interpretation = "reflection changes orientation but preserves distance from the origin"
)

write.csv(rotation_audit, file.path(out_dir, "r_rotation_audit.csv"), row.names = FALSE)
write.csv(reflection_audit, file.path(out_dir, "r_reflection_audit.csv"), row.names = FALSE)

cat("Rotation distance preserved for all points:", all(rotation_audit$distance_preserved), "\n")
cat("Reflection distance preserved for all points:", all(reflection_audit$distance_preserved), "\n")
