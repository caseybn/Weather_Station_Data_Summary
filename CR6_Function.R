CR6_Function <- function(climate_var){
  climate_sum <- read.csv2(file= paste0("DATA/", climate_var), header = FALSE, sep = ",", skip = 4)
  names(climate_sum)[colnames(climate_sum)=="V1"] <- "Date_Time"
  climate_sum$date <- as.Date(climate_sum$Date_Time)
    if (climate_var == "Precip.csv") {
      names(climate_sum)[colnames(climate_sum)=="V3"] <- "Precip"
      climate_sum$Precip <- as.numeric(as.character(climate_sum$Precip))
    } else if(climate_var == "Air.csv"){
      names(climate_sum)[colnames(climate_sum)=="V3"] <- "Temp"
      names(climate_sum)[colnames(climate_sum)=="V4"] <- "RH"
      climate_sum$Temp <- as.numeric(as.character(climate_sum$Temp))
      climate_sum$RH <- as.numeric(as.character(climate_sum$RH)) 
    } else if(climate_var == "Sun.csv"){
      names(climate_sum)[colnames(climate_sum)=="V8"] <- "Solar"
      climate_sum$Solar <- as.numeric(as.character(climate_sum$Solar))
    } else if (climate_var == "Wind.csv"){
      names(climate_sum)[colnames(climate_sum)=="V3"] <- "WS"
      climate_sum$WS <- as.numeric(as.character(climate_sum$WS))
    }
  as.data.frame(do.call(rbind, climate_sum))
  }

    
    