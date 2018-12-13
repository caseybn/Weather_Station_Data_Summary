# Weather Station Data Summary

## Contents
- Overall Project Description
- Weather Station code purpose/ rationale 
  - Objectives
  - Data Sources
- Implementation
  - Getting Started 
  - Products
  - Challenges
- Resources
- Acknowledgments

## Description of overall project:
For my thesis I am attempting to include species specific impacts on water balance modeling by identifying species differences in water management strategies at the crown level. Leveraging an existing 50-100% throughfall exclusion (Tfe) experiment, as well as strategically placed time-lapse cameras and light sensors, I will measure species specific crown architecture and light attenuation to develop crown-integrated solar radiation terms for water balance modeling. My hope is to improve water balance modeling accuracy at Elizabeth Wood’s, located south of Morgantown, WV, by incorporating measured light attenuation and solar radiation terms relative to individual species to into a dynamic water balance model method.  

## Purpose of this script:
Water balance models account for both factors of supply and demand by incorporating climatic, topographic, and edaphic variables. To collect relevant climatic data, I have set up a weather station in an open field north of my study plots South of Morgantown, WV (**Image 1**). This station utilizes LOGGERNET technology to store data for download including precipitation, temperature, wind speed, relative humidity, and solar radiation. The output format is comma-separated values.

