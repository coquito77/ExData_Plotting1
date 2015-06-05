# download file changed https to http

temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header=T, 
	sep=";",
	colClasses = c("character", "character", rep("numeric",7)),
                   na = "?")
unlink(temp)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

DATE1 <- as.Date("2007-02-01")
DATE2 <- as.Date("2007-02-02")

subSetData <- data[data$Date >= DATE1 & data$Date <= DATE2,]

## Plot 4
dataTime <- paste(as.Date(subSetData$Date), subSetData$Time)
subSetData$DataTime<- as.POSIXct(dataTime)

attach(subSetData)

png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

plot(DataTime, Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(DataTime, Voltage, type="l", xlab="Data Time", ylab="Voltage")

plot(DataTime, Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(DataTime, Sub_metering_2, type="l", col="red")
lines(DataTime, Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(DataTime, Global_active_power, type="l", xlab="Data Time", ylab="Global reactive power")

dev.off()
