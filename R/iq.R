library(ggplot2)

default.theme <- theme_bw() + theme(text = element_text(face = "bold", size = 20))
x <- data.frame(x = rnorm(n = 1000000, mean = 100, sd = 15))

ggplot(x) + geom_density(aes(x = x), binwidth = 2, size = 2) +
  default.theme + xlab("") + ylab("") +
  theme(axis.text.y = element_blank()) +
  theme(axis.ticks.y = element_blank()) + 
  scale_x_continuous(limits = c(20, 190), breaks = seq(20, 192, by = 10))

x <- data.frame(x = c(
  rnorm(n = 1000000, mean = 80, sd = 5),
  rnorm(n = 1000000, mean = 120, sd = 5)))

ggplot(x) + geom_density(aes(x = x), binwidth = 2, size = 2) +
  default.theme + xlab("") + ylab("") +
  theme(axis.text.y = element_blank()) +
  theme(axis.ticks.y = element_blank()) + 
  scale_x_continuous(limits = c(20, 190), breaks = seq(20, 192, by = 10))


set.seed(25)
x <- data.frame(y = c(runif(n = 10000, min = 10, max = 20)), 
                x = c(runif(n = 10000, min = 10, max = 20)))
base <- ggplot(x) + geom_point(aes(x = x, y = y),
                               col = c(rep("black", times = 9999), "red")) +
  default.theme + xlab("") + ylab("") +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) 
print(base)


plottingFunction <- function(){
  for (i in 1:10) plot(runif(10), ylim = 0:1)
}
library(animation)
saveGIF(plottingFunction, movie.name = "test_animation.gif",img.name = "test")

saveGIF({
  for (i in 1:10) {
  x <- data.frame(y = c(runif(n = 10000, min = 10, max = 20)), 
                  x = c(runif(n = 10000, min = 10, max = 20)))
  base <- ggplot(x) + geom_point(aes(x = x, y = y),
                                 col = c(rep("black", times = 9999), "red")) +
    default.theme + xlab("") + ylab("") +
    theme(axis.text = element_blank()) +
    theme(axis.ticks = element_blank()) 
  print(base)}
}, movie.name = "test_animation.gif", img.name = "test")
