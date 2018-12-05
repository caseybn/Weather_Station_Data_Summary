CR6_Function <- function(climate_sum){
    if (climate_sum == "Precip.csv") {
      names(climate_sum)[colnames(climate_sum)=="V3"] <- "Precip"
      climate_sum$Precip <- as.numeric(as.character(climate_sum$Precip))
    } else if(climate_sum == "Air.csv"){
      names(climate_sum)[colnames(climate_sum)=="V3"] <- "Temp"
      names(climate_sum)[colnames(climate_sum)=="V3"] <- "RH"
      climate_sum$Temp <- as.numeric(as.character(climate_sum$Temp))
      climate_sum$RH <- as.numeric(as.character(climate_sum$RH)) 
    } else if(climate_sum == "Sun.csv"){
      names(climate_sum)[colnames(climate_sum)=="V8"] <- "Solar"
      climate_sum$Solar <- as.numeric(as.character(climate_sum$Solar))
    } else if (climate_sum == "Wind.csv"){
      names(climate_sum)[colnames(climate_sum)=="V3"] <- "WS"
      climate_sum$WS <- as.numeric(as.character(climate_sum$WS))
    }
  return(climate_sum)
  }

    
    