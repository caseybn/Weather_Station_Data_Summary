#Weather Station Data
rm(list=ls())

#Create a vector of files to be summarized
files <- list.files("./DATA")

source("CR6_Function.R")

for (file_name in files){
  
  }

results <- lapply(files, CR6_Function)
as.data.frame(do.call(rbind, results))

assign(paste0(file_name), climate_sum)
matrix_list <- ls(pattern="summary") #creates a vector of all matrices ran through the recoding loop
