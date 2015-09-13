### This code assumes that you have the zip dataset
### "exdata_data_household_power_consumption.zip" 
### in your working directory

### Unzip file
unzip("exdata_data_household_power_consumption.zip")

### Index of rows containing information for 2007/02/01 and 2007/02/01 
index <- grep("^[1-2]/2/2007", readLines("household_power_consumption.txt"))

### Read only rows containing information for 2007/02/01 and 2007/02/01
housepwc <- read.table("household_power_consumption.txt", sep = ";", 
                       skip = min(index)-1, nrows = length(index))
### Rename columns
colnames(housepwc) <- colnames(read.table("household_power_consumption.txt", 
                                          nrows = 1, header = TRUE, 
                                          sep =";"))

### Add datetime variable, pasting Date and Time variables
housepwc$datetime <- paste(housepwc$Date, housepwc$Time)

### Convert datetime to POSIXlt class 
housepwc$datetime <- strptime(housepwc$datetime, 
                              format = "%d/%m/%Y %H:%M:%S")

### Plot 1
### Open png file device
png("plot1.png", bg="transparent", width = 480, height = 480, units = "px")
### Create plot1 on png device
hist(housepwc$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
### Close the png file device
dev.off()