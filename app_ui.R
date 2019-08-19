library("shiny")
library("shinydashboard")
library("shinyWidgets")
library(ggplot2)
library(ggrepel)
library(tidyverse)
library(ggmap)
library(plotly)
library(leaflet)

# write the header part of the DashboardPage
# lint error says lines should not be more than 80 charcters but here the link is to the github page.
header <- dashboardHeader(title = "Crime and Location",
                          dropdownMenu(type = "notifications",
                                       icon = icon("github"),
                                       badgeStatus = NULL,
                                       headerText = "Check Us Out",
                                       notificationItem(
                                         "Github", icon = icon("github"),
                                         href = "https://github.com/info201a-sum2019/final-project-mightymango")
                          )
                          )

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Introduction",
             tabName = "introduction", icon = icon("clipboard-list")),
    menuItem("Overall Crimes",
             tabName = "heatmap", icon = icon("align-center")),
    menuItem("Crimes Disctribution",
             tabName = "interactive_map", icon = icon("map-marked-alt")),
    menuItem("Most Committed Crimes",
             tabName = "barchart", icon = icon("align-left")),
    menuItem("Our Insights",
             tabName = "Conclusion", icon = icon("book-reader"))
  )
)



###################### Begin Heatmap Components ######################

# define year range
year_range <- range(chicago_crimes$Year)

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
  choices = c("All",
              unique(chicago_crimes$District[!is.na(chicago_crimes$District)])),
  selected = "All"
)

# define a UI
heatmapUI <- fluidPage(
  setSliderColor(c("DarkViolet"), c(1)),
  titlePanel("Overall Chicago Crimes Over The Past 10 Years"),
  district_input,
  materialSwitch(
    inputId = "with_log",
    label = strong("Taking logarithm"),
    status = "success",
    value = TRUE),
  plotOutput("plot"),
  year_input,
  includeHTML("www/chart2text.html")
)

###################### End Heatmap Components ######################



###################### Begin of leaflet ############################

my_ui <- fluidPage(
  selectInput(
    inputId = "type",
    label = "Type of Crimes",
    choices = c("Battery" = "BATTERY",
                "Criminal Damage" = "CRIMINAL DAMAGE"
                , "Theft" = "THEFT", "Burglary" = "BURGLARY",
                "Deceptive Practice" = "DECEPTIVE PRACTICE",
                "Motor Vehicle Theft" = "MOTOR VEHICLE THEFT",
                "Narcotics" = "NARCOTICS", "Other Offense" =
                  "OTHER OFFENSE", "Robbery" = "ROBBERY")
  ),
  leafletOutput("the_map", height = 600), 
  includeHTML("www/map explain.html")
)
###################### End of leaflet ############################



###################### Begin of Bar Chart ############################

data_cleaned <- read.csv("data/crime_freq_2019.csv")

feature_input <- selectInput(
  inputId = "month_choice",
  label = "Select the month",
  choices = unique(data_cleaned$Date), 
  selected = "January"
)

bar_chart_ui <- fluidPage(
  titlePanel("Top 10 Committed Crimes in Chicago in 2019"),
  feature_input, 
  plotlyOutput(outputId = "bar"),
  includeHTML("./www/bar_chart_explain.html")
)

###################### End of Bar Chart ##############################
# write the body part of the dashboardPage and render the graphs and boxs of the "Conclusion Page" here 
# directly 

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "introduction",
      includeHTML("www/intro.html")
    ),
    tabItem(
      tabName = "heatmap",
      heatmapUI
    ),
    tabItem(
      tabName = "interactive_map",
      my_ui
    ),
    tabItem(
      tabName = "barchart",
      bar_chart_ui
    ),
    tabItem(tabName = "Conclusion",
            fluidRow(
              box(
                title =
                  "Crimes In Diffrent Districts
                in Chicago Over The Past 10 Years",
                status = "primary", solidHeader = TRUE,
                collapsible = FALSE,
                plotOutput("insightsgraph1")
              ),
              box(
                title =
                  "Top 10 Most Committed Crime Types
                in Chicago from 2009 to Present",
                status = "primary", solidHeader = TRUE,
                collapsible = FALSE,
                plotOutput("insightsgraph2")
              ),
              box(
                title =
                  "The Percentage of Crime Occurrence of Generic Locations",
                status = "primary", solidHeader = TRUE,
                collapsible = FALSE,
                plotOutput("insightsgraph3")
              ),
              box(
                title = "Our Interpretation",
                status = "warning", solidHeader = TRUE,
                collapsible = FALSE,
                includeHTML("www/insight.html")
              )
              )
            )
    )
  )
    
ui <- dashboardPage(
  skin = "blue",
  header,
  sidebar,
  body)
shinyUI(ui)
