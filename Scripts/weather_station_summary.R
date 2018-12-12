#Weather Station Data
rm(list=ls())

library(dplyr)

#Create a vector of files to be summarized
files <- list.files("./DATA")

#Sets source for function
source("CR6_Function.R")

#applies function across list of desired files 
lapply(files, my_station_function)

#creates a list of summarized files to be graphed
to_graph <- list.files("./DATA", pattern = "biweekly")
do.call(cbind,lapply(to_graph, function(x) x[]))

#loop to read in files to be graphed 
for (i in 1:length(to_graph)){
  assign(to_graph[i],
         read.csv(paste0(to_graph[i], sep=''))[,-2]
  )}