#Weather Station Data
rm(list=ls())

library(dplyr)
library(ggplot2)


#Create a vector of files to be summarized
files <- list.files("./DATA/Raw")

#Sets source for function
source("Functions/CR6_Function.R")

#applies function across list of desired files 
lapply(files, my_station_function)

#creates a list a vector of files to be graphed
to_graph <- as.vector(ls(pattern = "by_day"))

for (file in to_graph) {
  summary_graphs(file)
 }