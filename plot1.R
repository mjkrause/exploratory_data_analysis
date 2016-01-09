plot1 <- function() {
# function plot1

# Creates a plot from data in file "household_power_consumption.txt".
# That file contains approx. 2.1*10^6 rows and 9 columns. The entire file is expected to use approx. 2.1*10^6 * 9 * 8 bytes, or 0.14 GB of memory.



# Read data as data frame.
dat <- read.table('household_power_consumption.txt', 
			header=TRUE, na.strings="?", sep=";",
			#nrows=5000, 
			stringsAsFactors=FALSE)

dat<-dat[complete.cases(dat),] # remove NAs
# Set date to default format.
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
# Generate index of date range of interest and subset dat.
idx <- grep("^2007-02-0(1|2)", dat$Date)
dat <- dat[idx,]
# Create plot1
hist(dat$Global_active_power, 
		main="Global active power",
		col="red",
		xlab="Global active power (kilowatts)")
# Generate PNG file of plot on screen device.
dev.copy(png, file="plot1.png", width=480, height=480, units='px', bg='white')
dev.off()

}
