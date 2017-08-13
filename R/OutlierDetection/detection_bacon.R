ComputesBacon <- function(demo.data) {
  require(robustX)
  fit <- covMcd(x = demo.data)
  bacon.col <- fit[[15]]
}