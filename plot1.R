setwd("~/LearningR/ExploratoryDataAnalysis/Assignment2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(base)

#Plot 1
years <- c(1999, 2002, 2005, 2008)
data1 <- tapply(X = NEI$Emissions, INDEX = NEI$year, FUN = sum)

png(filename = "plot1.png",   width = 480, height = 480)
barplot(data1/1000000, col="lightblue", ylab="PM2.5 emitted in mio. tons")

title("Total PM2.5 emission in the United States")
dev.off()

