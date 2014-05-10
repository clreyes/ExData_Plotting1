# Exploratory Data Analysis - Project 1
# Plot 3
# ----------------------------------------------

# load dataset
hpc <- read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors=FALSE)
# remove rows with NAs in column Sub-metering_3 ... this would remove all missings values coded as '?' in columns 3 to 8
hpc <- hpc[complete.cases(hpc),]
# convert Date and Time to POSIXlt
hpc$DateTime <- strptime(paste(hpc$Date,hpc$Time),format="%d/%m/%Y %H:%M:%S")
# filter dataset to observations from Feb 2007 and weekdays Thu/Fri
hpc <- hpc[format(hpc$DateTime,format="%b%Y")=="Feb2007" &
               weekdays(hpc$DateTime,abbreviate=TRUE)%in%c("Thu","Fri"),]
# reduce dataset to first two consecutive Thu-Fri observations in Feb 2007
hpc <- hpc[hpc$Date%in%c("1/2/2007","2/2/2007"),]

# open png file device
png(filename="plot3.png",width=480,height=480)
# create plot 3
plot(hpc$DateTime,as.numeric(hpc$Sub_metering_1),type="l",
     main="",xlab="",ylab="Energy sub metering")
points(hpc$DateTime,as.numeric(hpc$Sub_metering_2),type="l",col="red")
points(hpc$DateTime,as.numeric(hpc$Sub_metering_3),type="l",col="blue")
legend("topright",pch="-",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# close the png file device
dev.off()