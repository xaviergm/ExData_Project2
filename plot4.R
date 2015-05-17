## Project 2 for the Exploratory Data Analysis Course from Coursera
## plot4.R
## Ref: exdata-014
## Student: Xavier Gutierrez
## Packages requried: dplyr, ggplot2

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

# Use the dplyr functions:
# - filter() to limit the records to those in that are coming directly from Coal
# - group_by() to be able to later summarize by summing
# - summarize() to get the sum of the emissions per year.
#coalRelatedSCC <- SCC$SCC[grep("Coal",SCC$SCC.Level.Three)]
coalCombustionSCC <- SCC$SCC[grep("Coal$",SCC$SCC.Level.Three)]
#coalEmissions <- filter(NEI,NEI$SCC %in% coalCombustionSCC)
coalEmissionsSummarized <- NEI %>% filter(SCC %in% coalCombustionSCC) %>%
        group_by(year) %>% summarize(Emissions = sum(Emissions))

# Initialize the plot file
png("plot4.png", height = 320, width = 400)

# Create the scatter plot using qplot and adding a linear regression line
plot4 <- qplot(year,Emissions,data=coalEmissionsSummarized, 
        geom=c("point","smooth"),method="lm", se = F)

# Properly annotate the plot with axes labels, overall title and proper years
plot4 <- plot4 + labs(title = "Coal Emissions per Year") +
        scale_x_continuous(breaks = c(1999,2002,2005,2008),
                           labels = c("1999","2002","2005","2008")) +
        xlab("Year") +
        ylab("Emissions")

# Save the plot to the initialized file.
print(plot4)

# Close the file.
dev.off()