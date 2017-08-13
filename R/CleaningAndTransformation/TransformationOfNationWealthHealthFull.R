source("R/Helper/mapping_between_country_names.R")
library(reshape2)

gdp <-
  read.csv("data/nation_health_and_wealth/raw/indicator gapminder gdp_per_capita_ppp_full.csv")
colnames(gdp)[1] <- "CNT"
gdp <- na.omit(gdp)
gdp.melted <- melt(gdp, id.vars = "CNT")
colnames(gdp.melted)[2] <- "Year"
colnames(gdp.melted)[3] <- "GDP"


life.expectancy <-
  read.csv("data/nation_health_and_wealth/raw/indicator life_expectancy_at_birth_full.csv")
colnames(life.expectancy)[1] <- "CNT"
life.expectancy <- na.omit(life.expectancy)
life.expectancy.melted <- melt(life.expectancy, id.vars = "CNT")
colnames(life.expectancy.melted)[2] <- "Year"
colnames(life.expectancy.melted)[3] <- "life.expectancy"

nation.health.welth <- merge(gdp.melted, life.expectancy.melted)
nation.health.welth <- merge(nation.health.welth, mapping.between.countries, 
                             by.x = "CNT", by.y = "countries1", all.x = T)
nation.health.welth$CNT <- as.character(nation.health.welth$CNT)
nation.health.welth$CNT[!is.na(nation.health.welth$countries2)] <-
  as.character(
    nation.health.welth$countries2[!is.na(nation.health.welth$countries2)])
nation.health.welth$countries2 <- NULL
write.csv(nation.health.welth,
          file= "data/nation_health_and_wealth/nation.wealth.and.health_full.csv",
          row.names = F)
