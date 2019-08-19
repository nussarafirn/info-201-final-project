library("ggplot2")
library("dplyr")

build_heatmap <- function(data, input) {
  if (input$district_feature != "All") {
    plot_data <- data %>%
      filter(Year > input$year_choice[1], Year < input$year_choice[2]) %>%
      filter(District == input$district_feature) %>%
      mutate(Community.Area = paste0(Community.Area)) %>%
      group_by(Community.Area, Primary.Type) %>%
      summarize(Crime.count = n())

    # creates a plot for district_feature
    p <- ggplot(data = plot_data, aes(x = Community.Area, y = Primary.Type))
  } else {
    plot_data <- data %>%
      filter(Year > input$year_choice[1], Year < input$year_choice[2]) %>%
      group_by(District, Primary.Type) %>%
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

  return(p)
}
