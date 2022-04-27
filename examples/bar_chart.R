# Bar Chart ----

# Suppose we want to chart the average Sepal Length in the `iris` dataset
# by Species type

## Data Prep ----
# First we need to summarise the data
library(dplyr)

data <- iris |> 
  dplyr::group_by(Species) |> 
  dplyr::summarise(
    mean_Sepal.Length = mean(Sepal.Length), 
    .groups = "drop"
  )

## Using {plotly} ----
# Let's build a bar chart using {plotly}, first
library(plotly)

data |> 
  plot_ly(
    x = ~Species, 
    y = ~mean_Sepal.Length, 
    type = "bar"
  )

## Using {echarts4r} ----
# Now let's try it with {echarts4r}
library(echarts4r)

data |> 
  e_charts(x = Species) |> 
  e_bar(serie = mean_Sepal.Length) |> 
  e_tooltip(trigger = "item")   # tooltip must be specified


# Conclusion ----
# {plotly} and {echarts4r} use the about the same number of lines of code, but 
# {echarts4r} has cleaner tooltip & nice transitions on render; plus, who wants 
# to see that ugly toolbar above the plot every time you hover over it?
