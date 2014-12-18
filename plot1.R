# Exploratory Data Analysis
# Proejct 2. Question 1
#   make a plot showing the total PM2.5 emission from all 
#   sources for each of the years 1999, 2002, 2005, and 2008

# Include utilities to retrieve external data sources
source('common.R')

getFile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
       "data",
       "national.emission.inventory.zip",
       unzip = TRUE)

nei <- readRDS("data/summarySCC_PM25.rds")

agg <- aggregate(nei["Emissions"], list(year = nei$year), sum)

png('plot1.png', width=480, height=480)
    plot(agg$year, agg$Emissions, type = "l", 
         main = expression('Total PM'  [2.5] ~ ' Emissions (US)'),
         xlab = "Year", ylab = "Emissions")
dev.off()