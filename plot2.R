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
download.file(fileUrl,"./exdata-dada-NEI_data.zip",method="internal",mode="wb")

# Unzip the required file
unzip("./exdata-dada-NEI_data.zip")

# Loading the National Emissions Inventory RDS file in memory
NEI <- readRDS("summarySCC_PM25.rds")

# Loading the Source Classification Code RDS file in memory
SCC <- readRDS("Source_Classification_Code.rds")

# Use the dplyr functions:
# - filter() to limit the records to those in fips = 24510 (Baltimore)
# - group_by() to be able to later summarize by summing
# - summarize() to get the sum of the emissions per year.
Baltimore <- filter(NEI, fips == "24510")
Baltimore_grouped <- group_by(Baltimore,year)
Baltimore_summarized <- summarize(Baltimore_grouped,
        emissions = sum(Emissions, na.rm = TRUE))

# Use lm() in order to generate a linear model to see if there is a trend
Baltimore_model <- lm(emissions ~ year, Baltimore_summarized)

# Initialize the plot file (.png)
png(filename="plot2.png")

# Using the base plotting function plot(), do a scatter plot of the emissions
# in Baltimore per year and add the linear model using abline()
with(Baltimore_summarized, plot(year, emissions))
abline(Baltimore_model, lwd=2)

# Close the plot file.
dev.off()