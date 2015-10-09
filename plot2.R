#This file contains the code that generates the plot of global active
#power as a function of time for Feb 1 and 2 2007.

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
png(filename = "plot2.png", width = 480, height = 480)
par(mar=c(3,5,1,1))
plot(dat$DateTime, dat$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()

