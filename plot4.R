#Exploratory Data Analysis 
#Course Project 1
#------ Plot4.R----------#

#Get Required Liibraries
library(lubridate)
library(sqldf)

#user messageS
print("Plot 4 is being generated, please wait.....")
print("Reading Data.....")

#Get/Read data from the file location into a data frame using sqldf package
powerData <- read.csv.sql("household_power_consumption.txt",  sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Close the connection
closeAllConnections()

#Combine Date column and Time column to create DateTime Column
powerData$DateTime  <-  dmy_hms( paste(powerData$Date, powerData$Time))

#Subset the data to filter out complete cases
t <- powerData[complete.cases(powerData), ]

print("Plotting the graph....")

#Send plot to output png file
png("plot4.png", width = 480, height = 480)

#Set plot margin and 2 x 2 plots
par( mar = c(4,6,4,4), mfrow = c(2,2))

##---------------------------------------------------------------------------------
#Plot 1,1
par( mar = c(4,4,4,4))
plot(t$DateTime, t$Global_active_power, type = "l", xlab = NA, ylab = NA)
#Annotate the plot
title(xlab = NA, ylab = "Global Active Power (kilowatts)")

##---------------------------------------------------------------------------------
#Plot 1,2
par( mar = c(4,4,4,4))
plot(t$DateTime, t$Voltage, type = "l", xlab = "", ylab = "")
#Annotate the plot
title(xlab = "datetime", ylab = "Voltage")

##---------------------------------------------------------------------------------
#Plot 2,1
par( mar = c(4,4,4,4))

#Get the range for Y-axis
r1 <- range(t$Sub_metering_1)
r2 <- range(t$Sub_metering_2)
r3 <- range(t$Sub_metering_3)
r <- c(r1,r2,r3)

plot(t$DateTime,  t$Sub_metering_1, type = "l", xlab = NA, ylab = NA ,ylim = range(r))
par(new = T)
plot(t$DateTime, t$Sub_metering_2, type = "l", xlab = NA, ylab = NA, axes = F, col="red", ylim = range(r))
par(new = T)
plot(t$DateTime, t$Sub_metering_3, type = "l", xlab = NA, ylab = "Energy sub metering", axes = F, col="blue", ylim = range(r))

legend("topright",  lty = c(1,1,1),  col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), horiz = FALSE, bty = "n")

##---------------------------------------------------------------------------------
#Plot 2,2
par( mar = c(4,4,4,4))
plot(t$DateTime, t$Global_reactive_power, type = "l", xlab = "", ylab = "")
#Annotate the plot
title(xlab = "datetime", ylab = "Global Reactive Power (kilowatts)")

#close the png graphics device
dev.off()

print("Saving plot as plot4.png.")