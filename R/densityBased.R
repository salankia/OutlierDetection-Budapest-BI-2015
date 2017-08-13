## visualization with MDS
library(DMwR)
library(FNN)
library(MASS)
library(iplots)
library(rJava)
library(ggplot2)

setwd("C:/Users//Urbi/Desktop/Agnes/GD/userPoster/OutlierVis/")
load("../OutlierVis/pisa/student2012.rda")
student2012 <- student2012[student2012$OECD == "OECD", ]
student2012 <- student2012[student2012$CNT == "Hungary", ]
numeric.variables <- which(unlist(lapply(seq_along(student2012), function(col.ind){
  is.numeric(student2012[, col.ind])})))
student2012 <- student2012[, numeric.variables]
important.columns <- c(120:124, 160:169)
student2012 <- student2012[, important.columns]
student2012 <- na.omit(student2012)
a <- student2012

class <- rep("A", times = length(a[, 1]))
k <- 10

l <- knn.cv(a,  class,  k = k, algorithm="cover_tree")
indices <- attr(l, "nn.index")
distances <-  attributes(l)[4][[1]]

DistanceMatrix <- matrix(data = Inf, nrow = length(a[, 1]), ncol = length(a[, 1]))
## building the distance matrix
lapply(seq_along(a[, 1]), function(row.index){
  nns <- indices[row.index, ] 
  for(i in seq(1, k)) {
    DistanceMatrix[row.index, nns[i]] <<- distances[row.index, i]
    DistanceMatrix[nns[i], row.index] <<- distances[row.index, i]
  }
  print(row.index)
})

DistanceMatrix[is.infinite(DistanceMatrix)] <- 10000
#fit <- sammon(DistanceMatrix, k = 2)
fit <- cmdscale(DistanceMatrix, k = 2)
#fit <- isoMDS(DistanceMatrix, k = 2, y = cmdscale(DistanceMatrix))
print(indices[20, ])

a$plotx <- fit[, 1]
a$ploty <- fit[, 2]

a$lofactor <- lofactor(data = a[, 1:3], k = k)
a <- a[with(a, order(lofactor)), ]
#a$lofactor[a$lofactor < 1.5] <- "<1.5"
png("pisa.png", width = 800, height = 800)
base <- ggplot(a) 
base + geom_point(aes(x = plotx, y = ploty, col = lofactor, alpha =lofactor),
                  size = 5) +
  scale_color_gradient(name = "LOF", low = "darkgreen", high = "red") +
  theme_bw() + 
  ylab("") + xlab("") + theme(text = element_text(face = "bold", size = 30),
                              legend.position = "bottom") +
  scale_alpha_continuous(name = "LOF")
dev.off()

ggsave("pisa.lof.svg")
