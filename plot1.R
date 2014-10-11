#----------------------------------------------------------------------------
# plot1.R 
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
# Graph #1 should plot a histogram of Global Active Power (kilowatts)
# for the dates between 2007-02-01 and 2007-02-02.
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

# transform column of interest into numbers
plotdata <- mutate(plotdata, Global_active_power = as.numeric(Global_active_power))

# plot histogram to screen as per figure provided
hist(plotdata$Global_active_power,
     col='red',
     main="Global Active Power",
     xlab='Global Active Power (kilowatts)')


# plot histogram to PGN file as requested
png(file = 'plot1.png', width = 480, height= 480)  ## open PNG device
hist(plotdata$Global_active_power,
     col='red',
     main="Global Active Power",
     xlab='Global Active Power (kilowatts)')
dev.off()  ## close the PNG file device





