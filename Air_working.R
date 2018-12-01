#Weather Station Data
rm(list=ls())

library(dplyr)
library(ggplot2)
library(ggthemes)

#reads in Precip, excludes columns with datalogger info but no data
air <- read.csv("DATA/air_9-22-18_2018.csv")[,1:4] 
#excludes rows with datalogger information. Use head() and nrow() to determine range
air <- air[4:1704, -2] 

#Renaming columns to something meaningful
names(air)[colnames(air)=="TOA5"] <- "Date_Time"
names(air)[colnames(air)=="CR6"] <- "Temp"
names(air)[colnames(air)=="X3767"] <- "RH"

#Create simple date column where time is not included
air$date <- as.Date(air$Date_Time)

#converts Temp and RH column from character to number
air$Temp <- as.numeric(as.character(air$Temp))
air$RH <- as.numeric(as.character(air$RH)) 

#calculates the daily averages
by_day <- air %>% group_by(date) %>% summarise(t_mean = mean(Temp),RH_mean = mean(RH)) 

#creates a bi-weekly sequence, excluding extra sequence records
bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84)]

#adds sequence as column into daily means
by_day$biwe <- bi_seq 

#calculates bi-weekly means
by_biweek <- by_day %>% group_by(biwe) %>% summarise(t_mean = mean(t_mean),RH_mean = mean(RH_mean)) 

write.csv(by_biweek, file = "Air_biweekly_means.csv")

graph <- ggplot(by_day, aes(date, t_mean)) +
  geom_line(na.rm = TRUE, color="blue", size=1)+
  geom_point(na.rm = TRUE, color="darkblue", size=2)+
  ggtitle("Precipitation over 2018 Growing Season") +
  xlab("Date") + ylab("Temperature (C)")

DailyTemp <- graph + theme_classic()
