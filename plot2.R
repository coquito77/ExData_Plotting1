
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
attach(subSetData)

## Plot 2
datetime <- paste(as.Date(subSetData$Date), subSetData$Time)
subSetData$Datetime <- as.POSIXct(datetime)

png("plot2.png", width=480, height=480)
plot(subSetData$Global_active_power ~ subSetData$Datetime, 
	type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
