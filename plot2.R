# Exploratory Data Analysis
# Proejct 2. Question 2
#   Have total emissions from PM2.5 decreased in the Baltimore City,
#   Maryland (fips == "24510") from 1999 to 2008. Use base plotting system.

# Include utilities to retrieve external data sources
source('common.R')

getFile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        "data",
        "national.emission.inventory.zip",
        unzip = TRUE)

nei <- readRDS("data/summarySCC_PM25.rds")

baltimore <- subset(nei, fips == "24510")
agg <- aggregate(baltimore["Emissions"], list(year = baltimore$year), sum)

png('plot2.png', width=480, height=480)
    plot(agg$year, agg$Emissions, type = "l", 
         main = expression('Total PM' [2.5] ~ ' Emissions (Baltimore City)'),
         xlab = "Year", ylab = "Emissions")
dev.off()