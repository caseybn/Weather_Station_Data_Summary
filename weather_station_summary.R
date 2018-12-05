#Weather Station Data
rm(list=ls())

#Create a vector of files to be summarized
files <- list.files("./DATA")
file_path_sans_ext

source("CR6_Function.R")

for (file_name in files){
  climate_sum <- read.csv2(paste0("DATA/", file_name), header= FALSE, skip = 4)
  names(climate_sum)[colnames(climate_sum)=="V1"] <- "Date_Time"
  assign(paste0(file_name), climate_sum)
  matrix_list <- ls(pattern="summary") #creates a vector of all matrices ran through the recoding loop
  }

climate_sum2 <- apply(climate_sum, 1, CR6_Function)

