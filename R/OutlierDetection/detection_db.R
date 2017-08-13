ComputesDB <- function(demo.data, delta, max.points = 10000) {
  require(fields)
  require(plyr)
  require(dplyr)
  s <- fields.rdist.near(demo.data, demo.data,
                         delta = delta, max.points = max.points)
  ind <- as.data.frame(s[[1]])
  db.col <- ddply(ind, .variables = "V1", summarize, db = length(V2))
  db.col$db <- db.col$db / length(db.col$db)
}