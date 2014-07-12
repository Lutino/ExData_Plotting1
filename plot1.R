## Step 1
#  Check for the existence of a data folder. If not existent, then create. 
if(!file.exist("data")){
  dir.create("data")
}

## Step 2
#  Link to the compressed data file and download in data folder
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="householdPower.zip")

## Step 3
# change working directory, Unzip file
setwd("./data")
unzip("./data/householdPower.zip")
setwd("..")

## Step 4
#  Load the data file. 
consumption <- read.table("./data/household_power_consumption.txt", sep=";",  header=TRUE, stringsAsFactors = FALSE)

## Step 5
#  Convert date variable from text to Date class.
consumption$Date <- as.Date(consumption$Date,"%d/%m/%Y")

## Step 6
#  Subset the data to the two dates we need 
twodays<- consumption[elecAll$Date == "2007-02-01" | elecAll$Date == "2007-02-02",]

## Step 7
#  Draw the plot, save a png copy and close de device
hist(as.numeric(paste(twodays$Global_active_power)), col="red", breaks=20, main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png",width=480,height=480)
dev.off()
