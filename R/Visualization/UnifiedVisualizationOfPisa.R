source("R/Helper/default_ggplot2_theme_for_biforum2015.R")

PlotTheScatterForPisaDataWithOutlier <-
  function(demo.data, value,
           asc = 1, name, colours, values = c(0, 0.5, 1)){
    demo.data$value <- value
    if(asc == 1) {
      demo.data <- demo.data[with(demo.data, order(value)), ]  
    } else {
      demo.data <- demo.data[with(demo.data, order(-value)), ]  
    }
    
    require(ggplot2)
    base <- ggplot(demo.data)
    base + geom_point(aes(x = x, y = y, col = value), size = 8) + 
      scale_color_gradientn(name = name, colours = colours, values = values) +
      xlab("MATH") + ylab("READING") +
      xlim(c(350, 650)) + ylim(c(350, 650)) +
      default.theme
  }