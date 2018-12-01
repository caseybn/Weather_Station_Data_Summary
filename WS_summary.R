WS_summary <- read.csv("DATA/EW_WS_Total_9-22-18_2018.csv", header = FALSE)[,1:6] #reads in Weather Station Data, excludes columns with datalogger info but no data

#Renaming columns to something meaningful
names(WS_summary)[colnames(WS_summary)=="V1"] <- "Date_Time"
names(WS_summary)[colnames(WS_summary)=="V3"] <- "Temp"
names(WS_summary)[colnames(WS_summary)=="V4"] <- "RH"
names(WS_summary)[colnames(WS_summary)=="V6"] <- "Sun"
names(WS_summary)[colnames(WS_summary)=="V7"] <- "WindSpeed"

WS_summary <- WS_summary[5:1704, -2] #excludes rows with datalogger information

#Create simple date column where time is not included
WS_summary$date <- as.Date(WS_summary$Date_Time)

WS_summary$Temp <- as.numeric(WS_summary$Temp)
WS_summary$RH <- as.numeric(WS_summary$RH)

by_day <- WS_summary %>% group_by(date) %>% summarise(t_mean = mean(Temp),RH_mean = mean(RH))

bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84,)]

by_day$biwe <- bi_seq

by_biweek <- by_day %>% group_by(biwe) %>% summarise(t_mean = mean(t_mean),RH_mean = mean(RH_mean))