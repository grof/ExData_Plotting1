#----------------------------------------------------------------------------
# plot4.R 
# course: Exploratory Data Analysis         project# 1
#
# Our overall goal here is simply to examine how household energy usage
# varies over a 2-day period in February, 2007. Your task is to reconstruct
# the following plots below, all of which were constructed using the base
# plotting system.
#
# First you will need to fork and clone the following GitHub repository: 
# https://github.com/rdpeng/ExData_Plotting1
#
# For each plot you should
#
# Construct the plot and save it to a PNG file with a width of 480 pixels
# and a height of 480 pixels.
#
# Name each of the plot files as plot1.png, plot2.png, etc.
#
# Create a separate R code file (plot1.R, plot2.R, etc.) that constructs
# the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot.
# Your code file should include code for reading the data so that the plot
# can be fully reproduced. You should also include the code that creates
# the PNG file.
#
# Add the PNG file and R code file to your git repository
#
# When you are finished with the assignment, push your git repository to
# GitHub so that the GitHub version of your repository is up to date.
# There should be four PNG files and four R code files.
#
# Graph #4 should plot 4 graphs arranged in a 2x2 fashion for the dates
# between 2007-02-01 and 2007-02-02.  The four graphs are:
#
# [1,1] Global Active Power against time
# [1,2] Voltage against time
# [2,1] Energy sub-metering against time
# [2,2] Global reactive power against time
#----------------------------------------------------------------------------
library(dplyr)
library(lubridate)

# Data source and destination
zipurl  <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
zipfile <- './exdata_data_household_power_consumption.zip'

# download from source if file is not present already
if (!file.exists(zipfile)) {
download.file(zipurl, zipfile, 'curl')
}

# unzip the archive if not unzipped already
if (file.exists(zipfile)) {
  unzip(zipfile, overwrite = TRUE)
}

# load file as semi-colon separated values
datafile = 'household_power_consumption.txt';
datacsv <- read.csv(datafile, stringsAsFactors = FALSE, sep=';')

# Convert to data table so we can work with dplyr
data <- tbl_df(datacsv)

# Create a single column for DateTime
data <- mutate(data, Date = dmy(Date))
data <- mutate(data, DateTime = paste(Date, Time, sep=' '))
data <- mutate(data, DateTime = ymd_hms(DateTime))

# filter the data so we keep only Feb 1-2 2007
start <- ymd_hms('2007-02-01 00:00:00')
end   <- ymd_hms('2007-02-02 23:59:59')
plotdata <- filter(data, (DateTime >= start) & (DateTime <= end))

# transform columns of interest into numbers
plotdata <- mutate(plot1data, Global_active_power = as.numeric(Global_active_power))
plotdata <- mutate(plot1data, Global_reactive_power = as.numeric(Global_reactive_power))
plotdata <- mutate(plot1data, Voltage = as.numeric(Voltage))
plotdata <- mutate(plot1data, Sub_metering_1 = as.numeric(Sub_metering_1))
plotdata <- mutate(plot1data, Sub_metering_2 = as.numeric(Sub_metering_2))
plotdata <- mutate(plot1data, Sub_metering_3 = as.numeric(Sub_metering_3))

# plot lines to screen as per figure provided
par(mfrow = c(2,2))
with(plotdata, {
  plot(DateTime, Global_active_power,
       type='l',
       xlab = '',
       ylab='Global Active Power')
  plot(DateTime, Voltage,
       type='l',
       xlab = 'datetime',
       ylab='Voltage')
  plot(DateTime, Sub_metering_1, col = 'black', type='l', xlab = '', ylab='Energy sub metering')
  lines(DateTime, Sub_metering_2, col = 'red')
  lines(DateTime, Sub_metering_3, col = 'blue')
  
  # add legend
  legend('topright', 
         bty = 'n',   ## no border around legend
         cex = 0.85,  ## reduce font size used in legend
         lwd = 1,     ## use lines in legend
         col = c('black', 'red', 'blue'), 
         legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
  
  plot(DateTime, Global_reactive_power,
       type='l',
       xlab = 'datetime',
       ylab='Global_reactive_power')
  
  
})


# plot lines to PGN file as requested
png(file = 'plot4.png', width = 480, height= 480)  ## open PNG device
par(mfrow = c(2,2))
with(plotdata, {
  plot(DateTime, Global_active_power,
       type='l',
       xlab = '',
       ylab='Global Active Power')
  plot(DateTime, Voltage,
       type='l',
       xlab = 'datetime',
       ylab='Voltage')
  plot(DateTime, Sub_metering_1, col = 'black', type='l', xlab = '', ylab='Energy sub metering')
  lines(DateTime, Sub_metering_2, col = 'red')
  lines(DateTime, Sub_metering_3, col = 'blue')
  
  # add legend
  legend('topright', 
         bty = 'n',   ## no border around legend
         cex = 0.85,  ## reduce font size used in legend
         lwd = 1,     ## use lines in legend
         col = c('black', 'red', 'blue'), 
         legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
  
  plot(DateTime, Global_reactive_power,
       type='l',
       xlab = 'datetime',
       ylab='Global_reactive_power')
})
 
dev.off()  ## close the PNG file device





