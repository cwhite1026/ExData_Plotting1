#This file contains the code that generates the plot of energy sub
#metering as a function of time for Feb 1 and 2 2007.

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

#Make the plot
png(filename = "plot3.png", width = 480, height = 480)
par(mar=c(3,5,1,1))
plot(dat$DateTime, dat$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering")
lines(dat$DateTime, dat$Sub_metering_2, col="red")
lines(dat$DateTime, dat$Sub_metering_3, col="blue")
legend_text <- c("Sub metering 1", "Sub metering 2", "Sub metering 3")
legend("topright", legend_text, lty=c(1,1), lwd=c(1,1), 
       col=c("black", "red", "blue"))
dev.off()

