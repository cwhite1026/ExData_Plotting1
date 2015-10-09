#This file contains the code that generates the histogram of global
#active power for Feb 1 and 2 2007.

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
png(filename = "plot1.png", width = 480, height = 480)
hist(dat$Global_active_power, breaks=12, 
     xlab = "Global Active Power (kilowatts)", 
     ylab="Frequency", col="red", 
     main="Global Active Power")
dev.off()

