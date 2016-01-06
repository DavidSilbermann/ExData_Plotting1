## Create the first plot

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
# to cheack myself
df <- cbind(DateTime, df)

## Construct the plot

# open a png device
png(file = "plot1.png", width = 480, height = 480)

hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()
