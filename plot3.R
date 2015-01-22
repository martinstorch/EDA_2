setwd("~/LearningR/ExploratoryDataAnalysis/Assignment2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(base)

#Plot 3
library(ggplot2)
data_baltimore <- NEI[NEI$fips == "24510",]
data3 <- aggregate(Emissions ~ year+type, data=data_baltimore, FUN = sum)

plot3 <- qplot(x=as.factor(year), y=Emissions, data = data3, geom = "bar", stat = "identity",
      facets=.~type,      xlab="Year", ylab="PM2.5 emitted in tons",
      main="Total PM2.5 emission in Baltimore City, Maryland")

png(filename = "plot3.png",   width = 960, height = 480)
print(plot3)
dev.off()

