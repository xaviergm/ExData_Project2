library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
coalRelatedSCC <- SCC$SCC[grep("Coal",SCC$SCC.Level.Three)]
coalCombustionSCC <- SCC$SCC[grep("Coal$",SCC$SCC.Level.Three)]
coalEmissions <- filter(NEI,NEI$SCC %in% coalCombustionSCC)
coalEmissionsSummarized <- NEI %>% filter(SCC %in% coalCombustionSCC) %>%
        group_by(year) %>% summarize(Emissions = sum(Emissions))
png("plot4.png")
plot4 <- qplot(year,Emissions,data=coalEmissionsSummarized, 
        geom=c("point","smooth"),method="lm")
print(plot4)
dev.off()