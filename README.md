# Weather_Station_Data_Summary

Description of overall project:
	For my thesis I am attempting to include species specific impacts on water balance modeling by identifying species differences in water management strategies at the crown level. Leveraging an existing 50-100% throughfall exclusion experiment, as well as strategically placed time lapse cameras and light sensors, I will measure species specific crown architecture and light attenuation to develop crown-integrated solar radiation terms for water balance modeling. My hope is to improve water balance modeling accuracy at Elizabeth Wood’s, located south of Morgantown, WV, by incorporating measured light attenuation and solar radiation terms relative to individual species to into a dynamic water balance model method.  

Purpose of this script:
	Water balance models account for both factors of supply and demand by incorporating climatic, topographic, and edaphic variables. To collect relevant climatic data, I have set up a weather station in an open field north of my study plots South of Morgantown, WV. This station utilizes LOGGERNET technology to store data for download including precipitation, temperature, wind speed, relative humidity, and solar radiation. The output format is comma-separated values. 

1) Objectives: 
  a. To automate the summarization process of data collected daily at Elizabeth Woods in preparation for use in a water balance model.    
  Summaries necessary include daily averages and daily sums 
  b. Output visuals to display changes in weather conditions throughout the growing season

2) Data Sources: 
  a. Data is collected directly from the site and located within this repo. 
  b. Includes temperature (°C), relative humidity (%), precipitation (mm), solar irradiance (W/m^2), wind speed (m/s). 
  c. Data is in .csv format with one file containing all the season's data. 
    -Temperature and relative humidity are stored in the same file titled “Air”
	d. All data was collected between 13 July 2018 through 22 September 2018

3) Implementation

Resources:
Zoo package help: https://cran.r-project.org/web/packages/zoo/zoo.pdf
As.POSIXct help: https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/as.POSIX*

Expected Products: 

Questions for instructor:

Acknowledgements: Luis Andres Guillen 
