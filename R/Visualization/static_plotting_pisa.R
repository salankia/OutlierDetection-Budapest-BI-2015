library(ggplot2)
source("R/Visualization/default_ggplot2_theme_for_biforum2015.R")
source("R/Visualization/UnifiedVisualizationOfPisa.R")
source("R/OutlierDetection/detection_lof.R")
source("R/OutlierDetection/detection_db.R")
source("R/OutlierDetection/detection_depth.R")
source("R/OutlierDetection/detection_bacon.R")

  
math.and.reading.by.cnt <- read.csv("data/pisa/pisa.reduced.csv")
demo.data <- math.and.reading.by.cnt[, 2:3]
colnames(demo.data) <- c("x", "y")

############## Basic visualization #############################################
base <- ggplot(demo.data)
base + geom_point(aes(x = x, y = y), size = 8) + 
  xlab("MATH") + ylab("READING") +
  xlim(c(350, 650)) + ylim(c(350, 650)) +
  default.theme

################ LOF  ##########################################################
## Compute
lof.color <- ComputesLof(demo.data = demo.data)
## Visualize
PlotTheScatterForPisaDataWithOutlier(demo.data,
                                     value = lof.color,
                                     asc = 1,
                                     colours = c("darkgreen", "orange", "red"),
                                     name = "LOF")

## Print the most important results
(math.and.reading.by.cnt %>% filter(lof.color > 1.5))

########################### DB #################################################
## Compute
db.color <- ComputesDB(demo.data, delta = 0.5)
## Visualize
PlotTheScatterForPisaDataWithOutlier(demo.data,
                                     value = db.color,
                                     asc = -1,
                                     colours = c("red", "orange", "darkgreen"),
                                     name = "Neighbor ratio",
                                     values = c(0, 0.1, 1))

## Print the most important results
(math.and.reading.by.cnt %>% filter(db.color < 0.02))

############################# depth ############################################
## Compute
depth.color <- ComputesDepth(demo.data)
## Visualize
PlotTheScatterForPisaDataWithOutlier(demo.data,
                                     value = depth.color,
                                     asc = -1,
                                     colours = c("red", "orange", "darkgreen"),
                                     name = "Layer",
                                     values = c(0, 0.1, 1))

## Print the most important results
(math.and.reading.by.cnt %>% filter(depth.color < 2))

#################### BACON #####################################################
## Compute
bacon.color <- ComputesBacon(demo.data)
## Visualize
PlotTheScatterForPisaDataWithOutlier(demo.data,
                                     value = bacon.color,
                                     asc = 1,
                                     colours = c("darkgreen", "orange", "red"),
                                     name = "Robust distance",
                                     values = c(0, 0.1, 1))

## Print the most important results
(math.and.reading.by.cnt %>% filter(bacon.color > 10))
