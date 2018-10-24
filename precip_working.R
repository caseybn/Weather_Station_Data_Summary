#Weather Station Data
rm(list=ls())

library(zoo)
library(ggplot2)
library(dplyr)
options(stringsAsFactors = FALSE)

setwd("N:/Weather_Station") # setting the working directory. 
Precip<-read.csv("Precip_9-22-18_2018.csv")[,1:3] #reads in Precip, excludes columns with datalogger info but no data
head(Precip)
nrow(Precip)
Precip <- Precip[4:10212,] #excludes rows with datalogger information
head(Precip)
str(Precip)

td_precip<-as.POSIXct(Precip$TOA5,format = "%Y-%m-%d %H:%M:%S",tz="EST") #creates POSIXct object with the dates and time (30 in timestep). 
#All times in EST. POSIXct handles dates, times, and timezones so it was selected for this exercise 
p1<-as.numeric(as.vector(Precip$CR6))#create the vector with the precipitation values
str(td_precip)

#zoo vs hydroTSM because hydroTSM is geared at long term timeseries data