#Open the table
data<-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
#Format Date and Time to Date type
date<-data$Date <- as.Date(data$Date, "%d/%m/%Y")

#Create subset with the appropiate data
subdate<-subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#Have date and time in a single column
Datetime <- paste(subdate$Date, subdate$Time)
subdate<-cbind(Datetime, subdate)
subdate$Datetime <- as.POSIXct(Datetime)

#Obtain the dataset to be plotted
cleandata<-na.omit(subdate)

#Plot 1
png(filename="plot1.png", width=480, height=480)
with(cleandata, hist(Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red"))
dev.off()