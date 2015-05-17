## Project 2 for the Exploratory Data Analysis Course from Coursera
## plot1.R
## Ref: exdata-014
## Student: Xavier Gutierrez
## Packages requried: dplyr

# Loading dplyr package
library(dplyr)

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

# Use dplyr group_by() and summarize() to add up all the emissions for the 
# different years
NEI_grouped <- group_by(NEI,year)
NEI_summarized <- summarize(NEI_grouped, emissions = sum(Emissions,
        na.rm = TRUE))

# Create a linear model to be able to show the trend in the plot
NEI_model <- lm(emissions ~ year, NEI_summarized)

# Initialize the plot file
png(filename="plot1.png")

# Do the scatterplot of the total emissions per year without axes.
with(NEI_summarized, 
     plot(year, emissions, axes = F, col = "blue", pch = 20,
          xlab = "Year", ylab = "Total Emissions"))

# Add the box and the axes
box()
axis(1, at = c(1999, 2002, 2005, 2008))
axis(2, at = c(3e+06, 5e+06, 7e+06))

# Add the linear model to the plot
abline(NEI_model, lwd=2, col="red")

# Annotate the plot properly
title(main = "Total US Emissions per year")

# Close the plot file
dev.off()