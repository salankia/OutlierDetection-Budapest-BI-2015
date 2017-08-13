source("R/Visualization/ColoredWorldMap.R")
source("R/Visualization/UnifiedVisualizationOfWealthAndHealthData.R")
source("R/Helper/multiplot.R")
source("R/OutlierDetection/detection_db.R")
library(ggplot2)
library(fields)
library(plyr)
library(dplyr)
library(animation)

nation.health.welth <-
  read.csv("data/nation_health_and_wealth/nation.wealth.and.health_full.csv")

PlotAFigure <- function(df){
  year <- unique(df$Year)
  df$Year <- NULL
  demo.data <- apply(X = df[, 2:3], MARGIN = 2, FUN =  function(col) {
    (col - min(col)) / (max(col) - min(col))
  })
  colnames(demo.data) <- c("x", "y")
  demo.data <- as.data.frame(demo.data)
  
  db.color <- ComputesDB(demo.data, delta = 0.06)
  
  p1 <- PlotTheScatterForNationWealthHealth(df, db.color, -1,
                                      name = "Neighbor ratio",
                                      colours = c("red", "orange", "darkgreen"),
                                      values = c(0, 0.1, 1),
                                      year = year)
  
  p2 <- PlotAMap(df, db.color, name = "Neighbor ratio",
           colours = c("red", "orange", "darkgreen"),
           values = c(0, 0.1, 1))
  layout <- matrix(c(1, 2), nrow = 1, byrow = TRUE)
  multiplot(plotlist = list(p1, p2), layout = layout)
}

nation.health.welth <- 
  nation.health.welth %>%
  mutate(Year = substring(Year, 2, 5)) %>%
  mutate(Year = as.numeric(as.character(Year))) %>%
  ## we need ~ 90 seconds -- 90 years -- for the presentation
  filter(Year >= 1913)

saveGIF({
  ddply(.data <- nation.health.welth, .variables = "Year",
        .fun = PlotAFigure)
  }, movie.name = "test_animation.gif",
  img.name = "test",
  ani.width = 1200,
  ani.height = 600)

