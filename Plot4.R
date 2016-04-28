# install packages, if it is needed
if(!is.element("datasets", installed.packages()[,1])) {
  install.packages("datasets")
}
library(datasets)  

if(!is.element("readr", installed.packages()[,1])) {
  install.packages("readr")
}
library(readr)

# create directory for dataset, load and read file, create dataset (if data is missing)
if( !file.exists("./data")) {
  dir.create("./data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./data/household_power_consumption.zip", method = "curl")
  unzip(zipfile="./data/household_power_consumption.zip",exdir="./data")
  
  # read data
  hpcset <- read.table(file.path("./data","household_power_consumption.txt"), header=TRUE, sep=";", stringsAsFactors = FALSE,
                       na.string = "?", quote= "", strip.white=TRUE)
  
  # convert Date and Time in R object  
  hpcset$Time <- strptime(paste(hpcset$Date,hpcset$Time),"%d/%m/%Y %H:%M:%S")
  hpcset$Date <- as.Date(hpcset$Date,"%d/%m/%Y")
  # create set of work's data
  workset <- subset(hpcset,hpcset$Date == "2007-02-01" | hpcset$Date == "2007-02-02")  
  
}

# create multiple graph, install margins and size
par(mfrow=c(2,2), oma = c(1,1,1,1), mar = c(4,4,2,1), cex.axis = 0.9, cex.lab = 0.9)

# top left graph
with(workset,plot(workset$Time, workset$Global_active_power, type= "l", lwd=1, 
                  xlab ="", ylab = "Global Active Power") )

# top right graph
with(workset,plot(workset$Time, workset$Voltage, type="l", xlab="datetime", ylab="Voltage") )

# bottom left graph
with(workset,plot(workset$Time, workset$Sub_metering_1, type="l", xlab="", ylab= "Energy sub metering"))
lines(workset$Time, workset$Sub_metering_2, type="l", col="red")
lines(workset$Time, workset$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = , lty = , lwd = 1, 
        bty = "n", cex = 0.65, xjust = 1.3, col = c("black", "red", "blue")) 

# bottom right
with(workset,plot(workset$Time, workset$Global_reactive_power, 
                  type="l", xlab="datetime", ylab="Global_reactive_power"))

# copy graph to png file
dev.copy(png,file = "plot4.png", width=480, height= 480)
dev.off()
