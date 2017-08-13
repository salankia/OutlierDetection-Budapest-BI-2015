source("R/Helper/default_ggplot2_theme_for_biforum2015.R")

PlotAMap <- function(df, value, name, colours, values = c(0, 0.5, 1)) {
  require(ggplot2)
  require(maps)
  require(maptools)
  require(plyr)
  df$value <- value
  world<-map_data('world')
  colnames(df)[1] <- "region"
  world <- left_join(world, df)
  p <- ggplot(legend=FALSE) +
    geom_polygon( data = world, aes(x = long, y = lat,
                                    group = group, fill = value))
  p + scale_fill_gradientn(name = name, colours = colours, values = values) +
    default.theme + ylim(c(-60, 90))
}