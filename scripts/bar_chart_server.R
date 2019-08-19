library(shiny)
library(ggplot2)
library(plotly)

cleaned_data <- read.csv("data/crime_freq_2019.csv")
colnames(cleaned_data)

bar_chart_server <- function(input, output) {
  
  output$bar <- renderPlotly({
    
    plot_data <- data_cleaned %>%
      filter(Date == input$month_choice) %>%
      arrange(-`Crime Frequency`) %>%
      top_n(10)
    
    p <- plot_ly(
      data = plot_data,
      x = ~`Crime Frequency`,
      y = ~Primary.Type, 
      type = "bar",
      alpha = 0.7, 
      hovertext = "Number of crimes"
    ) %>%
      layout(
        title = paste0("The Top 10 Committed Crimes in the Chicago in ", input$month_choice),
        xaxis = list(title = "Number Of Crimes"),
        yaxis = list(title = "Crime Types")
    )
    p
    
  })
}

