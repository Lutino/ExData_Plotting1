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
#  Create a timestamp for each observation
twodays$DateTime <- strptime(paste(twodays$Date,twodays$Time),"%Y-%m-%d %H:%M:%S")


## Step 8
#  Draw the plot
with(twodays, {
  plot(DateTime, as.numeric(paste(Sub_metering_1)), type="l", xlab ="", ylab = "Energy sub Metering")
  lines(DateTime, as.numeric(paste(Sub_metering_2)), type="l", xlab ="", ylab = "",col="red")
  lines(DateTime, as.numeric(paste(Sub_metering_3)), type="l", xlab ="", ylab = "",col="blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty= "solid")
}) 

## Step 9
#  Open a graphic device, save a png copy and close de device
dev.copy(png, file="plot3.png",width=480,height=480,res=45)
dev.off()

