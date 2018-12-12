# Weather_Station_Data_Summary

## Description of overall project:
For my thesis I am attempting to include species specific impacts on water balance modeling by identifying species differences in water management strategies at the crown level. Leveraging an existing 50-100% throughfall exclusion (Tfe) experiment, as well as strategically placed time-lapse cameras and light sensors, I will measure species specific crown architecture and light attenuation to develop crown-integrated solar radiation terms for water balance modeling. My hope is to improve water balance modeling accuracy at Elizabeth Wood’s, located south of Morgantown, WV, by incorporating measured light attenuation and solar radiation terms relative to individual species to into a dynamic water balance model method.  

## Purpose of this script:
Water balance models account for both factors of supply and demand by incorporating climatic, topographic, and edaphic variables. To collect relevant climatic data, I have set up a weather station in an open field north of my study plots South of Morgantown, WV. This station utilizes LOGGERNET technology to store data for download including precipitation, temperature, wind speed, relative humidity, and solar radiation. The output format is comma-separated values.

### 1) Objectives:
a. To automate the summarization process of data collected daily at Elizabeth Woods in preparation for use in a water balance model. Summaries necessary include daily averages and daily sums. Since my water balance model is run on a bi-weekly timestep it will also be necessary to have bi-weekly sums and averages.  

_I believe this will only take a couple lines of code in base R.  See https://stackoverflow.com/questions/37575785/r-group-by-date-and-summarize-the-values_

b. Output visuals to display changes in weather conditions throughout the growing season
_This is interesting and has the potential for an R-Shiny.  Given that the data summary part will be straightforward, you need to think about how to expand this project (for class). R-Shiny is one way to share your results and allow others to explore your data online.  Another option would be to generalize the problem 1a above.  For example, what if you wrote a function that takes the air csv and given a series of arguments, summarizes it for any time step and any variable then returns a table and a figure for up to date data?  This could also be an R-Shiny._

### 2) Data Sources:
a. Data is collected directly from the site and located within this repo.

b. Includes temperature (°C), relative humidity (%), precipitation (mm), solar irradiance (W/m^2), wind speed (m/s).

c. Data is in .csv format with one file containing all the season's data.
-Temperature and relative humidity are stored in the same file titled “Air”

d. All data was collected between 13 July 2018 through 22 September 2018

### 3) Implementation:
I have been exploring different options for summarizing my data. The possibilities include a mix of the dplyr and ggplot packages in R and the mutate function to create a new column to populate with the summarize function. Another options is possibly using the zoo package's aggregate function. HydroTSM package won't be used because I am attempting to develop a script that can be used to summarize all the different data types and the package seems geared at hydrology data over extended periods of time.

I have learned it is necessary to use as.POSIXct() for dealing with date and time formatting as it accounts for time, date, and timezone. This step is reflected in the script as it currently stands.  

#### Resources utilized:

[Overall Zoo Help Doc](https://cran.r-project.org/web/packages/zoo/zoo.pd)

[Zoo.aggregate Help](https://www.rdocumentation.org/packages/zoo/versions/1.7-9/topics/aggregate.zoo)

[POSIXct Data/Time Formatting](https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/as.POSIX*)

## Expected Products:
I expect that at the end of this project I will have a .csv file with the daily and bi-weekly sums for precipitation and solar irradiance as well as files containing the daily means for temperature, relative humidity, and wind speed. _As you move forward, you may begin to see these 'products' as disposable - the real product is the script that will produce tables, flatfiles or figures_ 

## Questions for instructor:
Are there other packages and functions that I should be exploring? I know you mentioned something about tidyr, but that isn't used for aggregation. Perhaps I can use it to tidy the data prior to my other work? _aggregate is the base R implementation you need!_

When we were working in the shell we used variables and then would bash with the desired input. I would like to do that with my code if possible. So that would be bashing through R? This part is a little unclear for me still. _this is what we call a 'function' in R.  All the commands we use in R are acutally functions.  We will learn to write our own soon._

## CODE To-Date (10-25-2018):
#Weather Station Data summarization

rm(list=ls()) #clears environment of previous work

#activate necessary libraries

library(zoo)
library(ggplot2)
library(dplyr)

#setting the working directory.

setwd("N:/Weather_Station")

#reads in Precip, excludes columns with datalogger info but no data

Precip<-read.csv("Precip_9-22-18_2018.csv")[,1:3]

#checking for other columns and rows to be excluded

head(Precip)

nrow(Precip)

#excludes rows with datalogger information

Precip <- Precip[4:10212,]

#creates POSIXct object with the dates and time in EST.

td_precip<-as.POSIXct(Precip$TOA5,format = "%Y-%m-%d %H:%M:%S",tz="EST")

#create the vector with the precipitation values

precip1<-as.numeric(as.vector(Precip$CR6))

### Acknowledgements: 
Luis Andres Guillen and Nanette Raczka, my co-workesr on the Elizabeth Woods TfE experiment, as well as our advisors Dr. Brenden McNeil, Dr. Nicolas Zegre, and Dr. Edward Brzostek. Also, Dr. Amy Hessl for her un-paralleled patience in this learning process.    
