# Exploratory Data Analysis
# Proejct 2. Question 6
#   Compare emissions from motor vehicle sources 
#   in Baltimore City with emissions from motor
#   vehicle sources in Los Angeles County, California. 
#   Which city has seen greater change ?

# Include utilities to retrieve external data sources
source('common.R')
getFile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        "data",
        "national.emission.inventory.zip",
        unzip = TRUE)

nei <- readRDS("data/summarySCC_PM25.rds")

two.cities  <- subset(nei, fips %in% c("24510", "06037") & type=="ON-ROAD")

agg <- aggregate(two.cities["Emissions"], 
                 list(city = ifelse(two.cities$fips == "06037", "Baltimore City", "Los Angeles County"), 
                      year = two.cities$year),
                 sum)

library(ggplot2)
library(grid)
library(gridExtra)  # May require additional install
png('plot6.png', width=840, height=360)

# This is just for reference doesn't help much in solving the question
p1 <- ggplot(agg, aes(x=year, y=Emissions, colour=city)) +
        geom_line(size=1) +
        ggtitle(expression("PM" [2.5] ~ " Motor Vehicle Emissions")) 

# normalize - to be able to answer the last question
# Each of the values is set to be relative to its respective city minimim value
for (city in agg$city) {
    agg$Emissions[agg$city == city] <- 
        agg$Emissions[agg$city == city] - min(agg$Emissions[agg$city == city])    
}

p2 <- ggplot(agg, aes(x=year, y=Emissions, colour=city)) +
        geom_line(size=1) +
        ggtitle(expression("PM" [2.5] ~ " Motor Vehicle Emissions (normalized)"))
grid.arrange(p1, p2, ncol = 2, main = "Vehicle Emission LA vs Balt. City")
dev.off()

