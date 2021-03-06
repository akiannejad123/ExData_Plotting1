library(tidyverse)
library(broom)
library(lattice)
library(lubridate)


#setwd("C:./Desktop/Exploratory_data")

list.files()

 #colnames(file) <-c("Date"=as.Date(V1), "Time"=striptime(Time), "Global_active_power"=numeric(),"Global_reactive_power"=numeric(), "Voltage"=numeric, "Global_Intensity"=numeric(),"Sub_metering_1"=numeric(),"Sub_metering_2"=numeric(),"Sub_metering_3"=numeric())
 
file <- read.table("household_power_consumption.txt",sep=";",  header=TRUE, stringsAsFactors =FALSE, na.strings = "?")

Household_Power_Consumption <-file%>%
  mutate(Date=dmy(Date))%>%
  mutate(Global_active_power=as.numeric(Global_active_power))%>%
  filter(Date>=as.Date("2007-02-01")& Date<as.Date("2007-02-03"))


Household_Power_Consumption$Date <- strptime(Household_Power_Consumption$Date, format= "%Y-%m-%d")


Household_Power_Consumption<-Household_Power_Consumption%>%
  mutate(Date_Time=(as.Date(as.POSIXct( paste(Date,Time ),format="%Y-%m-%d %H:%M:%S", tz="GMT"))))
Household_Power_Consumption$New_Time<- as.POSIXct(paste(Household_Power_Consumption$Date, Household_Power_Consumption$Time), format="%Y-%m-%d %H:%M:%S")
Household_Power_Consumption$Day_of_week <-(weekdays(Household_Power_Consumption$Date))


png("plot1.png")
plot1 <- hist( Household_Power_Consumption$Global_active_power, col="red", main="Global Active Power", xlab=" Global Active Power(kilowatts)")
dev.off()


png("plot2.png")
plot(Global_active_power~New_Time, Household_Power_Consumption, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()


png('plot3.png')
plot(Sub_metering_1~New_Time, Household_Power_Consumption, type="l")
  lines(Sub_metering_2~New_Time, Household_Power_Consumption, col="red")
  lines(Sub_metering_3~New_Time, Household_Power_Consumption, col="blue")
  legend("topright", legend=c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"), lty=1)
dev.off()
  
png('plot4.png')
par(mar=c(4,4,2,2))
par(mfrow=c(2,2))
plot(Global_active_power~New_Time, Household_Power_Consumption, type="l", ylab="Global Active Power (kilowatts)")
plot(Voltage~New_Time, Household_Power_Consumption, type='l', ylab="Voltage", xlab="datetime")
plot(Sub_metering_1~New_Time, Household_Power_Consumption, type="l", ylab= "Energy Sub Metering")
lines(Sub_metering_2~New_Time, Household_Power_Consumption, col="red")
lines(Sub_metering_3~New_Time, Household_Power_Consumption, col="blue")
legend("topright", legend=c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"), lty=1)
plot(Global_reactive_power ~New_Time, Household_Power_Consumption, type="l", xlab="datetime")
dev.off()
 
 