setwd("~/LearningR/ExploratoryDataAnalysis/Assignment2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(base)


#Plot 2
data_baltimore <- NEI[NEI$fips == "24510",]
data2 <- tapply(X = data_baltimore$Emissions, INDEX = data_baltimore$year, FUN = sum)

png(filename = "plot2.png",   width = 480, height = 480)
barplot(data2, col="lightblue", ylab="PM2.5 emitted in tons")

title("Total PM2.5 emission in Baltimore City, Maryland")
dev.off()

