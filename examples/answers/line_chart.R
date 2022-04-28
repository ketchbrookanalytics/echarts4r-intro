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
  e_charts(x = Date) |> 
  e_line(serie = Petal.Width) |> 
  e_tooltip(trigger = "axis")

## Using Non-native Formatting ----
?e_line   # click the "See additional arguments" link

# Fill the points on the chart
data |> 
  group_by(Species) |> 
  e_charts(x = Date) |> 
  e_line(
    serie = Petal.Width, 
    symbol = "circle"   # fill in the circle
  ) |> 
  e_tooltip(trigger = "axis")

# Make the lines dashed instead of solid
data |> 
  group_by(Species) |> 
  e_charts(x = Date) |> 
  e_line(
    serie = Petal.Width, 
    lineStyle = list(type = "dashed")   # `lineStyle = "dashed"` doesn't work
  ) |> 
  e_tooltip(trigger = "axis")
