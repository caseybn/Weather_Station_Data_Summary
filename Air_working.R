#Weather Station Data
rm(list=ls())

library(ggplot2)
library(dplyr)

air <- read.csv("DATA/air_9-22-18_2018.csv")[,1:4] #reads in Precip, excludes columns with datalogger info but no data

air <- air[4:1704,] #excludes rows with datalogger information. Use head() and nrow() to determine range

#Renaming columns to something meaningful
names(air)[colnames(air)=="TOA5"] <- "Date_Time"
names(air)[colnames(air)=="CR6"] <- "Temp"
names(air)[colnames(air)=="X3767"] <- "RH"

#Create simple date column where time is not included
air$date <- as.Date(air$Date_Time)

air$Temp <- as.numeric(air$Temp) #converts Temp column from character to number
air$RH <- as.numeric(air$RH) #converts RH column from character to number

by_day <- air %>% group_by(date) %>% summarise(t_mean = mean(Temp),RH_mean = mean(RH)) #calculates the daily averages

bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84)] #creates a bi-weekly sequence, excluding extra sequence records

by_day$biwe <- bi_seq #adds sequence as column into daily means

by_biweek.csv <- by_day %>% group_by(biwe) %>% summarise(t_mean = mean(t_mean),RH_mean = mean(RH_mean)) #calculates bi-weekly means
