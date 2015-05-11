library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
motorRelatedSCC <- SCC$SCC[grep("Motor",SCC$SCC.Level.Three)]
motorEmissionsBaltimoreSummarized <- NEI %>%
        filter(SCC %in% motorRelatedSCC, fips == "24510") %>%
        group_by(year) %>% summarize(Emissions = sum(Emissions))
png("plot5.png")
plot5 <- qplot(year,Emissions,data=motorEmissionsBaltimoreSummarized, 
               geom=c("point","smooth"),method="lm")
print(plot5)
dev.off()