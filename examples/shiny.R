library(dplyr)
library(shiny)
library(echarts4r)
library(htmlwidgets)
library(reactable)

set.seed(321)
heatmap_data <- iris |> 
  dplyr::mutate(
    Group = sample(
      x = LETTERS[1:8], 
      size = nrow(iris), 
      replace = TRUE
    )
  )

ui <- shiny::fluidPage(
  
  title = "Intro to {echarts4r}", 
  
  shiny::fluidRow(
    
    shiny::column(
      width = 12, 
      
      shiny::h3("Intro to {echarts4r}"), 
      shiny::h6("An R Interface to the Apache eCharts Project"), 
      
    )
    
  ), 
  
  shiny::hr(), 
  
  shiny::fluidRow(
    
    shiny::column(
      width = 12, 
      
      shiny::tabsetPanel(
        
        shiny::tabPanel(
          title = "Bar & Line Charts", 
          
          shiny::br(), 
          
          # Choose which species to display in the bar chart
          shiny::selectInput(
            inputId = "select_species", 
            label = "Select Species:", 
            choices = unique(iris$Species), 
            selected = c("setosa", "versicolor"), 
            multiple = TRUE
          ), 
          
          shiny::br(), 
          
          shiny::fluidRow(
            
            shiny::column(
              width = 6, 
              
              # Bar Chart
              echarts4r::echarts4rOutput(
                outputId = "bar_chart"
              )
              
            ), 
            
            shiny::column(
              width = 6, 
              
              # Line Chart
              echarts4r::echarts4rOutput(
                outputId = "line_chart"
              )
              
            )
            
          )
          
        ), 
        
        shiny::tabPanel(
          title = "Heatmap", 
          
          shiny::br(), 
          
          # Heatmap
          echarts4r::echarts4rOutput(
            outputId = "heatmap"
          ), 
          
          shiny::br(), 
            
          reactable::reactableOutput(
            outputId = "table", 
            height = "251px"
          )
          
        )
        
      )
      
    )
    
  )
  
)

server <- function(input, output, session) {
  
  # Filtered data based upon the user-selected "Species" type
  chart_data <- shiny::reactive({
    
    iris |> 
      dplyr::filter(Species %in% input$select_species) |> 
      dplyr::select(Sepal.Length, Species) |> 
      dplyr::group_by(Species) |> 
      dplyr::summarise(
        mean_Sepal.Length = mean(Sepal.Length), 
        .groups = "drop"
      )
    
  })
  
  # Render the Bar Chart
  output$bar_chart <- echarts4r::renderEcharts4r({
    
    chart_data() |> 
      echarts4r::e_chart(
        x = Species, 
      ) |> 
      echarts4r::e_bar(
        serie = mean_Sepal.Length, 
        name = "Mean Sepal Length"
      ) |> 
      echarts4r::e_flip_coords()
    
  })
  
  # Render the Line Chart
  output$line_chart <- echarts4r::renderEcharts4r({
    
    chart_data() |> 
      echarts4r::e_chart(
        x = Species, 
      ) |> 
      echarts4r::e_line(
        serie = mean_Sepal.Length, 
        name = "Mean Sepal Length"
      )
    
  })
  
  # Render the Heatmap
  output$heatmap <- echarts4r::renderEcharts4r({
    
    heatmap_data |> 
      dplyr::group_by(Group, Species) |> 
      dplyr::summarise(
        sum_Petal.Width = sum(Petal.Width), 
        .groups = "drop"
      ) |> 
      echarts4r::e_charts(x = Group) |> 
      echarts4r::e_heatmap(
        y = Species, 
        z = sum_Petal.Width
      ) |> 
      echarts4r::e_visual_map(
        serie = sum_Petal.Width, 
        show = FALSE   # hide the big gradient legend thing
      ) |> 
      echarts4r::e_title(
        text = "Sum of Petal Width", 
        subtext = "by Group & Species"
      ) |> 
      echarts4r::e_tooltip(
        trigger = "item", 
        formatter = htmlwidgets::JS(
          "
          function(params){
            return(
              'Group: ' + params.value[0] + '<br />' + 
              'Species: ' + params.value[1] + '<br />' + 
              params.marker + 'Sum of Petal Width: <strong>' + params.value[2] + '</strong>'
            )
          }
          "
        )
      )
    
  })
  
  # Grab the data in the cell that the user clicked on
  selected <- shiny::eventReactive(input$heatmap_clicked_data, {
    
    list(
      Group = input$heatmap_clicked_data$value[1], 
      Species = input$heatmap_clicked_data$value[2]
    )

  })
  
  # Build the reactive table
  output$table <- reactable::renderReactable({
    
    shiny::req(selected())
    
    heatmap_data |> 
      dplyr::filter(
        Group == selected()$Group, 
        Species == selected()$Species
      ) |> 
      reactable::reactable(defaultPageSize = 5)
    
  })
  
  
}

shinyApp(ui, server)