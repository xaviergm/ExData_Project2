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

# Use dplyr group_by() and summarize() to add up all the emissions for the 
# different years
NEI_grouped <- group_by(NEI,year)
NEI_summarized <- summarize(NEI_grouped, emissions = sum(Emissions,
        na.rm = TRUE))

# Create a linear model to be able to show the trend in the plot
NEI_model <- lm(emissions ~ year, NEI_summarized)

# Initialize the plot file
png(filename="plot1.png")

# Do the scatterplot of the total emissions per year.
with(NEI_summarized, plot(year, emissions))

# Add the linear model to the plot
abline(NEI_model, lwd=2)

# Close the plot file
dev.off()