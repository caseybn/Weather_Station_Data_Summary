#Weather Station Data
rm(list=ls())

library(zoo)
library(ggplot2)
library(dplyr)
library(plyr)

Precip<-read.csv("N:/Weather_Station/Weather_Station_Data_Summary/DATA/Precip_9-22-18_2018.csv")[,1:3] #reads in Precip, excludes columns with datalogger info but no data
head(Precip)
nrow(Precip)
Precip <- Precip[4:10212,] #excludes rows with datalogger information
head(Precip)
str(Precip)

#Renaming columns to something meaningful
names(Precip)[colnames(Precip)=="CR6"] <- "Precipitation" 
names(Precip)[colnames(Precip)=="TOA5"] <- "Date_Time"
Precip1 <- as.numeric(as.character(Precip$Precipitation))

#td_precip<-as.POSIXct(Precip$TOA5,format = "%Y-%m-%d %H:%M:%S",tz="EST") #creates POSIXct object with the dates and time (30 in timestep). 
#All times in EST. POSIXct handles dates, times, and timezones so it was selected for this exercise 
#precip1<-as.numeric(as.vector(Precip$CR6))#create the vector with the precipitation values
#str(td_precip)

Precip$date <- as.Date(Precip1$Date_Time)

aggregate(Precip$Precipitation, by=list(Precip$date), sum)

