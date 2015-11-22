library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEIonRoad <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"), ]
aggData <- aggregate(NEIonRoad$Emissions, list(Year=NEIonRoad$year), sum)
aggData$x <- aggData$x/1000
png(filename="figure/plot5.png", width=480, height=480)
p <- ggplot(aggData) + 
  geom_line(aes(y = x, x = Year)) + 
  labs(y="Amount of PM2.5 emitted (tons)") + 
  ggtitle(expression(atop("Total PM2.5 emission from motor vehicle sources", 
    atop(italic("Baltimore City, Maryland"), ""))))
dev.off()