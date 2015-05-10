library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Baltimore <- filter(NEI, fips == 24510)
Baltimore_grouped <- group_by(Baltimore,year,type)
Baltimore_summarized <- summarize(Baltimore_grouped,
                                  emissions = sum(Emissions, na.rm = TRUE))
png(filename="plot3.png",width=960)
plot3 <- qplot(year,emissions,data=Baltimore_summarized, facets=.~type,
      geom=c("point","smooth"),method="lm")
print(plot3)
dev.off()