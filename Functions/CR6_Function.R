my_station_function <- function(climate_var){
  climate_sum <- read.csv2(file= paste0("DATA/Raw/", climate_var), header = FALSE, sep = ",", skip = 4)
  names(climate_sum)[colnames(climate_sum)=="V1"] <- "Date_Time"
  climate_sum$Date <- as.Date(climate_sum$Date_Time)
  
  if (climate_var == "Precip.csv") {
    names(climate_sum)[colnames(climate_sum)=="V3"] <- "Precip"
    climate_sum$Precip <- as.numeric(as.character(climate_sum$Precip))
    by_day <- climate_sum %>% group_by(Date) %>% summarise(p_sum = sum(Precip))
    write.csv(by_day, file = "DATA/Sum/Precip_daily_sums.csv")
    bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84)]
    by_day$biwe <- bi_seq
    by_biweek <- by_day %>% group_by(biwe) %>% summarise(p_sum_mm = sum(p_sum))
    write.csv(by_biweek, file = "DATA/Sum/Precip_biweekly_sums.csv")
    assign("Precip_daily", by_day[,-3], envir = .GlobalEnv)
    
  } else if(climate_var == "Air.csv"){
    names(climate_sum)[colnames(climate_sum)=="V3"] <- "Temp"
    climate_sum$Temp <- as.numeric(as.character(climate_sum$Temp))
    by_day <- climate_sum %>% group_by(Date) %>% summarise(T_mean = mean(Temp))
    write.csv(by_day, file = "DATA/Sum/Temp_daily_mean.csv")
    bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84)]
    by_day$biwe <- bi_seq
    by_biweek <- by_day %>% group_by(biwe) %>% summarise(T_mean_C = mean(T_mean))
    write.csv(by_biweek, file = "DATA/Sum/Temp_biweekly_mean.csv")
    assign("Temp_daily", by_day[,-3], envir = .GlobalEnv)
    
  } else if(climate_var == "Air2.csv"){
    names(climate_sum)[colnames(climate_sum)=="V3"] <- "RH"
    climate_sum$RH <- as.numeric(as.character(climate_sum$RH))
    by_day <- climate_sum %>% group_by(Date) %>% summarise(RH_mean = mean(RH))
    write.csv(by_day, file = "DATA/Sum/RH_daily_mean.csv")
    bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84)]
    by_day$biwe <- bi_seq
    by_biweek <- by_day %>% group_by(biwe) %>% summarise(RH_mean = mean(RH_mean))
    write.csv(by_biweek, file = "DATA/Sum/RH_biweekly_mean.csv")
    assign("RH_daily", by_day[,-3], envir = .GlobalEnv)
    
  } else if(climate_var == "Sun.csv"){
    names(climate_sum)[colnames(climate_sum)=="V8"] <- "Solar"
    climate_sum$Solar <- as.numeric(as.character(climate_sum$Solar))
    by_day <- climate_sum %>% group_by(Date) %>% summarise(s_sum = sum(Solar))
    write.csv(by_day, file = "DATA/Sum/Solar_daily_sums.csv")
    bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84)]
    by_day$biwe <- bi_seq
    by_biweek <- by_day %>% group_by(biwe) %>% summarise(s_sum = sum(s_sum))
    write.csv(by_biweek, file = "DATA/Sum/Solar_biweekly_Sums.csv")
    assign("Sun_daily", by_day[,-3], envir = .GlobalEnv)
    
  } else if (climate_var == "Wind.csv"){
    names(climate_sum)[colnames(climate_sum)=="V3"] <- "WS"
    climate_sum$WS <- as.numeric(as.character(climate_sum$WS))
    by_day <- climate_sum %>% group_by(Date) %>% summarise(WS_mean = mean(WS))
    write.csv(by_day, file = "DATA/Sum/WindSpeed_daily_mean.csv")
    bi_seq <- (rep(seq(1:ceiling(nrow(by_day)/14)), each=14))[-(73:84)]
    by_day$biwe <- bi_seq
    by_biweek <- by_day %>% group_by(biwe) %>% summarise(WS_mean = mean(WS_mean))
    write.csv(by_biweek, file = "DATA/Sum/WindSpeed_biweekly_mean.csv")
    assign("Wind_daily", by_day[,-3], envir = .GlobalEnv)
  }
}
    