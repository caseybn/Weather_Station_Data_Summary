#Weather Station Data
rm(list=ls())

#Create a vector of files to be summarized
files <- list.files("./DATA")
 
Precip<-read.csv("DATA/Precip.csv", header = FALSE)[,1:3] #reads in Precip, excludes columns with datalogger info but no data
Precip <- Precip[4:10212, -2] #excludes rows with datalogger information


#Renaming columns to something meaningful
names(Precip)[colnames(Precip)=="CR6"] <- "Precipitation"
names(Precip)[colnames(Precip)=="TOA5"] <- "Date_Time"

#Create simple date column where time is not included
Precip$date <- as.Date(Precip$Date_Time)

Precip$Precipitation <- as.numeric(as.character(Precip$Precipitation))

by_day <- Precip %>% group_by(date) %>% summarise(p_sum = sum(Precipitation))

bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84)]

by_day$biwe <- bi_seq

by_biweek <- by_day %>% group_by(biwe) %>% summarise(p_sum_mm = sum(p_sum))

write.csv(by_biweek, file = "Precip_biweekly_Sums.csv")

graph <- ggplot(by_day, aes(date, p_sum)) +
  geom_line(na.rm = TRUE, color="blue", size=1)+
  geom_point(na.rm = TRUE, color="darkblue", size=2)+
  ggtitle("Precipitation over 2018 Growing Season") +
  xlab("Date") + ylab("Precipitation (mm)")

DailyPrecip <- graph + theme_classic()





#do.call(cbind,lapply(to_graph, function(x) x[]))
#loop to read in files to be graphed 
for (i in 1:length(to_graph)){
  assign(to_graph[i],
         read.csv(paste0(to_graph[i], sep=''))[,-2]
  )}




#Things tried but not figured out
# MUTATE https://www.earthdatascience.org/courses/earth-analytics/time-series-data/summarize-time-series-by-month-in-r/
#AGGREGATE 
# aggregate(Precip$Precipitation, by=list(Precip$date), sum)


