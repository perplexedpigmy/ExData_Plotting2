# Exploratory Data Analysis
# Proejct 2. Question 4
#   Across the United States, how have emissions from coal 
#   combustion-related sources changed from 1999–2008 ?

# Include utilities to retrieve external data sources
source('common.R')
getFile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        "data",
        "national.emission.inventory.zip",
        unzip = TRUE)

nei <- readRDS("data/summarySCC_PM25.rds")
scc <- readRDS("data/Source_Classification_Code.rds")

# Note:
# Although the excercise suggests that the name may be used.
# EI.Sector is complimetary when trying to identify pollutant source
# This step acquires all SCCs in the 'scc table' whose Short.Name or EI.Sector
# whose value contains combastion and Coal.
# This is just my way, Despire my best effort I couldn't find any complete 
# description of what should be in each column and whether it can be authoritativly
# stand along indicate on the pollutnat's origin.

coal.scc <- subset(scc, grepl("comb.*coal|coal.*comb", scc$EI.Sector,  ignore.case=T) |
                        grepl("comb.*coal|coal.*comb",scc$Short.Name, ignore.case=T),
                  , select=SCC)
nei.coal <- subset(nei, nei$SCC %in%  coal.scc$SCC)
agg <- aggregate(nei.coal["Emissions"], 
                 list(type = nei.coal$type,
                      year = nei.coal$year
                      ), 
                 sum)

library(ggplot2)
png('plot4.png', width=480, height=480)
    print(
        ggplot(agg, aes(x=year, y=Emissions, colour=type)) +
        geom_line(aes(size="total")) +
        ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
        xlab("Year") + ylab(expression("Emissions")) +
        stat_summary(fun.y = "sum", color = "black", geom="line", aes(shape="mean") ) 
    )
dev.off()
