## Create the third plot

# Load the dplyr package for later use
library(dplyr)

# Read the data from a file into a dataframe


dat <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Split out just the dates that we're looking at (Feb. 1st and 2nd, 2007)
# The dates in the file appear to be in day/month/year format 

df <- dat[ dat$Date %in% c("1/2/2007", "2/2/2007"), ]

# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime()  and as.Date() functions

# Convert the Date column, which is currently a string to an R Date type
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# Paste the date and time together and convert to POSIX.lt class
x <- paste(df$Date, df$Time)

DateTime <- strptime(x, "%Y-%m-%d %H:%M:%S")

# Add the DateTime column back to the original dataset.  I've left the Date and Time variable 
# to check myself
df <- cbind(DateTime, df)

## Construct the plots

# open a png device
png(file = "plot4.png", width = 480, height = 480)

# Create a 2 by 2 "Canvas"
par(mfcol = c(2,2))

# Build plot 1 
plot(df$DateTime, df$Global_active_power , ylab = "Global Active Power", xlab = "", type = "l")

# Build plot 2
plot(df$DateTime, df$Sub_metering_1 , ylab = "Energy sub metering", xlab = "", type = "l")
lines(df$DateTime, df$Sub_metering_2, type="l", col="red")
lines(df$DateTime, df$Sub_metering_3, type="l", col="blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty = c(1,1,1)
       ,bty = "n"
       ,col = c("black","red", "blue")) 

# Build plot 3
plot(df$DateTime, df$Voltage , ylab = "Voltage", xlab = "datetime", type = "l")

# Build plot 4
plot(df$DateTime, df$Global_reactive_power , ylab = "Global_reactive_power", xlab = "datetime", type = "l")

dev.off()