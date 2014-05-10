# Read the file into a dataframe and perform some tweaks in order to speed up 
# the operation
consumption <- read.table("household_power_consumption.txt", 
                                header=T, 
                                colClasses="character",
                                sep=";",
                                comment.char="",
                                na.strings="?")

# Keep only the data for dates 2007-02-01 and 2007-02-02
consumption <- consumption[consumption$Date %in% c("1/2/2007", "2/2/2007"), ]


# Transform the numerical variables into their proper type (=numeric)
consumption$Global_active_power <- as.numeric(consumption$Global_active_power)
consumption$Global_reactive_power <- as.numeric(consumption$Global_reactive_power)
consumption$Voltage <- as.numeric(consumption$Voltage)
consumption$Global_intensity <- as.numeric(consumption$Global_intensity)
consumption$Sub_metering_1 <- as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 <- as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 <- as.numeric(consumption$Sub_metering_3)


# Create a new variable that is the combination of "Date" and "Time".
# This will come in handy later in the plots.
consumption$datetime <- paste(consumption$Date, consumption$Time)
consumption$datetime <- as.POSIXct(consumption$datetime, format="%d/%m/%Y %H:%M:%S")


## Plot 3
## This has to be done in steps.

# Open the png devices
png(filename = "plot3.png", width = 480, height = 480)

# First create the plot using the line for "Sub_metering_1" 
plot(consumption$datetime, consumption$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", main="")

# Then, add via the "points()" function the lines for "Sub_metering_2" and "Sub_metering_3"
points(consumption$datetime, consumption$Sub_metering_2, type="l", col="red")
points(consumption$datetime, consumption$Sub_metering_3, type="l", col="blue")

# Finally, add a legend
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the png device
dev.off()
