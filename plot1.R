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
        mutate(Time=hms(Time))


###############################################################################
###     create and save plot
###############################################################################

file <- "plot1.png"
png(file, width=480, height=480, units="px")

par(mfrow=c(1,1))
with(power, hist(Global_active_power, main="Global Active Power"
        , xlab="Global Active Power (kilowatts)", col="red")
)

dev.off()

