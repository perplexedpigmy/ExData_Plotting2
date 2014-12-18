# Exploratory Data Analysis
# Proejct 2. Question 3
#   Of the four types of sources indicated by the 
#   type (point, nonpoint, onroad, nonroad) in Baltimore city, 
#   Which have seen increase/decrease? use ggplot2

# Include utilities to retrieve external data sources
source('common.R')

getFile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        "data",
        "national.emission.inventory.zip",
        unzip = TRUE)

nei <- readRDS("data/summarySCC_PM25.rds")

baltimore <- subset(nei, fips == "24510")
agg <- aggregate(baltimore["Emissions"], 
        list(type = baltimore$type,
        year = baltimore$year),
        sum)

library(ggplot2)
png('plot3.png', width=480, height=480)
    print(
      ggplot(agg, aes(x=year, y=Emissions, colour=type)) +
          geom_smooth(size=1) +
          ggtitle(expression("PM"  [2.5] ~ " Emissions by Type (Baltimore City)"))
    )
dev.off()