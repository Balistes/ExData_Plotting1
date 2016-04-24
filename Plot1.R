# install packages, if it is needed
if(!is.element("datasets", installed.packages()[,1])) {
  install.packages("datasets")
  library(datasets)  
}

if(!is.element("readr", installed.packages()[,1])) {
  install.packages("readr")
  library(readr)
}

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

# install margins and size
par(mar = c(4,4,2,1), oma = c(1,1,1,1), cex.axis = 0.8, cex.lab = 0.8)

# create histogram of Global_active_power
hist(workset$Global_active_power, main="Global Active Power", cex.main = 1.0,
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# copy histogram to png file
dev.copy(png,file = "plot1.png", width=480, height= 480)
dev.off()



