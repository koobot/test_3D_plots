# Adapted from https://r-graph-gallery.com/3d-surface-plot.html

# Plot 3D function
# Trying to understand lagrange multipliers
# https://tutorial.math.lamar.edu/classes/calciii/lagrangemultipliers.aspx
#----------------------------------------------------------------------

library(plotly)

# input
u <- c(-100:100)
v <- c(-100:100)

# f(x,y) = 8x^2 - 2y
f_xy <- function(x, y) {
  k <- 8*x^2 - 2*y
  return(k)
}

# matrix of points
k <- matrix(nrow = length(u), ncol = length(v))

# f(x, y) = k
for (i in 1:length(u)) {
  for (j in 1:length(v)) {
    # Add to matrix
    k[i, j] <- f_xy(i, j)
  }
}

# plot
plot_ly(z = k, type = "surface")
