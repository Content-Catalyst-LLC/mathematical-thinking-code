# Mathematical Thinking: Sequence Pattern Analysis in R
# Educational example only.

library(tidyverse)
library(broom)

n_max <- 30

sequence_data <- tibble(
  n = 1:n_max,
  arithmetic = 3 * n + 2,
  quadratic = n^2 + n + 1,
  triangular = n * (n + 1) / 2,
  powers_of_two = 2^n
)

long_sequences <- sequence_data |>
  pivot_longer(
    cols = -n,
    names_to = "sequence_type",
    values_to = "value"
  )

print(sequence_data)

fit_candidates <- function(data, response_column) {
  linear_formula <- as.formula(paste(response_column, "~ n"))
  quadratic_formula <- as.formula(paste(response_column, "~ n + I(n^2)"))

  linear_fit <- lm(linear_formula, data = data)
  quadratic_fit <- lm(quadratic_formula, data = data)

  tibble(
    sequence = response_column,
    model = c("linear", "quadratic"),
    r_squared = c(
      glance(linear_fit)$r.squared,
      glance(quadratic_fit)$r.squared
    ),
    aic = c(
      AIC(linear_fit),
      AIC(quadratic_fit)
    )
  )
}

model_results <- bind_rows(
  fit_candidates(sequence_data, "arithmetic"),
  fit_candidates(sequence_data, "quadratic"),
  fit_candidates(sequence_data, "triangular")
)

difference_table <- sequence_data |>
  mutate(
    quadratic_first_difference = quadratic - lag(quadratic),
    quadratic_second_difference =
      quadratic_first_difference - lag(quadratic_first_difference),
    triangular_first_difference = triangular - lag(triangular),
    triangular_second_difference =
      triangular_first_difference - lag(triangular_first_difference)
  )

dir.create("../outputs", showWarnings = FALSE, recursive = TRUE)

write_csv(sequence_data, "../outputs/r_synthetic_sequences.csv")
write_csv(model_results, "../outputs/r_candidate_model_results.csv")
write_csv(difference_table, "../outputs/r_difference_table.csv")

print(model_results)
print(difference_table)
