
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

# read the data file

library("dplyr")
crime_summary <- read.csv("data/crime_summary.csv")

# create a function that takes in a parameter and return the five pre-determined values.
# In this case, these values are the the total number of incidents occured, 
# the arrest rate relative to that, the most frequently occured crime, 
# and its percentage relative to the total number of crime and the location 
# that has the highest crime rate.

get_summary_table <- function(dataset) {
  get_summary <- dataset %>%
    group_by(Location.Description) %>%
    summarise(crime_rate = n()) %>%
    arrange(desc(crime_rate)) %>%
    mutate(prop = round( ( (crime_rate / nrow(dataset)) * 100),
                         digits = 2) ) %>%
    head(20)
  return(get_summary)
}

