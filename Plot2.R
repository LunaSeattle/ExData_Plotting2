library(plyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
aggDataPerYear <- ddply(NEI[NEI$fips == "24510",], c("year"), 
  function(df)sum(df$Emissions, na.rm=TRUE))
png(filename="figure/plot2.png", width=480, height=480)
plot(aggDataPerYear$year, totalPerYear$V1, type="l", xlab="Year", 
  ylab="PM2.5 (tons)", main="PM2.5 Generated between years 1999-2008 in Baltimore City, MD")
dev.off()