library("shiny")
library("ggplot2")
library("dplyr")
library("shinyWidgets")


chicago_crimes <- read.csv("./data/chicago_crime_10y_with_year.csv", stringsAsFactors = F)
# source("./scripts/plot_heat.R")

# define year range
year_range <- range(chicago_crimes$Year)

# # define select_values for selectInput()
# select_values <- c(chicago_crimes$District, chicago_crimes$Primary.Type)

# define year_input properties for a slider
year_input <- sliderInput(
  inputId = "year_choice",
  label = "Year of Crime Committed",
  min = year_range[1],
  max = year_range[2],
  value = year_range,
  step = 1,
  round = 0
)

# Define a variable `district_input` that is a `selectInput()` with the
# label "District of Interest"
district_input <- selectInput(
  inputId = "district_feature",
  label = "District of Interest",
  choices = c('All', unique(chicago_crimes$District[!is.na(chicago_crimes$District)])),
  selected = "All"
)

# Define a variable `type_input` that is a `selectInput()` with the
# label "Feature of Interest"
# type_input <- selectInput(
#   inputId = "type_feature",
#   label = "Crimw Type of Interest",
#   choices = unique(chicago_crimes$Primary.Type),
#   selected = "BATTERY"
# )

###########################################

# define a UI
ui <- fluidPage(
  setSliderColor(c("DarkViolet"), c(1)),
  titlePanel("Districts in Chicago, Crime Type, and Year Crime Committed Explorer"),
  district_input,
  # type_input,
  # checkboxInput("with_log", label = strong("Takeing logarithm"), value = TRUE),
  materialSwitch(inputId = "with_log", label = strong("Taking logarithm"), status = "success", value = TRUE),
  plotOutput("plot"),
  year_input
)


###########################################

# define server function
server <- function(input, output) {
    output$plot <- renderPlot({
      if (input$district_feature != 'All') {
        plot_data <- chicago_crimes %>%
          filter(Year > input$year_choice[1], Year < input$year_choice[2]) %>%
          filter(District == input$district_feature) %>%
          mutate(Community.Area = paste0(Community.Area)) %>%
          group_by(Community.Area, Primary.Type)  %>%
          summarize(Crime.count = n())
        
        # creates a plot for district_feature
        p <- ggplot(data = plot_data, aes(x = Community.Area, y = Primary.Type))
      } else {
        plot_data <- chicago_crimes %>%
          filter(Year > input$year_choice[1], Year < input$year_choice[2]) %>%
          group_by(District, Primary.Type)  %>%
          summarize(Crime.count = n())
        
        # creates a plot for district_feature
        p <- ggplot(data = plot_data, aes(x = District, y = Primary.Type))
      }
      
      p <- p +
        geom_tile(aes(fill = Crime.count)) +
        scale_fill_gradient2() +
        theme(axis.text.y = element_text(size = 6)) +
        theme(axis.text.x = element_text(size = 7, angle = 45, hjust = 1))
    
      # Finally, if the "trendline" checkbox is selected, you should add (+)
      # a geom_smooth geometry (with `se=FALSE`) to your plot
      # Hint: use an if statement to see if you need to add more geoms to the plot
      
      if (input$with_log) {
        p <- p + scale_fill_gradient2(trans = "log")
      }
      
      # p <- ggplotly(p)
      
      return(p)
    }
  )
}

# Create a new `shinyApp()` using the above ui and server
shinyApp(ui = ui, server = server)



  
  
  
  
  
  
  
  
  
