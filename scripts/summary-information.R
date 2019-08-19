
# This dataset is not in the data/ because it's too big to push to the repo.
# Thus the following code are commented. 
# lint error shows that "commented code should be removed" but the code starts with ## 
# were used to sort the big and original dataset. 
# They need to be saved for future reference. 

# sort the dataframe and select the desirable columns and write into a new csv file. 
## read.csv("data/crime-summary.csv")
## df_new <- df %>%
  ## select(Location.Description, Arrest, Primary.Type) %>% 
  ## as.data.frame()
## df <- write.csv(df_new,"crime_summary.csv")

crime_summary <- read.csv("data/crime_summary.csv")

library("dplyr")
library("tidyr")

# create a function that takes a parameter and returns the a table. 
# In this case, the table shows the aggregate number of crime occurred 
# in different recorded typical locations and the percentage of proportion 
# relative to the total number of crime in the City of Chicago in the year of 2019.

get_summary_info <- function(dataset) {
  ret <- list()
  ret$total <- nrow(dataset)
  ret$arrest <- dataset %>%
    group_by(Arrest) %>%
    summarise(num = n()) %>%
    filter(Arrest == "true") %>%
    select(num) / nrow(dataset) * 100
  ret$arrest_rate <- round(ret$arrest, digits = 2)
  ret$most_Freq <- dataset %>%
    group_by(Primary.Type) %>%
    summarise(Freq = n()) %>%
    arrange(desc(Freq)) %>%
    head(1) %>%
    select(Primary.Type)
  ret$freq_crime <- dataset %>%
    group_by(Primary.Type) %>%
    summarise(Freq = n()) %>%
    arrange(desc(Freq)) %>%
    head(1) %>%
    select(Freq)
  ret$rate <- round( ( (ret$freq_crime / nrow(dataset)) * 100), digits = 2 )
  ret$LD <- dataset %>%
    group_by(Location.Description) %>%
    summarise(crime_rate = n()) %>%
    arrange(desc(crime_rate)) %>%
    head(1) %>%
    select(Location.Description)
  return (ret)
}