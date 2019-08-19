
#import the packages and the API key for Google Map
library(ggplot2)
library(ggrepel)
library(tidyverse)
library(ggmap)
source("scripts/api_key_chicago_map_.R")

#Enabling google service by showing the api key
register_google(key = map_key)

#Draw a Chicago google map
base_map <- qmap("chicago", zoom = 12, maptype = "hybrid")

#read 2019 crime data for Chicago
recent_crime <- read.csv("data/Crimes_-_2019.csv")

#filtering out the rows of top 3 crime tpye without any NA
#coordinate value
top_3 <- group_by(recent_crime, Primary.Type) %>%
  summarise(ranking = n()) %>%
  top_n(3, ranking)
top_3_type <- filter(recent_crime, Primary.Type %in% top_3$Primary.Type,
                      !is.na(recent_crime$Longitude))

#plot the points on the Chicago map  
chart2 <- base_map +
  geom_point(data = top_3_type,
             aes(x = Longitude, y = Latitude, color = Primary.Type)
             , size = 0.9, alpha = 0.6) +
  scale_color_brewer(palette = "Set1")