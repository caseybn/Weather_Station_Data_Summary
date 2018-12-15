#Weather Station Data
rm(list=ls())

#load necessary libraries
library(dplyr)
library(shiny)
library(shinydashboard)
library(plotly)

#Create a vector of files to be summarized
files <- list.files("./DATA/Raw")

#Sets source for function
source("Functions/CR6_Function.R")
# Function works well.  A more elegant function would have less repeated.  Everything should be the 
# same except for the sum vs totals so the rest is repeat. If,else could operate on list of data
# to be summed vs list to be averaged, then everything else is applied or looped. Col names can be
# added at the end of each if/else. That would keep the repeats to 2.

#MAKE SURE YOU HAVE A DIRECTORY /DATA/Sum

#applies function across list of desired files 
mylist <- lapply(files, my_station_function)

#binds the colums from the function output into one dataframe and excludes repeated date columsn
graph <- do.call(cbind, mylist)
#Instead of next line, you could adjust what you cbind on above to exclude date
graph <- graph[(3:65), -c(3,5,7,9)]


#Plots daily data for viewing seasonal changes
par(mfrow=c(3,2))
plot(type = "l", graph$Date, graph$p_sum, main="Daily Precipitation", ylab = "Precipitation(mm)", xlab = "Date")
plot(type = "l", graph$Date, graph$s_sum, main="Daily Solar Radiation", ylab = "Global Solar Radation(W/m^2)", xlab = "Date")
plot(type = "l", graph$Date, graph$T_mean, main="Average Daily Temperature", ylab = "Temperature(°C)", xlab = "Date")
plot(type = "l", graph$Date, graph$RH_mean, main="Average Daily Relative Humidity", ylab = "Relative Humidity(%))", xlab = "Date")
plot(type = "l", graph$Date, graph$WS_mean, main="Average Daily Wind Speed", ylab = "Wind Speed (m/s)", xlab = "Date")

