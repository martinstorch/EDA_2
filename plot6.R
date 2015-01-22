setwd("~/LearningR/ExploratoryDataAnalysis/Assignment2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(base)

#Plot 6
# find all sector names containing "vehicle"
vehicle_sources <- grepl(pattern = "vehicle", x = SCC$EI.Sector, ignore.case = T)
# extract all SCC codes
vehicle_scc <- unique(SCC$SCC[vehicle_sources])

# subset to respective city 
data_baltimore <- NEI[NEI$fips == "24510",]
data_losangeles <- NEI[NEI$fips == "06037",]
# subset to vehicles from those cities
data_vehicles_ba <- data_baltimore[data_baltimore$SCC %in% vehicle_scc,]
data_vehicles_la <- data_losangeles[data_losangeles$SCC %in% vehicle_scc,]

#combine into data.frame
data_vehicles_ba_la <- rbind(cbind(data_vehicles_ba, city="Baltimore"), cbind(data_vehicles_la, city="Los Angeles"))
# sum by city and year
data6 <- aggregate(Emissions ~ city+year, data=data_vehicles_ba_la, FUN = sum)

png(filename = "plot6.png",   width = 480, height = 480)
# three plots on the page
layout(matrix(c(1,3,2,3), 2, 2, byrow = TRUE))
# the usual barplots above each other
with (subset(data6, city=="Baltimore"), {
  barplot(Emissions, names.arg=year, col="lightblue", ylab="PM2.5 emitted in tons", xlab="Year")
  title("Total PM2.5 emission from \nvehicles in Baltimore City, Maryland")
})
with (subset(data6, city=="Los Angeles"), {
  barplot(Emissions, names.arg=year, col="lightblue", ylab="PM2.5 emitted in tons", xlab="Year")
  title("Total PM2.5 emission from \nvehicles in Los Angeles, California")
})
# on the right hand side, print a line chart with one line per city, each having its own axis
par(mar=c(5, 4, 4, 3) + 0.1)
with (subset(data6, city=="Los Angeles"), {
  plot(Emissions ~ year, type = "b", lwd=2, col="red", ylim=c(0, 5000), ylab="PM2.5 emitted in tons", xlab="Year", pch=3)
})
# replot the left axis with red numbers (for L.A.)
axis(side=2, col.axis="red")
## Allow a second plot on the same graph
par(new=TRUE)
# plot without axis
with (subset(data6, city=="Baltimore"), {
  plot(Emissions~ year, type = "b", lwd=2, col="green", ylim=c(1, 500), axes=F, ylab="", pch=1)
})
# put green axis to the right
axis(side=4, at=c(seq(from = 0, to=500, by = 100)), col.axis="green")
mtext("PM2.5 emitted in tons",side=4,col="green",line=4) 
title("Comparison of PM2.5 \nemission from vehicles")
legend(x = "bottomleft", legend = c("Baltimore", "Los Angeles"), col=c("green", "red"), lty = 1, lwd=2, pch = c(1,3))

dev.off()

