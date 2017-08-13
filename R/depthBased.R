library(depth)

a <- data.frame(x = rnorm(n = 1000), 
                y = rnorm(n = 1000), 
                z = rnorm(n = 1000))
class <- rep("A", times = 1000)
k <- 10

a$depth <- NA
lapply(seq(from = 1, to = length(a[, 1])), function(row.item){
  print(row.item)
  a$depth[row.item] <<- depth(a[row.item, 1:3], a[1:3], approx= T)
})

a$depth <- a$depth * 1000
ipcp(a)
