# plot 2

library(datasets)
## Read data file.  We have enough memory to read the entire file. The reading does take 
## approximately 20 seconds.
## Treat '?'s as NA values, and use the character type to read in the Date and Time. They
## are converted to POSIXlt later.
allData <- read.table("household_power_consumption.txt", 
                      header = TRUE, 
                      sep = ";", 
                      na.strings = "?",
                      colClasses = c("character", "character", 
                                     "numeric", "numeric", "numeric", 
                                     "numeric", "numeric", "numeric", "numeric"))

## Convert the Time and Date into POSIXlt types.  Note that to convert the Time we need
## prepend the Date, otherwise it uses the current date.
allData$Time <- strptime(paste(allData$Date, allData$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
allData$Date <- as.Date(strptime(allData$Date, "%d/%m/%Y"))

## Lets just select the subset of data for the 2 days of Feb 1 and Feb 2 of 2007
## ref. stackoverflow.com
allData.sub <- allData[allData$Date %in% as.Date(c('2007-02-01', '2007-02-02')), ]

## Create the .png file of 480x480 margin size
png("./plot2.png", height = 480, width = 480)

## Create the plot. Do not use any plot characters then draw lines between all data points.
## NOTE: You can alternatively use type = 'l' instead of pch = NA_integer_ and a subsequent 
##       lines call.
plot(allData.sub$Time, allData.sub$Global_active_power,
     pch = NA_integer_,
     ylab = "Global Active Power (kilowatts)", 
     xlab = " ",
     main = " ")
lines(allData.sub$Time, allData.sub$Global_active_power)

## Turn the png device off
dev.off()