library(plyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
totData <- ddply(NEI[NEI$fips == "24510",], c("year", "type"), 
  function(df)sum(df$Emissions, na.rm=TRUE))
png(filename="figure/plot3.png", width=480, height=480)
ggplot(data=totData, aes(x=year, y=V1, group=type, colour=type)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 (tons)") +
  ggtitle("Total PM2.5 Emissions (tons) Per Year by Source Type")
dev.off()
