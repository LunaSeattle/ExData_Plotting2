library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIonRoad <- NEI[(NEI$fips %in% c("24510","06037")) & (NEI$type=="ON-ROAD"), ]

aggData <- aggregate(NEIonRoad$Emissions, list(Year=NEIonRoad$year, 
  Location=as.factor(NEIonRoad$fips)), sum)

totData <- ddply(aggData,"Location",transform, Growth=c(0,(exp(diff(log(x)))-1)*100))
totData<-as.data.frame(sapply(totData,gsub,pattern="06037",replacement="Los Angeles"))
totData<-as.data.frame(sapply(totData,gsub,pattern="24510",replacement="Baltimore"))

png(filename="figure/plot6.png", width=480, height=480)
ggplot(totData, aes(Year, Growth, fill = Location)) + 
  geom_bar(position = "dodge", stat="identity") + 
  labs(y="Variation (in %)") + 
  ggtitle(expression(atop(" variation of emission of PM2.5", 
    atop(italic("from motor vehicle sources"), ""))))
dev.off()