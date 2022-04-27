library(shiny)
library(echarts4r)
library(dplyr)

ui <- shiny::fluidPage(
  
  title = "Intro to {echarts4r}", 
  
  shiny::fluidRow(
    
    shiny::column(
      width = 12, 
      
      shiny::h3("Intro to {echarts4r}"), 
      shiny::h6("An R Interface to the Apache eCharts Project"), 
      
      shiny::hr(), 
      
      shiny::tabsetPanel(
        
        shiny::tabPanel(
          title = "Bar Chart", 
          
          shiny::br(), 
          
          # Choose which species to display in the bar chart
          shiny::selectInput(
            inputId = "select_species", 
            label = "Select Species:", 
            choices = unique(iris$Species), 
            selected = "setosa", 
            multiple = TRUE
          ), 
          
          # Add some space between inputs & chart
          shiny::br(), 
          
          # EChart output in the UI
          echarts4r::echarts4rOutput(
            outputId = "bar_chart"
          )
          
        ), 
        
        shiny::tabPanel()
        
      )
      
    )

  )
  
)

server <- function(input, output, session) {
  
  # Filtered data based upon the user-selected "Species" type
  data <- shiny::reactive({
    
    iris |> 
      dplyr::filter(Species %in% input$select_species) |> 
      dplyr::select(Sepal.Length, Species) |> 
      dplyr::group_by(Species) |> 
      dplyr::summarise(
        mean_Sepal.Length = mean(Sepal.Length), 
        .groups = "drop"
      )
    
  })
  
  # Render the EChart here
  output$bar_chart <- echarts4r::renderEcharts4r({
    
    data() |> 
      echarts4r::e_chart(
        x = Species, 
      ) |> 
      echarts4r::e_bar(
        serie = mean_Sepal.Length, 
        name = "Mean Sepal Length"
      ) |> 
      echarts4r::e_flip_coords()
    
  })
  
}

shinyApp(ui, server)