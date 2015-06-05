#Exploratory Data Analysis 
#Course Project 1
#----- Plot3.R --------#

#Get Required Liibraries
library(lubridate)
library(sqldf)

#user messageS
print("Plot 3 is being generated, please wait.....")

print("Reading Data.....")

#Get/Read data from the file location into a data frame using sqldf package
powerData <- read.csv.sql("household_power_consumption.txt",  sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Close the connection
closeAllConnections()

#Combine Date column and Time column to create DateTime Column
powerData$DateTime  <-  dmy_hms( paste(powerData$Date, powerData$Time))

#Subset the data to filter out complete cases
t <- powerData[complete.cases(powerData), ]

#Get range for Y-Axis
r1 <- range(t$Sub_metering_1)
r2 <- range(t$Sub_metering_2)
r3 <- range(t$Sub_metering_3)
r <- c(r1,r2,r3)

print("Plotting the graph....")

#Send plot to output png file
png("plot3.png", width = 480, height = 480)

#create the plot
#Set the plot margins
par(mar=c(4,4,2,2))

#Generate the base plot
plot(t$DateTime,  t$Sub_metering_1, type = "l", xlab = NA, ylab = NA ,ylim = range(r))
par(new = T)
plot(t$DateTime, t$Sub_metering_2, type = "l", xlab = NA, ylab = NA, axes = F, col="red", ylim = range(r))
par(new = T)
plot(t$DateTime, t$Sub_metering_3, type = "l", xlab = NA, ylab = "Energy sub metering", axes = F, col="blue", ylim = range(r))

#Add legend
legend("topright",  lty = c(1,1,1),  col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), horiz = FALSE)

#close the png graphics device
dev.off()
print("Saving plot as plot3.png.")
