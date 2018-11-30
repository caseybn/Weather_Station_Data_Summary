#Weather Station Data
rm(list=ls())

library(ggplot2)
library(plyr) #load plyr first to reduce problems when running dplyr
library(dplyr)
library(lubridate)
options(stringsAsFactors = FALSE)

Precip<-read.csv("DATA/Precip_9-22-18_2018.csv")[,1:3] #reads in Precip, excludes columns with datalogger info but no data
head(Precip)
nrow(Precip)
Precip <- Precip[4:10212,] #excludes rows with datalogger information
head(Precip)
str(Precip)

#Renaming columns to something meaningful
names(Precip)[colnames(Precip)=="CR6"] <- "Precipitation" 
names(Precip)[colnames(Precip)=="TOA5"] <- "Date_Time"

#Create simple date column where time is not included
Precip$date <- as.Date(Precip$Date_Time)

# MUTATE https://www.earthdatascience.org/courses/earth-analytics/time-series-data/summarize-time-series-by-month-in-r/
mutate(DATE = as.Date(Precip$Date_Time))



Precip1 <- as.numeric(as.character(Precip$Precipitation)) #creates vector with precipitation values

Precip$seg <- rep(1:7, each= 14)

# AGGREGATE 
aggregate(Precip$Precipitation, by=list(Precip$date), sum)


