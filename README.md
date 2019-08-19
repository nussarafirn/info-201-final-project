# **Final Project**
_this is a clone from the private repository of INFO 201 final project in collaboration with Hongfei Lin (@hfl22-1838397), Yinzhou Wang (@wyzxxywl), Jie Bai (@baij555)_

- [mid-point delivery](https://nussarafirn.github.io/info-201-final-project/scripts/)
- [final delivery](https://mightymango.shinyapps.io/final-project-mightymango/)

## Domain of Interest

* **Why are you interested in this field/domain?**

    Eventhough crime data may kept confidential due to people's privacy, we are interested to make the best use of open datasets to promote awareness of personal safety. Our hope is to find data particularly related to _Seattle or Washington_ area. We then would visualize and identify high risk crime areas informing UW students and our neighbors.

* **What other examples of data driven project have you found related to this domain?**
    - [Crime Data Explorer](https://crime-data-explorer.fr.cloud.gov) , a government driven project, shows a geovisualization on various sets of data including _crime, arrest, police employment, population and etc._ in different states in the US from 2007-2017. Users can select data collection from the drop down menu to see a broad range of statistics of crime such as _victim demographics, crime offense characteristics, and comparison between the national average and the selected states._
    - [CrimeReport](https://www.crimereports.com), an interactive map showing the locations where crimes occur during the selected range of time. Different icons represent different types of crime. Users can click on the icons for further detailed information about that crime, including time of occurrence, case number, responsible agencies, and a brief description of each case.

    - [Mug Shot](https://mugshots.tampabay.com) serves as a _crime search engine_. By putting a name into the searching bar or selecting from one of the six categories (county, age, height, weight, eyes, genders), the pictures and information of the criminals will show up. The website also provides a summary of the information of criminals based on _county, age, height, weight, eyes, and genders._

* **What data-driven questions do you hope to answer and communicate about this domain?**
    - What the _location_ which crime occurred most frequently in a city suggests?
      - The CrimeReport map shows that, in Seattle for example, crime is concentrated around downtown area. And that could suggest the correlation between crime rate and population density. Though more study would be needed if to research that correlation.
    - What is the _largest age range of women_ who committed crime in Tampa Bay area?
      - This question can be answered by using the filter under the drop down menu on the left-hand side. They also shows a bar graph for a quick full summary as well.
    - Which of the crime types happened the _most and least frequent_ in a city?
      - The CrimeReport Map categorizes incidents into three types (violent, property, quality of life) and use three graphs to show the trends for each type of the incident. By clicking one of the incident types, user can filter the selected type of incidents on the map, and we can have a very good visualization on what type of incident occur at where.


## Crime Data
### Dataset one: Seattle Crime Stats 2008-Present
- _City of Seattle_ publish the [Seattle Crime Stats](https://data.seattle.gov/Public-Safety/Seattle-Crime-Stats-by-Police-Precinct-2008-Presen/3xqu-vnum) from _2008 to present_ under the category of public safety in the City of Seattle Open Data Portal.
- This dataset is collected by the *Seattle Police Department*, each instance of data is collected when officers respond to an incident or crime. This dataset records the crimes with corresponding time, locations, types and etc.
- There are *27126* observations which are the frequencies of the incidents, and *8* features in the data, those features include types, the descriptions of the crimes, the date of the crime, the sector of the crime and corresponding precincts of the crime.
- The questions that we wish to answer is  
  - What are the locations where the crimes happened most frequent, where is least frequent in a city? What type of crime is most likely to occur in a specific location? And what that reflects about the area?

### Dataset two: Chicago Crimes - 2001 To Present
- _Chicago Police Department_ gathers [reported crime incidents](https://data.cityofchicago.org/Public-Safety/Crimes-2001-to-present/ijzp-q8t2) in the city _since 2001 to 2019_ in the Chicago Data Portal.
- This data is collected reported crimes in Chicago, which has been extracted with the exception of _murder data_ and as recent as _7 days ago_.
- This data consists with quite large data of total of _65531_ rows and _22_ columns. Rows give information of all the incidents of crimes. Meanwhile columns provide very detail information such as _the estimate date and time_, _whether or not criminals were arrested_, _whether these incidents are domestic violence_, or _even the exact latitude and longitude of location_.
- The questions that we wish to answer is
    - Which of the crime type happened the most and least frequent in a city?


### Dataset three: Federal Crime Data 2015
- _Uniform Crime Reporting program (UCR)_ is responsible for generating this [crime rate report](https://ucr.fbi.gov/crime-in-the-u.s/2015/crime-in-the-u.s.-2015/additional-reports/federal-crime-data/federal_crime_data_-2015) of year 2015 in the US.
- The data was collected from _US Department of Justice, Federal Bureau of Investigation_ and _Criminal Justice Information Division_, employee data and offenses with arrest data from the _FBI_, arrest data from the _Bureau of Alcohol, Tobacco, Firearms and Explosives (ATF)_ and other federal, state and local agencies. UCR generated the dataset based on the submission from other agencies. It's noteworthy that they focus primarily on producing open data on crimes that were most common and most likely to come to the attention of law enforcement. 3 of the total 12 separates files are included in the data files for this assignment.
- There are 30 observations and 6 features in each of the data files. The 3 data files included in folder data/ are all crime reports, featuring the fields of offices (states as units) and the population covered and the number of arrests.
- The questions that we wish to answer is
  - What the location (in this case, states) which crime occurred most frequently in the US suggests?
