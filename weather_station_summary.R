#Weather Station Data
rm(list=ls())

#Create a vector of files to be summarized
files <- list.files("./DATA")

for (file_name in files){
  climate_sum <- read.csv(paste0("DATA/", file_name), header= FALSE, skip = 4)
  names(climate_sum)[colnames(climate_sum)=="V1"] <- "Date_Time"
  assign(paste0(file_name, "_summary"), climate_sum)
  }


source("CR6_Function.R")

