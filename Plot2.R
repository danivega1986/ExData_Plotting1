#If a set a variable with the Dataset
s<- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")
#Then the s size will be:
s_size<- object.size(s); s_size
# 150050248 bytes
# 150.05 Mb

#About the dates
library(lubridate)
minDate = ymd("2007/01/02")
maxDate = ymd("2007/02/02")
s$Date<- as.Date(s$Date, format='%d/%m/%Y')
#s$Time <- strptime(s$Time, format="%H:%M:%S")

Energy_Sub<- subset(s, s$Date==minDate | s$Date== maxDate); Energy_Sub
Energy_Sub$FullTime<- paste(Energy_Sub$Date, Energy_Sub$Time)
Energy_Sub$FullTime<-ydm_hms(Energy_Sub$FullTime)

## Plot 2
png("plot2.png", width=480, height=480)
plot(x = Energy_Sub$FullTime, y =  Energy_Sub$Global_active_power
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()