library(reshape2)
library(ggplot2)

setwd("C:/Users/Agnes/Desktop/budapest_bi/")
rstats <- read.csv("Rstats_2015.csv")

rstats.reduced <- rstats[rstats$CRAN_all > 0, ]
ggplot(rstats.reduced) + geom_point(aes(x = github, y = R.bloggers)) +
  geom_text(aes(label = NAME, x = population, y = CRAN_all))
xlim(c(0, 250000000)) + ylim(c(0, 2000000)) +
ggplot(rstats.reduced) + geom_point(aes(x = NAME, y = CRAN_all))
