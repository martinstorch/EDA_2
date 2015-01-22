setwd("~/LearningR/ExploratoryDataAnalysis/Assignment2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(base)


#Plot 4
# find all sector names containing "coal"
coal_combustion_sources <- grepl(pattern = "coal", x = SCC$EI.Sector, ignore.case = T)
# extract all SCC codes
ccs_scc <- unique(SCC$SCC[coal_combustion_sources])
#filter out all SCC codes
data_coal <- NEI[NEI$SCC %in% ccs_scc,]
#sum emissions by year into a matrix
data4 <- tapply(X = data_coal$Emissions, INDEX = data_coal$year, FUN = sum)

png(filename = "plot4.png",   width = 480, height = 480)
barplot(data4/1000, col="lightblue", ylab="PM2.5 emitted in 1000 tons")

title("Total PM2.5 emission from \ncoal combustion-related sources\nin the United States")
dev.off()

