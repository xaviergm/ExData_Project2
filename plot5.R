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

motorRelatedSCC <- SCC$SCC[grep("Motor",SCC$SCC.Level.Three)]
motorEmissionsBaltimoreSummarized <- NEI %>%
        filter(SCC %in% motorRelatedSCC, fips == "24510") %>%
        group_by(year) %>% summarize(Emissions = sum(Emissions))
png("plot5.png")
plot5 <- qplot(year,Emissions,data=motorEmissionsBaltimoreSummarized, 
               geom=c("point","smooth"),method="lm")
print(plot5)
dev.off()