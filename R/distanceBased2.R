library(ggbiplot)
library(robustX)

a <- data.frame(x = rnorm(n = 1000), 
                y = rnorm(n = 1000), 
                z = rnorm(n = 1000))

a.pca <- prcomp(a)
s <- mvBACON(a, maxsteps = 3)
a$subset <- s$subset


ggbiplot(a.pca, obs.scale = 0, var.scale = 1,
         groups = a$subset, ellipse = TRUE, circle = F)

