#Exploratory Data Analysis 
#Course Project 1
#----- Plot2.R --------#

#Get required Liibraries
library(lubridate)
library(sqldf)

#user messages
print("Plot 2 is being generated, please wait.....")
print("Reading Data.....")

#Get/Read data from the file location into a data frame using sqldf package
powerData <- read.csv.sql("household_power_consumption.txt",  sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Close the connection
closeAllConnections()

#Combine 'Date' column and 'Time' column to create 'DateTime' Column
powerData$DateTime  <-  dmy_hms( paste(powerData$Date, powerData$Time))

#Subset the data to filter out complete cases
t <- powerData[complete.cases(powerData), ]

print("Plotting the graph....")

#Send plot to output png file
png("plot2.png", width = 480, height = 480)

#Set the plot margins
par(mar = c(4,4,2,2))

#Generate the base plot
plot(t$DateTime, t$Global_active_power, type = "l", xlab = NA, ylab = NA)
#Annotate the plot
title(xlab = "", ylab = "Global Active Power (kilowatts)")


#close the png graphics device
dev.off()

print("Saving plot as plot2.png.")