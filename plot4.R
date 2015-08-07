# -----------------------------------------------------------------------------
# Exploratory Data Analysis - Course Project 1
#
# Author: Mikhail Kalesnikau
#
# This R script called plot1.R does the following:
# 1. Downloads, unpacks and reads the required part of the data set.
# 2. Merges Date and Time columns from strings to DateTime POSIXlt column.
# 3. Creates plot image as plot4.png

# -----------------------------------------------------------------------------
# download data archive

filePath <- "./household_power_consumption.txt"
arcPath <- "./household_power_consumption.zip"
if (!file.exists(filePath)) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    message("Downloading data set archive...")
    download.file(url = fileURL, destfile = arcPath)
    
    # extract data from the archive
    message("Extracting data set file from the archive...")
    unzip(zipfile = arcPath)
}

# -----------------------------------------------------------------------------
# read data
col_names <- read.table(filePath, sep = ";", nrows = 1, stringsAsFactors = FALSE)

dataset <- read.table(filePath, sep = ";", skip = 66637, nrows = 2880,
                      na.strings = "?", stringsAsFactors = FALSE,
                      col.names = col_names)

# -----------------------------------------------------------------------------
# merge date and time

dataset$DateTime = strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")

# -----------------------------------------------------------------------------
# plot data

png(file = "plot4.png")

par(mfcol = c(2, 2))

plot(dataset$DateTime, dataset$Global_active_power, type = "l",
     ylab = "Global Active Power", xlab = "", ljoin = 2)

plot(dataset$DateTime, dataset$Sub_metering_1, type = "l", ljoin = 2,
     ylab = "Energy Sub Metering", xlab = "")
points(dataset$DateTime, dataset$Sub_metering_2, type = "l", ljoin = 2, col = "red")
points(dataset$DateTime, dataset$Sub_metering_3, type = "l", ljoin = 2, col = "blue")
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

plot(dataset$DateTime, dataset$Voltage, type = "l",
     ylab = "Voltage", xlab = "Date/Time")

plot(dataset$DateTime, dataset$Global_reactive_power, type = "l", ljoin = 2,
     ylab = "Global Reactive Power", xlab = "Date/Time")

dev.off()
message("Plot image created at ./plot4.png")
