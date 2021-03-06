

######Step1 getting and cleaning the data######
start <- grep("1/2/2007", readLines("household_power_consumption.txt"))[1]   ##getting first occurence of our date as character
end1 <- grep("^2/2/2007", readLines("household_power_consumption.txt"))  ##getting the last occurence of our second date as character, the "^" is there as metachacter to avoid to have 22/02/2007

rowtoprint <- end1[length(end1)]-start ##Computing total number of row to print


datatitle <- read.csv(file="household_power_consumption.txt",sep = ";", stringsAsFactors=FALSE,
                      header = FALSE,na.strings = "?",
                      nrows = 1)  ##getting the colonames from the txt file
dataset <- read.csv(file="household_power_consumption.txt",sep = ";", skip=start-1, stringsAsFactors=FALSE,
                    header = FALSE,na.strings = "?",
                    nrows = rowtoprint+1)  ## Getting the data the "-1" in skip and the "+1" in in nrows comes from the fact that we put the header at false so we have to slide from one position our selection
colnames(dataset) <- datatitle ## assigning the name of the variable


dataset$dateNtime <- strptime(paste(dataset$Date,dataset$Time,sep=" "), format = "%d/%m/%Y %H:%M:%S")##having one column with good formal date and time
Finaldataset <- data.frame(dataset$dateNtime,dataset[,c(3:9)])  ##keeping only the relevant columns


###Step 2 getting the plot #####


png("plot2.png", width=480, height=480)  ##choosing the good device here png with 480x480
par(mfrow = c(1,1)) ##determining the number of graph to show, here 1
plot(x=Finaldataset$dataset.dateNtime,y=Finaldataset$Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)",type = "l")  ##plot graph with appropriate x (date and time),y (global active power) label without title and line tipe
##histo graph with appropriate x label and title
dev.off()  ###exiting the device and come back to the screen one

