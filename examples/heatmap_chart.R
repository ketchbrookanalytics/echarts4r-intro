# Heatmap ----


# Build a data frame of mock transactions from a ledger
dates <- seq.Date(
  from = as.Date("2021-01-01"), 
  to = as.Date("2021-12-31"), 
  by = "day"
) |> 
  rep(3)

set.seed(123)
values <- rexp(
  n = length(dates), 
  rate = 0.5
)

data <- data.frame(
  Date = rep(dates, 3), 
  TransactionAmount = round(values, 4) * 100
)

# Build the heatmap
data |> 
  dplyr::group_by(Date) |> 
  dplyr::summarise(
    AverageAmount = mean(TransactionAmount), 
    .groups = "drop"
  ) |> 
  e_charts(x = Date) |> 
  e_calendar(range = "2021") |> 
  e_heatmap(
    y = AverageAmount, 
    coord_system = "calendar"
  ) |> 
  e_visual_map() |> 
  e_tooltip(trigger = "item")
