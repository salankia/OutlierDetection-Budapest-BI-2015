ComputesDepth <- function(demo.data) {
  require(depth)
  depth.col <- unlist(lapply(seq_along(demo.data$x), function(row.ind){
    return(depth(demo.data[row.ind, ], demo.data))
  }))
  depth.col <- depth.col * length(depth.col)
}