![alt text](https://github.com/caseybn/Weather_Station_Data_Summary/blob/master/Pictures/Weather_Station.jpg)
**Image 1**: Setting up the weather station during what turned out to be "normal" weather conditions this season. 

### 1) Objectives:
a. To automate the clean-up and summarization process of data collected daily at Elizabeth Woods in preparation for use in a water balance model. Summaries necessary include daily averages and daily sums. I have chosen to run my water balance model on a bi-weekly timestep it will also be necessary to obtain bi-weekly sums and averages as well.  

b. Output visuals to display changes in weather conditions throughout the growing season

c. **IN PROGRESS** ~~Produce a "Shiny" interface to include online, interactive comparisons of climatic data collected at Elizabeth Woods. Find a way to link this to the live weather station data.~~ Note: in the future I hope to get this working. The skill is currently over my head and time to learn to limited for the deadline of this project. This would be useful to produce interactive comparisions of data throughout the years. 

### 2) Data Sources:
a. Data is collected directly from the site and located within this repo.

b. Includes temperature (°C), relative humidity (%), precipitation (mm), solar irradiance (W/m^2), wind speed (m/s).

c. Data is in .csv format with one file containing all the season's data. Data was collected at different time-steps so the number of records varies depending on the variable being considered.
-Temperature and relative humidity are stored in the same file titled “Air”, so the datafile was duplicated so that "Air2" could be used to summarize relative humidity in the function.

d. All data was collected between 13 July 2018 through 22 September 2018

e. Data output is "messy" with various logger information included and data collected for other collaborators but not necessary for my model (**Image 2**), data headers also vary greatly and with little consistency within the reported data. 
![alt text](https://github.com/caseybn/Weather_Station_Data_Summary/blob/master/Pictures/Messy_data_example.PNG)
**Image 2**: An example of pre-processed, raw data. Headers vary from one file to the next as well as number of records, and number of columns with logger information included.  


## 3) Implementation:
This code should be ran through the Weather_Station_Data_Summary RProject. Data for summarization is stored in th "Raw" folder within the "Data" folder. Outputs are designed to be sent to the "sum" folder.

### Getting Start
Most of the script is completed using baseR or dpylr. Shiny and shinydashboard are incorportated to bring the data online. It is necesary to install the following packages by "install.package()":

-"dplyr"

-"shiny"

-"shinydashboard"
### Products:
- A .csv file with the daily and bi-weekly summaries for precipitation and solar irradiance as well the daily and biweekly means for temperature, relative humidity, and wind speed. These were produced soley for data exchange.
- A script that can be used to update weather station summaries in the future and generate tables and graphs for use in modeling
```R
#Weather Station Data

#Clears environment
rm(list=ls())

#load necessary libraries
library(dplyr)
library(shiny)
library(shinydashboard)

#Create a vector of files to be summarized
files <- list.files("./DATA/Raw")

#Sets source for function
source("Functions/CR6_Function.R")


#applies function across list of desired files 
mylist <- lapply(files, my_station_function)

#binds the colums from the function output into one dataframe and excludes repeated date columsn
graph <- do.call(cbind, mylist)
graph <- graph[(3:65), -c(3,5,7,9)]


#Plots daily data for viewing seasonal changes
par(mfrow=c(3,2))
plot(type = "l", graph$Date, graph$p_sum, main="Daily Precipitation", ylab = "Precipitation(mm)", xlab = "Date")
plot(type = "l", graph$Date, graph$s_sum, main="Daily Solar Radiation", ylab = "Global Solar Radation(W/m^2)", xlab = "Date")
plot(type = "l", graph$Date, graph$T_mean, main="Average Daily Temperature", ylab = "Temperature(°C)", xlab = "Date")
plot(type = "l", graph$Date, graph$RH_mean, main="Average Daily Relative Humidity", ylab = "Relative Humidity(%))", xlab = "Date")
plot(type = "l", graph$Date, graph$WS_mean, main="Average Daily Wind Speed", ylab = "Wind Speed (m/s)", xlab = "Date")
```
- Example of graphing outputs
![alt text](https://github.com/caseybn/Weather_Station_Data_Summary/blob/master/Pictures/Station_Daily_Graphs.png)
**Image 3** Visual representation of different variables throughout the 2018 growing season

### Challenges
- Grouping by date is difficult. It is first necessary to convert the Date-Time to just date, and then group by day.
  ```R
  climate_sum$Date <- as.Date(climate_sum$Date_Time)
  ```
- The grouping by date challenges make summarizing by by-weekly more difficult. The function to complete this process is complex as each piece builds off the next piece. 
```R 
my_station_function <- function(climate_var){
  climate_sum <- read.csv2(file= paste0("DATA/Raw/", climate_var), header = FALSE, sep = ",", skip = 4) #reads in .csv files, excluding the first 4 lines of datalogger info
  names(climate_sum)[colnames(climate_sum)=="V1"] <- "Date_Time" #renames appropriate column including the "Date_Time"
  climate_sum$Date <- as.Date(climate_sum$Date_Time) #creates column containing only the date with no time
  if (climate_var == "Precip.csv") { #if the variable is precip...
    names(climate_sum)[colnames(climate_sum)=="V3"] <- "Precip" #names appropriate column precipitation 
    climate_sum$Precip <- as.numeric(as.character(climate_sum$Precip)) # converts the precip column to numeric while maintaining its value for summarization
    by_day <- climate_sum %>% group_by(Date) %>% summarise(p_sum = sum(Precip)) #sum of precip by day
    write.csv(by_day, file = "DATA/Sum/Precip_daily_sums.csv") #writing results out for sharing
    bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84)] #biweekly sequence, created from the number of rows and excluding the portion of the sequence without a data record
    by_day$biwe <- bi_seq #adding the sequence as a new column in the daily summary dataframe
    by_biweek <- by_day %>% group_by(biwe) %>% summarise(p_sum_mm = sum(p_sum)) #by-weekly sum of precip using sequence
    write.csv(by_biweek, file = "DATA/Sum/Precip_biweekly_sums.csv") #write results out for sharing
    assign("Precip_daily", by_day[,-3], envir = .GlobalEnv) #assign daily values dataframe to the global environment for graphing 
  } else if... #unique for each variable.
  ```
- It is necessary to rid the files of the logger information stored within the first 4 rows to complete the necessary summarizations. This makes it diffcult to accurately label the column headers without great attention to detail during the "clean-up" process. 
- I had to include .csv in the function as I could not sucessfully remove it from the list without breaking the connection to the data itself. 

#### Resources utilized:
[dplyr: summarise, group by, etc.](https://bookdown.org/ndphillips/YaRrr/dplyr.html)

[Overall R help](ttps://r4ds.had.co.nz/introduction.html)

[Shiny Tutorial](http://rstudio.github.io/shiny/tutorial/#welcome)

[Shiny Basics](https://shiny.rstudio.com/articles/basics.html)

[Shiny Build](https://shiny.rstudio.com/articles/build.html)

#### Acknowledgements: 
Luis Andres Guillen and Nanette Raczka, my co-workesr on the Elizabeth Woods TfE experiment, as well as our advisors Dr. Brenden McNeil, Dr. Nicolas Zegre, and Dr. Edward Brzostek. Also, Dr. Amy Hessl for her un-paralleled patience in this learning process.    
