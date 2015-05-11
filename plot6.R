library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
motorRelatedSCC <- SCC$SCC[grep("Motor",SCC$SCC.Level.Three)]
motorEmissionsBalLASummarized <- NEI %>%
        filter(SCC %in% motorRelatedSCC,
               (fips == "24510" | fips == "06037")) %>%
        group_by(year, fips) %>% summarize(Emissions = sum(Emissions))
png("plot6.png",width=800,height=320)
plot6 <- qplot(year,Emissions,data=motorEmissionsBalLASummarized, 
        facets=.~fips, geom=c("point","smooth"),method="lm")
print(plot6)
dev.off()