source("R/Helper/default_ggplot2_theme_for_biforum2015.R")

PlotTheScatterForNationWealthHealth <-
  function(nation.health.welth, value,
           asc = 1, name, colours, values = c(0, 0.5, 1),
           year = ""){
    nation.health.welth$value <- value
    if(asc == 1) {
      nation.health.welth <- nation.health.welth[with(nation.health.welth, order(value)), ]  
    } else {
      nation.health.welth <- nation.health.welth[with(nation.health.welth, order(-value)), ]  
    }
    
    require(ggplot2)
    base <- ggplot(nation.health.welth)
    base + geom_point(aes(x = GDP, y = life.expectancy, col = value), size = 8) + 
      scale_color_gradientn(name = name, colours = colours, values = values) +
      xlab(paste("GDP per capita in", year)) +
      ylab("Life expectancy") +
      default.theme +
      xlim(c(0, 190000)) +
      ylim(c(0, 85))
  }