#This file contains the code that generates the four-panel plot containing
#global active power, voltage, energy sub metering, and global reactive 
#power vs time for Feb 1 and 2 2007.

#Pull in some non-standard libraries
library(data.table)
library(lubridate)

#(Only for me- move to the right wd)
setwd("./Documents/School/Coursera/ExploratoryAnalysis/project1/ExData_Plotting1")

#Read things in
dat <- fread(input="household_power_consumption.txt", sep=";", 
             header=TRUE, na.strings = "?")

#Do some prettifying of formats
dat[, DateTime:=paste(Date, Time, sep=" ")]
dat[, DateTime:=dmy_hms(DateTime)]
dat[, Date:=dmy(Date)]
dat[, Time:=hms(Time)]

#Subset to just the days we want
date_subset <- dat$Date==mdy("Feb 1 2007") | dat$Date==mdy("Feb 2 2007")
dat <- dat[date_subset,]
rm(date_subset)

#Set some general things first
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol=c(2,2), mar=c(3,5,2,1))

#Make the upper left plot of global active power vs time
plot(dat$DateTime, dat$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")

#Make the lower left plot of energy sub metering vs time
plot(dat$DateTime, dat$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering")
lines(dat$DateTime, dat$Sub_metering_2, col="red")
lines(dat$DateTime, dat$Sub_metering_3, col="blue")
legend_text <- c("Sub metering 1", "Sub metering 2", "Sub metering 3")
legend("topright", legend_text, lty=c(1,1), lwd=c(1,1), 
       col=c("black", "red", "blue"), box.lwd = 0)

#Make the upper right plot of voltage vs time
with(dat, plot(DateTime, Voltage, type="l", xlab="", ylab="Voltage"))

#Make the lower right plot of global reactive power vs time
plot(DateTime, Global_reactive_power, type="l", xlab="", 
     ylab="Global Reactive Power (kilowatts)")

#Close and save
dev.off()

