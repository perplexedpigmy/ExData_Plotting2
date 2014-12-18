# Exploratory Data Analysis
# Proejct 2. Question 5
#   How have emissions from motor vehicle sources 
#   changed from 1999–2008 in Baltimore City?

# Include utilities to retrieve external data sources
source('common.R')
getFile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        "data",
        "national.emission.inventory.zip",
        unzip = TRUE)

nei <- readRDS("data/summarySCC_PM25.rds")

baltimore <- subset(nei, fips == "24510" & type=="ON-ROAD")
agg <- aggregate(baltimore["Emissions"], list(year = baltimore$year), sum)

library(ggplot2)
png('plot5.png', width=480, height=480)
print(
    ggplot(agg, aes(x=year, y=Emissions)) +
        geom_line(size=1) +
        ggtitle(expression("PM" [2.5] ~ " Motor Vehicle Emissions (Baltimore City)")) +
        theme(legend.position="none")
)
dev.off()
