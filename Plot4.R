#If a set a variable with the Dataset
s<- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")
#Then the s size will be:
s_size<- object.size(s); s_size
# 150050248 bytes
# 150.05 Mb

Small_sample<- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", nrow=5)
colnames(Small_sample)
#[1] "Date"                  "Time"                  "Global_active_power"  
#[4] "Global_reactive_power" "Voltage"               "Global_intensity"     
#[7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"
str(Small_sample)

#About the dates
library(lubridate)
minDate = ymd("2007/01/02")
maxDate = ymd("2007/02/02")
s$Date<- as.Date(s$Date, format='%d/%m/%Y')

library(chron)
s$Time <- chron(times=s$Time)
Energy_Sub<- subset(s, s$Date==minDate | s$Date== maxDate); Energy_Sub

Energy_Sub$FullTime<- paste(Energy_Sub$Date, Energy_Sub$Time)
Energy_Sub$FullTime<-ydm_hms(Energy_Sub$FullTime)

#In this case we need a 2x2 layout, then:
png("plot4.png",width=480, height=480)
par(mfrow=c(2,2))
plot(x = Energy_Sub$FullTime, y =  Energy_Sub$Global_active_power
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(x=Energy_Sub$FullTime,y=Energy_Sub$Voltage, type="l",
     xlab="datetime",ylab="Voltage")

plot(Energy_Sub$FullTime,Energy_Sub$Sub_metering_3, col="blue",type="l",xlab="",ylab="Energy sub metering", ylim = c(0,35))
with(Energy_Sub,lines(FullTime,as.numeric(Sub_metering_2),col="red"))
with(Energy_Sub,lines(FullTime,as.numeric(Sub_metering_1),col="black"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main="Energy sub-metering")

plot(Energy_Sub$FullTime,Energy_Sub$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()