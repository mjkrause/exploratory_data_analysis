plot4 <- function() {
# function plot4

# Creates a plot from data in file "household_power_consumption.txt".
# That file contains approx. 2.1*10^6 rows and 9 columns. The entire file is expected to use approx. 2.1*10^6 * 9 * 8 bytes, or 0.14 GB of memory.

# Read data as data frame.
dat <- read.table('household_power_consumption.txt', 
			header=TRUE, na.strings="?", sep=";",
			stringsAsFactors=FALSE)

dat <- dat[complete.cases(dat),] # remove NAs
# Set date to default format.
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
# Generate index of date range of interest and subset dat.
idx <- grep("^2007-02-0(1|2)", dat$Date)
dat <- dat[idx,]
x <- with(dat, paste(Date, Time)) # combine columns
x <- strptime(x, "%Y-%m-%d %H:%M:%S") # format to POSIX, date-time

# Create plot4 with 4 subplots.
par(mfrow=c(2,2))

# Subplot 1
y <- dat$Global_active_power
plot(x,y,type="l",xlab="",ylab="Global Active Power (kilowatts)")

# Subplot 2
y <- dat$Voltage
plot(x,y,type="l",xlab="datetime",ylab="Voltage")

# Subplot 3
y1 <- dat$Sub_metering_1
y2 <- dat$Sub_metering_2
y3 <- dat$Sub_metering_3

plot(x, y1, type='n',
		xlab="",ylab="Energy sub metering")
lines(x, y1, col="black")
lines(x, y2, col="red")
lines(x, y3, col="purple")
legend("topright",
		lty=c(1,1), # assign appropriate symbols for legend (lines)
		bty='n', # no box around legend
		col=c("black","red","purple"), 
		legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Subplot 4
y <- dat$Global_reactive_power
plot(x,y,type="l",xlab="datetime",ylab="Global_reactive_power")

# Generate PNG file of plot on screen device.
dev.copy(png, file="plot4.png", width=480, height=480, units='px', bg='white')
dev.off()

dat # return

}
