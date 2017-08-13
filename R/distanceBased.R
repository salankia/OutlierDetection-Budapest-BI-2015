library(fields)
library(igraph)

a <- data.frame(x = rnorm(n = 1000), 
                y = rnorm(n = 1000), 
                z = rnorm(n = 1000))
epsilon <- 1
d <- as.matrix(dist(a))
graph <- data.frame(X = numeric(0), Y = numeric(0))
lapply(seq(from = 1, to = length(a$x)), function(row.index){
  print(row.index)
  s <- setdiff(which(d[row.index, ] <= epsilon), row.index)
  if(length(s) > 0) {
    t <- data.frame(X = row.index, Y = s)
    graph <<- rbind(graph, t)
  }
  NULL
})

g <- graph.data.frame(graph, directed = T, vertices = row.names(a))
plot.igraph(g, layout = layout.mds,
            vertex.size = 1, vertex.label = NA, edge.arrow.size = 0.2, 
            edge.arrow.width = 0.2)
