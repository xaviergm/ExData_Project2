## Project 2 for the Exploratory Data Analysis Course from Coursera
## plot3.R
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
# - filter() to limit the records to those in fips = 24510 (Baltimore)
# - group_by() to be able to later summarize by summing
# - summarize() to get the sum of the emissions per year.
Baltimore <- filter(NEI, fips == "24510")
Baltimore_grouped <- group_by(Baltimore,year,type)
Baltimore_summarized <- summarize(Baltimore_grouped,
                                  emissions = sum(Emissions, na.rm = TRUE))

# Initialize the plot file as a png but wider so taht the facets fit
png(filename="plot3.png",height = 320, width = 1000)

# Use qplot to create the required facets per type of emission.
plot3 <- qplot(year,emissions,data=Baltimore_summarized, facets=.~type,
      geom=c("point","smooth"),method="lm", se = FALSE)

# Properly annotate the plot with axes labels, overall title and proper years
plot3 <- plot3 + labs(title = "Baltimore Emissions per year by type") +
        scale_x_continuous(breaks = c(1999,2002,2005,2008),
                           labels = c("1999","2002","2005","2008")) +
        xlab("Year") +
        ylab("Emissions")
# Actually write the plot to the file
print(plot3)

# Close the png file
dev.off()