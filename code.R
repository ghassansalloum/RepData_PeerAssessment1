library(dplyr) # install.packages("dplyr") if you don't have this library on your system
library(data.table) # assumes library "data.table" already installed. Used to fast-read the data file.

# Replace the following with the correct folder on your machine
setwd("C:\\Users\\G\\SkyDrive\\Documents\\Coursera\\Reproducible research")

url="https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
urlfile = "activity.zip"
file="activity.csv"

# download the file if you don't already have it in your working directory
if (!file.exists(urlfile))
  download.file(url, destfile=urlfile)

# unzip the file if you haven't already done so in your working directory
if (!file.exists(file)) {
  unzip(urlfile)
}

mydata <- read.csv(file)


cleandata<- summarise(group_by(mydata, date), total=sum(steps, na.rm=T))

barplot(cleandata$total, main="Daily activity", xlab="Days", ylab="Steps")
mean(cleandata$total)
median(cleandata$total)

cleandata<- summarise(group_by(mydata, interval), mean=mean(steps, na.rm=T))
x<-which(cleandata$mean==max(cleandata$mean))
mydata[x, "interval"]
plot(cleandata$mean, type="l", main="Daily activity patterns", xlab="Time interval", ylab="Steps")


sum(is.na(mydata$steps))