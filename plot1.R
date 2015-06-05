#Exploratory Data Analysis 
#Course Project 1
#----- Plot1.R ----------#


#Get Required Libraries
library(sqldf)

#user messages
print("Plot 1 is being generated, please wait.....")
print("Reading Data.....")

#Get/Read data from the file location into a data frame using sqldf package
powerData <- read.csv.sql("household_power_consumption.txt",  sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Close the connection
closeAllConnections()

print("Plotting the graph....")

#Send plot to output png file
png("plot1.png", width = 480, height = 480)

#Set the plot margins
par( mar = c(4,4,2,2))

#Call the histogram plot 
hist(powerData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power" )

#close the png graphics device
dev.off()

print("Saving plot as plot1.png.")