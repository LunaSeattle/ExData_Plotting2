library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
coalSources <- SCC[grep("^Coal ", SCC$Short.Name, ignore.case=F),"SCC"]
aggData <- ddply(NEI[NEI$SCC %in% coalSources,], c("year"), 
  function(df)sum(df$Emissions, na.rm=TRUE))
names(aggData) <- c('Year', 'Emissions')
png(filename="figure/plot4.png", width=480, height=480)
ggplot(aggData, aes(x=Year,y=Emissions))+
  geom_line()+
  xlab('Year')+
  ylab('Total PM2.5 Emissions (tons)')+
  ggtitle('Total Emissions Trend from Coal Combustion-related sources')
dev.off()