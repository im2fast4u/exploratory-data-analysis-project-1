#read the consumption data into R
data <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')


#convert date column
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Create a subset of required dates and remove the original large data set
data_subset <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
rm("data")

#Create a new Datetime column with POSIXct class
data_subset$Datetime <- strptime(paste(data_subset$Date, data_subset$Time), "%Y-%m-%d %H:%M:%S")
data_subset$Datetime <- as.POSIXct(data_subset$Datetime)

#Plot-2
with(data_subset, plot(Datetime, Global_active_power, 
                       type="l", xlab="", ylab="Global Active Power (kilowatts)"))

#Save file
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
