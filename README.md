# Weather Station Data Summary

## Contents
- Overall Project Description
- Weather Station code purpose/ rationale 
  - Objectives
  - Data Sources
- Implementation
- Products
- Resources

## Description of overall project:
For my thesis I am attempting to include species specific impacts on water balance modeling by identifying species differences in water management strategies at the crown level. Leveraging an existing 50-100% throughfall exclusion (Tfe) experiment, as well as strategically placed time-lapse cameras and light sensors, I will measure species specific crown architecture and light attenuation to develop crown-integrated solar radiation terms for water balance modeling. My hope is to improve water balance modeling accuracy at Elizabeth Wood’s, located south of Morgantown, WV, by incorporating measured light attenuation and solar radiation terms relative to individual species to into a dynamic water balance model method.  

## Purpose of this script:
Water balance models account for both factors of supply and demand by incorporating climatic, topographic, and edaphic variables. To collect relevant climatic data, I have set up a weather station in an open field north of my study plots South of Morgantown, WV (**Picture 1**). This station utilizes LOGGERNET technology to store data for download including precipitation, temperature, wind speed, relative humidity, and solar radiation. The output format is comma-separated values.

![alt text](https://github.com/caseybn/Weather_Station_Data_Summary/blob/master/Pictures/Weather_Station.jpg)
**Picture 1**: Setting up the weather station during what turned out to be "normal" weather conditions this season. 

### 1) Objectives:
a. To automate the clean-up and summarization process of data collected daily at Elizabeth Woods in preparation for use in a water balance model. Summaries necessary include daily averages and daily sums. I have chosen to run my water balance model on a bi-weekly timestep it will also be necessary to obtain bi-weekly sums and averages as well.  

b. Output visuals to display changes in weather conditions throughout the growing season

c. Produce a "Shiny" interface to include online, interactive comparisons of climatic data collected at Elizabeth Woods. Find a way to link this to the live weather station data.

### 2) Data Sources:
a. Data is collected directly from the site and located within this repo.

b. Includes temperature (°C), relative humidity (%), precipitation (mm), solar irradiance (W/m^2), wind speed (m/s).

c. Data is in .csv format with one file containing all the season's data.
-Temperature and relative humidity are stored in the same file titled “Air”, so the datafile was duplicated so that "Air2" could be used to summarize relative humidity in the function.

d. All data was collected between 13 July 2018 through 22 September 2018

### 3) Implementation:

## Products:
- A .csv file with the daily and bi-weekly summaries for precipitation and solar irradiance as well the daily and biweekly means for temperature, relative humidity, and wind speed. These were produced soley for data exchange.
- A script that can be used to update weather station summaries in the future and generate tables and graphs for use in modeling

## CODE To-Date (10-25-2018):
#Weather Station Data summarization

#### Resources utilized:

### Acknowledgements: 
Luis Andres Guillen and Nanette Raczka, my co-workesr on the Elizabeth Woods TfE experiment, as well as our advisors Dr. Brenden McNeil, Dr. Nicolas Zegre, and Dr. Edward Brzostek. Also, Dr. Amy Hessl for her un-paralleled patience in this learning process.    
