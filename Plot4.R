# Download and unzip the file

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "download.zip")
data <- unzip("download.zip")
unlink("download.zip")
data <- read.table(data, header=TRUE, sep=";")


library(dplyr)
library(lubridate)

newdata <- data

# Convert class of Date column 
newdata$Date <- as.Date(newdata$Date, "%d/%m/%Y") 

# Subset dates to 1 Feb 2007 to 2 Feb 2007

newdata <- subset(newdata, Date>="2007-02-01" & Date<="2007-02-02")


newdata <- mutate(newdata, DateTime = ymd_hms(paste(Date, Time)))


# Convert other character columns to numeric

columnstoconvert <- c("Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2")

newdata[columnstoconvert] <- sapply(newdata[columnstoconvert], as.numeric)

# Plot 4

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# top left plot

plot(newdata$DateTime, newdata$Global_active_power, pch=NA, xlab=NA, ylab="Global Active Power (kilowatts)")
lines(newdata$DateTime, newdata$Global_active_power, type="l", lty=1)

#top right plot

plot(newdata$DateTime, newdata$Voltage, pch=NA, xlab="datetime", ylab="Voltage")
lines(newdata$DateTime, newdata$Voltage, type="l", lty=1)


# bottom left plot

plot(newdata$DateTime, newdata$Sub_metering_1, pch=NA, xlab=NA, ylab="Energy sub metering")
lines(newdata$DateTime, newdata$Sub_metering_1, type="l", lty=1)
lines(newdata$DateTime, newdata$Sub_metering_2, type="l", lty=1, col="red")
lines(newdata$DateTime, newdata$Sub_metering_3, type="l", lty=1, col="blue")

legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)

# bottom right plot

plot(newdata$DateTime, newdata$Global_reactive_power, pch=NA, xlab="datetime", ylab="Global_reactive_power")
lines(newdata$DateTime, newdata$Global_reactive_power, type="l", lty=1)

dev.off()
