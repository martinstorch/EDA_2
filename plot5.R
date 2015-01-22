setwd("~/LearningR/ExploratoryDataAnalysis/Assignment2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(base)


#Plot 5
# find all sector names containing "vehicle"
vehicle_sources <- grepl(pattern = "vehicle", x = SCC$EI.Sector, ignore.case = T)
# extract all SCC codes
vehicle_scc <- unique(SCC$SCC[vehicle_sources])
# subset Baltimore
data_baltimore <- NEI[NEI$fips == "24510",]
# subset vehicles in Baltimore
data_vehicles <- data_baltimore[data_baltimore$SCC %in% vehicle_scc,]
# sum by year
data5 <- tapply(X = data_vehicles$Emissions, INDEX = data_vehicles$year, FUN = sum)

png(filename = "plot5.png",   width = 480, height = 480)
barplot(data5, col="lightblue", ylab="PM2.5 emitted in tons")

title("Total PM2.5 emission from \nvehicles in Baltimore City, Maryland")
dev.off()

