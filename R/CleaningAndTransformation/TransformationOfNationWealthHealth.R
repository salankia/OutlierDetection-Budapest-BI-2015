source("R/Helper/mapping_between_country_names.R")

life.expectancy <-
  read.csv("data/nation_health_and_wealth/raw/indicator life_expectancy_at_birth.csv")
colnames(life.expectancy)[1] <- "CNT"
life.expectancy <- na.omit(life.expectancy)
life.expectancy <- life.expectancy[, c(1, length(life.expectancy))]
colnames(life.expectancy)[2] <- "life.expectancy"

gdp <- 
  read.csv("data/nation_health_and_wealth/raw/indicator gapminder gdp_per_capita_ppp.csv")
colnames(gdp)[1] <- "CNT"
gdp <- na.omit(gdp)
gdp <- gdp[, c(1, length(gdp))]
colnames(gdp)[2] <- "GDP"

nation.health.welth <- merge(gdp, life.expectancy)
nation.health.welth <- merge(nation.health.welth, mapping.between.countries, 
                             by.x = "CNT", by.y = "countries1", all.x = T)
nation.health.welth$CNT <- as.character(nation.health.welth$CNT)
nation.health.welth$CNT[!is.na(nation.health.welth$countries2)] <-
  as.character(nation.health.welth$countries2[!is.na(nation.health.welth$countries2)])
nation.health.welth$countries2 <- NULL
write.csv(nation.health.welth, file = "data/nation_health_and_wealth/nation.wealth.and.health.csv", row.names = F)
