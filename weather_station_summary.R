#Weather Station Data
rm(list=ls())

#Load necessary libraries
library(dplyr)
library(ggplot2)
library(ggthemes)

#Create a vector of files to be summarized
files <- list.files("./DATA")

#Sets source for function
source("CR6_Function.R")

#applies function across list of desired files 
sapply(files, my_station_function)

#creates a list of summarized files to be graphed
to_graph <- list.files("./DATA", pattern = "biweekly")


