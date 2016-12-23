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
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(cleandata, {
        plot(Global_active_power~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~Datetime, type="l", ylab="Voltage (volt)", xlab="")
        {plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
                lines(Sub_metering_2~Datetime,col='Red')
                lines(Sub_metering_3~Datetime,col='Blue')
                legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))}
        plot(Global_reactive_power~Datetime, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off()