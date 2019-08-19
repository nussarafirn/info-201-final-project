library(shiny)
library(ggplot2)
library(plotly)

data_cleaned <- read.csv("data/crime_freq_2019.csv")

feature_input <- selectInput(
  inputId = "month_choice",
  label = "Select the month",
  choices = unique(data_cleaned$Date), 
  selected = "January"
)

bar_chart_ui <- fluidPage(
  titlePanel("Top 10 Committed Crimes in  Chicago in 2019"),
  feature_input, 
  plotlyOutput(outputId = "bar")
)

