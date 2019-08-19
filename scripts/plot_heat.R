library("dplyr")
library("ggplot2")

chicago_crime_10y <- read.csv("./data/chicago_crime_10y.csv")

#find number of each crime type
number_each_type <- chicago_crime_10y %>%
  group_by(District, Primary.Type)  %>%
  summarize(Crime.count = n())
number_each_type

#plot heatmap with a log of `Crime.count`
#able to see which crime type occured most offten
htmap_with_log <- ggplot(data = number_each_type,
                         aes(x = District, y = Primary.Type)) +
  geom_tile(aes(fill = Crime.count)) +
  scale_fill_gradient2(trans = "log") +
  theme(axis.text.y = element_text(size = 6)) +
  theme(axis.text.x = element_text(size = 7, angle = 45, hjust = 1))

htmap_with_log


#plot heatmap with a log of `Crime.count`
#able to see where crime type occur most offen
htmap_no_log <- ggplot(data = number_each_type,
                       aes(x = District, y = Primary.Type)) +
  geom_tile(aes(fill = Crime.count)) +
  scale_fill_gradient2() +
  theme(axis.text.y = element_text(size = 6)) +
  theme(axis.text.x = element_text(size = 7, angle = 45, hjust = 1))

htmap_no_log
