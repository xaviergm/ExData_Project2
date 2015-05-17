## Project 2 for the Exploratory Data Analysis Course from Coursera
## plot1.R
## Ref: exdata-014
## Student: Xavier Gutierrez
## Packages requried: dplyr

# Loading dplyr and ggplot2 packages
library(dplyr)
library(ggplot2)

# Set the working directory to the relevant one
setwd("C:/00-GUTIERRX/Git/user/exploratorydataanalysis2")

# Downloading the required files to the local working directory
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL,"./exdata-dada-NEI_data.zip",method="internal",mode="wb")

# Unzip the required file
unzip("./exdata-dada-NEI_data.zip")

# Loading the National Emissions Inventory RDS file in memory
NEI <- readRDS("summarySCC_PM25.rds")

# Loading the Source Classification Code RDS file in memory
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