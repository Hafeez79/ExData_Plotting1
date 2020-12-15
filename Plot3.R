# Download and unzip the file

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "download.zip")
data <- unzip("download.zip")
unlink("download.zip")
data <- read.table(data, header=TRUE, sep=";")

newdata <- data

# Convert class of Date column 
newdata$Date <- as.Date(newdata$Date, "%d/%m/%Y") 

# Subset dates to 1 Feb 2007 to 2 Feb 2007

newdata <- subset(newdata, Date>="2007-02-01" & Date<="2007-02-02")


newdata <- mutate(newdata, DateTime = ymd_hms(paste(Date, Time)))


# Convert other character columns to numeric

columnstoconvert <- c("Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2")

newdata[columnstoconvert] <- sapply(newdata[columnstoconvert], as.numeric)

# Plot 3

png("plot3.png", width=480, height=480)

plot(newdata$DateTime, newdata$Sub_metering_1, pch=NA, xlab=NA, ylab="Energy sub metering")
lines(newdata$DateTime, newdata$Sub_metering_1, type="l", lty=1)
lines(newdata$DateTime, newdata$Sub_metering_2, type="l", lty=1, col="red")
lines(newdata$DateTime, newdata$Sub_metering_3, type="l", lty=1, col="blue")

legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)

dev.off()
