library(ggplot2)
source("R/Helper/default_ggplot2_theme_for_biforum2015.R")
source("R/Visualization/UnifiedVisualizationOfWealthAndHealthData.R")
source("R/Visualization/ColoredWorldMap.R")
source("R/OutlierDetection/detection_lof.R")
source("R/OutlierDetection/detection_db.R")
source("R/OutlierDetection/detection_depth.R")
source("R/OutlierDetection/detection_bacon.R")

nation.health.welth <-
  read.csv("data/nation_health_and_wealth/nation.wealth.and.health.csv")

## some normalization needed because of the different units
demo.data <- apply(X = nation.health.welth[, 2:3], MARGIN = 2,
                   FUN =  function(col) {
                     (col - min(col)) / (max(col) - min(col))
                     })
colnames(demo.data) <- c("x", "y")
demo.data <- as.data.frame(demo.data)

############## Basic visualization #############################################
base <- ggplot(nation.health.welth)
base + geom_point(aes(x = GDP, y = life.expectancy), size = 5) + 
  xlab("GDP per capita") + ylab("Life expectancy") +
  default.theme

################ LOF  ##########################################################
## Compute
lof.color <- ComputesLof(demo.data = demo.data)

## Visualize
PlotTheScatterForNationWealthHealth(nation.health.welth, lof.color, 1,
                                    "LOF",
                                    c("darkgreen", "orange", "red"))
PlotAMap(nation.health.welth, lof.color, "LOF", c("darkgreen", "orange", "red"))

## Print the most important results
(nation.health.welth %>% filter(lof.color > 2.5))

########################### DB #################################################
## Compute
db.color <- ComputesDB(demo.data, 0.06, max.points = 10000)

## Visualize
PlotTheScatterForNationWealthHealth(nation.health.welth, db.color, -1,
                                    name = "Neighbor ratio",
                                    colours = c("red", "orange", "darkgreen"),
                                    values = c(0, 0.1, 1))

PlotAMap(nation.health.welth, db.color, name = "Neighbor ratio",
         colours = c("red", "orange", "darkgreen"),
         values = c(0, 0.1, 1))

## Print the most important results
(nation.health.welth %>% filter(db.color < 0.01))

############################# depth ############################################
## Compute
depth.color <- ComputesDepth(demo.data)

## Visualize
PlotTheScatterForNationWealthHealth(nation.health.welth, depth.color, -1,
                                    name = "Layer",
                                    colours = c("red", "orange", "darkgreen"),
                                    values = c(0, 0.1, 1))

PlotAMap(nation.health.welth, depth.color, name = "Layer",
         colours = c("red", "orange", "darkgreen"),
         values = c(0, 0.1, 1))

## Print the most important results
(nation.health.welth %>% filter(depth.color < 1))

####################x BACON ####################################################
## Compute
bacon.color <- ComputesBacon(demo.data)

## Visualize
PlotTheScatterForNationWealthHealth(nation.health.welth, bacon.color, 1,
                                    name = "Robust distance",
                                    colours = c("darkgreen", "orange", "red"),
                                    values = c(0, 0.2, 1))

PlotAMap(nation.health.welth, bacon.color, name = "Robust distance",
         colours = c("darkgreen", "orange", "red"),
         values = c(0, 0.2, 1))

## Print the most important results
(nation.health.welth %>% filter(bacon.color > 300))
