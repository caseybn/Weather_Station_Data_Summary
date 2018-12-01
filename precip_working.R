#Weather Station Data
rm(list=ls())

library(ggplot2)
library(plyr) #load plyr first to reduce problems when running dplyr
library(dplyr)

Precip<-read.csv("DATA/Precip_9-22-18_2018.csv")[,1:3] #reads in Precip, excludes columns with datalogger info but no data
Precip <- Precip[4:10212,] #excludes rows with datalogger information


#Renaming columns to something meaningful
names(Precip)[colnames(Precip)=="CR6"] <- "Precipitation"
names(Precip)[colnames(Precip)=="TOA5"] <- "Date_Time"

#Create simple date column where time is not included
Precip$date <- as.Date(Precip$Date_Time)

Precip$Precipitation <- as.numeric(Precip$Precipitation)

by_day <- Precip %>% group_by(date) %>% summarise(p_sum = sum(Precipitation))

bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84)]

by_day$biwe <- bi_seq

by_biweek <- by_day %>% group_by(biwe) %>% summarise(p_sum_mm = sum(p_sum))




#Things tried but not figured out
# MUTATE https://www.earthdatascience.org/courses/earth-analytics/time-series-data/summarize-time-series-by-month-in-r/

# AGGREGATE 
#aggregate(Precip$Precipitation, by=list(Precip$date), sum)


