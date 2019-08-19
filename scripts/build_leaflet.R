
library(ggplot2)
library(ggrepel)
library(tidyverse)
library(ggmap)
library(leaflet)
build_map <- function(data_crime, var) {
  leaflet(data = data_crime %>% filter(Primary.Type ==
                                         var)) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -87.7, lat = 41.85, zoom = 11) %>%
    addCircleMarkers(
      lat = ~Latitude,
      lng = ~Longitude,
      stroke = FALSE,
      popup = ~paste("Arrest", Arrest, "<br>",
                     "Desciption : ", Description, "<br>",
                     "Type : ", Primary.Type, "<br>",
                     "Block : ", Block, "<br>",
                     "Location : ", Location.Description),
      radius = 3.5,
      opacity = 0.8,
      fillOpacity = 0.3,
      color = "red"
    )
}