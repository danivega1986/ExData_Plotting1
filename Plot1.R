#First we need to know the size of the file, file.size
size_Mb<- file.size("household_power_consumption.txt")/1.0E6
size_Mb
#[1] 132.96 Mb

# If I read all the data set then:
system.time(read.table("household_power_consumption.txt", sep=";", header=TRUE))
#       user  system elapsed 
#       6.55    0.21    7.00 
# In my point of view is not too slow

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
#s$Time <- strptime(s$Time, format="%H:%M:%S")

Energy_Sub<- subset(s, s$Date==minDate | s$Date== maxDate); Energy_Sub

##Plot 1. Histogram
png("plot1.png", width=480, height=480)
hist(Energy_Sub$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power(kilowatts)")
dev.off()
