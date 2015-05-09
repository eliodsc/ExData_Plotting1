###############################################################################
###     set programming environment
###############################################################################

## clean up
rm(list=ls())

## load libraries
library(dplyr)
library(tidyr)
library(lubridate)


###############################################################################
###     create analysis dataset
###############################################################################

## read entire dataset
power_all <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings=c("?"))

## filter and convert strings to lubridates
power <- power_all %>%
        mutate(Date=dmy(Date)) %>%
        filter(year(Date)=="2007" & month(Date)=="2" & (day(Date)=="1" | day(Date)=="2")) %>%
        mutate(Time=hms(Time)) %>%
        mutate(Date_Time=Date+Time)


###############################################################################
###     create and save plot 2
###############################################################################

file <- "plot4.png"
png(file, width=480, height=480, units="px")

par(mfrow=c(2,2))

##### first plot #####
with(power, plot(Date_Time, Global_active_power, type="l"
        , xlab="", ylab="Global Active Power")
)

##### second plot #####
with(power, plot(Date_Time, Voltage, type="l"
        , xlab="datetime", ylab="Voltage")
)

##### third plot #####
## plot no points, only axis and labels
plot(power$Date_Time, power$Sub_metering_1, type="n" 
     , ylab="Energy sub metering"
     , xlab=""
)

## add courves one by one
par(new=TRUE)
lines(power$Date_Time, power$Sub_metering_1, col="black")
par(new=TRUE)
lines(power$Date_Time, power$Sub_metering_2, col="red")
par(new=TRUE)
lines(power$Date_Time, power$Sub_metering_3, col="blue")

## add legends
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
        , lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black","red","blue")
        , bty = "n"
)


##### forth plot #####
with(power, plot(Date_Time, Global_reactive_power, type="l"
        , xlab="datetime", ylab="Global_reactive_power")
)

dev.off()

