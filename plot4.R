# plot 4

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

##Create the .png file of 480x480 margin size
png("./plot4.png", height = 480, width = 480)

## Create the 2x2 plot 
par(mfrow = c(2,2))
with(allData.sub,
  {
     plot(allData.sub$Time, allData.sub$Global_active_power,
          type = 'l',
          ylab = "Global Active Power (kilowatts)", 
          xlab = " ",
          main = " ")
     
     plot(allData.sub$Time, allData.sub$Voltage,
          type = 'l',
          ylab = "Voltage", 
          xlab = "datetime",
          main = " ")
     
     plot(allData.sub$Time, allData.sub$Sub_metering_1,
          type = 'l',
          ylab = "Energy sub metering", 
          xlab = " ",
          main = " ")
     lines(allData.sub$Time, allData.sub$Sub_metering_2, col = "red")
     lines(allData.sub$Time, allData.sub$Sub_metering_3, col = "blue")
     legend("topright",
            col = c("black", "red", "blue"), bty = "n",
            cex = 0.7,
            lty = c(1,1), text.width = strwidth("Sub_metering_X"),
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     
     plot(allData.sub$Time, allData.sub$Global_reactive_power,
          type = 'l',
          ylab = "Global_reactive_power", 
          xlab = "datetime",
          main = " ")
  }
)

## Turn off the png device
dev.off()