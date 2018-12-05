CR6_Function <- function(climate_variable){
    if (climate_variable == "Precip") {
      names(climate_sum)[colnames(climate_sum)=="V3"] <- "Precipitation"
      climate_sum$Precipitation <- as.numeric(as.character(climate_sum$Precipitation))
      return(climate_sum)
    } else {
      print("not")
    }
  }

    
    