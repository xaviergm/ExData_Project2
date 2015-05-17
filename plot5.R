## Project 2 for the Exploratory Data Analysis Course from Coursera
## plot5.R
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

# Use the dplyr functions:
# - filter() to limit the records to those in that are coming directly from
#   motor vehicles and with fips = 24510 (Baltimore)
# - group_by() to be able to later summarize by summing
# - summarize() to get the sum of the emissions per year.
motorRelatedSCC <- SCC$SCC[grep("Motor",SCC$SCC.Level.Three)]
motorEmissionsBaltimoreSummarized <- NEI %>%
        filter(SCC %in% motorRelatedSCC, fips == "24510") %>%
        group_by(year) %>% summarize(Emissions = sum(Emissions))

# Initialize the plot file
png("plot5.png", height = 320, width = 400)

# Create the scatter plot with qplot and add a linear regression line
plot5 <- qplot(year,Emissions,data=motorEmissionsBaltimoreSummarized, 
               geom=c("point","smooth"),method="lm", se = F)

# Properly annotate the plot with axes labels, overall title and proper years
plot5 <- plot5 + labs(title = "Motor Vehicle Emissions in Baltimore per year") +
        scale_x_continuous(breaks = c(1999,2002,2005,2008),
                           labels = c("1999","2002","2005","2008")) +
        xlab("Year") +
        ylab("Emissions")

# Write the plot to the file.
print(plot5)

# Close the plot file
dev.off()