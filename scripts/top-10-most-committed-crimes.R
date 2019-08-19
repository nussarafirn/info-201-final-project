library(dplyr)
library(ggplot2)

# access the complete version of the dataset
# this file is too big to be pushed up to the git repo
# the following codes are meant for cleaning this data to be usable and pushable

#full_data_df <- read.csv("Crimes_-_2001_to_present.csv")

# clean the dataset so it only contains the types of the crimes committed after 2009
# return a summarized dataframe about the types of crimes

# crime_data_2009_to_present <- full_data_df %>%
  # fi
# lter(Year >= 2009) %>%
  # group_by(Primary.Type) %>%
  # summarise(freq = n())

# arrange the summarized dataframe according to the frequency from high to low
# select the top ten rows to be displayed

# top_ten_committed_crime <- crime_data_2009_to_present %>%
  # arrange(-freq) %>%
  # top_n(10)

# saved the cleanned summarized dataframe as a csv file
# this csv file is the one that we will push up to the repo

# lint error shows that "commented code should be removed" but the code above
# was used to sort the original dataset that are too big to be pushed to repo
# They need to be saved for future reference.

# write.csv(top_ten_committed_crime,
          # "top-10-committed-crime-chicago-2009-present.csv")
top_ten_committed_crime <- read.csv("data/top-10-committed-crime-chicago-2009-present.csv")

# Plot the dataframe as a horizontal bar chart
chart <- ggplot(top_ten_committed_crime) +
  geom_col(mapping = aes(x = reorder(Primary.Type, freq), y = freq)) +
  coord_flip() +
  labs(
    x = "Crime Types",
    y = "Frequency",
    title = "Top 10 Most Committed Crime Types in Chicago from 2009 to Present"
  )
