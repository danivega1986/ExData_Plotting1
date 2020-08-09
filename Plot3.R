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

Energy_Sub[1:1440,"Time"] <- format(Energy_Sub[1:1440,"Time"],"2007-02-01 %H:%M:%S")
Energy_Sub[1441:2880,"Time"] <- format(Energy_Sub[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
Energy_Sub$FullTime<- paste(Energy_Sub$Date, Energy_Sub$Time)
Energy_Sub$FullTime<-ydm_hms(Energy_Sub$FullTime)

# Plot 3
png("plot3.png", width=480, height=480)
plot(Energy_Sub$FullTime,Energy_Sub$Sub_metering_3, col="blue",type="l",xlab="",ylab="Energy sub metering")
with(Energy_Sub,lines(FullTime,as.numeric(Sub_metering_2),col="red"))
with(Energy_Sub,lines(FullTime,as.numeric(Sub_metering_1),col="black"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main="Energy sub-metering")
dev.off()
