# Line Chart ----

# Suppose we want to chart the Petal Widths as a time series on a line chart

## Data Prep ----
# First we need to add a time element to the `iris` data
dates <- seq.Date(
  from = as.Date("2021-01-01"), 
  by = "day", 
  length.out = nrow(iris) / 3
)

data <- iris |> 
  mutate(
    Date = rep(dates, 3)
  ) |> 
  select(
    Date, 
    Petal.Width, 
    Species
  )

## Create simple line chart ----
data |> 
  group_by(Species) |> 
  e_charts(x = _____) |> 
  e_line(serie = _____) |> 
  e_tooltip(trigger = _____)

## Using Non-native Formatting ----
?e_line   # click the "See additional arguments" link

# Fill the points on the chart
data |> 
  group_by(Species) |> 
  e_charts(x = Date) |> 
  e_line(
    serie = Petal.Width, 
    symbol = _____   # fill in the circle
  ) |> 
  e_tooltip(trigger = "axis")

# Make the lines dashed instead of solid
data |> 
  group_by(Species) |> 
  e_charts(x = Date) |> 
  e_line(
    serie = Petal.Width, 
    lineStyle = _____   # `lineStyle = "dashed"` doesn't work
  ) |> 
  e_tooltip(trigger = "axis")
