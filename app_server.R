library("dplyr")
source("scripts/build_leaflet.R")
source("scripts/build_heatmap.R")

# reads data for insight graph1
crimes <- read.csv("data/chicago_crime_10y.csv")

# reads data for insight graph 2
top_ten_committed_crime <- read.csv("data/top10.csv")

# reads data for insight graph 3
crime_summary_table <- read.csv("data/crime_summary.csv")

# reads data for heat map
chicago_crimes <- read.csv("./data/ccrime_10yrs.csv", stringsAsFactors = F)

# read data for bar chart 
cleaned_data <- read.csv("data/crime_freq_2019.csv")

recent_crime <- read.csv("data/crime2019.csv", stringsAsFactors = F)
#filtering out the rows of top 10 crime tpye without any NA
#coordinate value
top_10 <- group_by(recent_crime, Primary.Type) %>%
  summarise(ranking = n()) %>%
  top_n(10, ranking)
top_10_type <- filter(recent_crime, Primary.Type %in% top_10$Primary.Type,
                     !is.na(recent_crime$Longitude))
#filter down so data only from June
crime_june <- top_10_type %>%
  separate(Date, c("Month"), "/", extra = "drop") %>%
  filter(Month == "06")

server <-  function(input, output) {
  # Heat Map output
  output$plot <- renderPlot({
    return(build_heatmap(chicago_crimes, input))
  })
  
  # Map output
  output$the_map <- renderLeaflet({
    return(build_map(crime_june, input$type))
  })
  
  # Bar chart output 
  output$bar <- renderPlotly({
    
    plot_data <- cleaned_data %>%
      filter(Date == input$month_choice) %>%
      top_n(10, Crime.Frequency) %>% 
      arrange(-Crime.Frequency)
    
    p <- plot_ly(
      data = plot_data,
      x = ~Crime.Frequency,
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
  
  # Insight Graph 1 output 
  output$insightsgraph1 <-
    renderPlot({
      plotdata <- crimes %>%
        group_by(District)  %>%
        summarize(Count = n())
      plot <- ggplot(data = plotdata) +
        geom_col(mapping = aes(x = District, y = Count)) +
        theme(axis.text.x = element_text(size = 8, angle = 45, hjust = 1))
      return(plot)
    })
  
  # Insight Graph 2 output
  output$insightsgraph2 <-
    renderPlot({
      chart <- ggplot(top_ten_committed_crime) +
        geom_col(mapping = aes(x = reorder(Primary.Type, freq), y = freq)) +
        coord_flip() +
        labs(
          x = "Crime Types",
          y = "Frequency"
        )
      return(chart)
    })
  
  # Insight Graph 3 output 
  output$insightsgraph3 <-
    renderPlot({
      plotdata <- crime_summary_table %>%
        group_by(Location.Description) %>%
        summarise(crime_rate = n()) %>%
        arrange(desc( crime_rate)) %>%
        mutate(prop = round( ( (crime_rate / nrow(crime_summary_table)) * 100),
                             digits = 2))
      newrow <- plotdata[c(6:144), c(1:3)] %>%
        summarize(Location.Description = print("144 OTHERS"),
                  crime_rate = sum(crime_rate),
                  prop = sum(prop))
      df5 <- plotdata %>%
        head(5)
      newdf <- rbind(df5, newrow)
      pie <- ggplot(newdf, aes(x = "", y = prop, fill = Location.Description)) +
        geom_bar(width = 1, stat = "identity") +
        coord_polar("y", start = 0) +
        labs(y = "Percentage",
             x = "    ")
      return(pie)
    })
}
