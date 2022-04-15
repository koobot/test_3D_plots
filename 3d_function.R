# Adapted from https://r-graph-gallery.com/3d-surface-plot.html

# Plot 3D function
# Trying to understand lagrange multipliers
# https://tutorial.math.lamar.edu/classes/calciii/lagrangemultipliers.aspx
#----------------------------------------------------------------------
# Install manually due to issue with loading rgl ----------------------
tryCatch(
  {
    find.package("shiny")
  }, error = function(e){
    install.packages("shiny", type="binary")
  }
)

tryCatch(
  {
    find.package("manipulateWidget")
  }, error = function(e){
    install.packages("manipulateWidget")
  }
)

# Load libraries ----------------------------
library(rgl)
library(car)

# input
u <- c(-50:50)
v <- c(-50:50)

# f(x,y) = 8x^2 - 2y
f_xy <- function(x, y) {
  k <- 8*x^2 - 2*y
  #k <- x^2 + y^2 # known x^2 + y^2
  return(k)
}

# dataframe of coordinates
coord <- data.frame(x = c(), y = c(), z = c())

# f(x, y) = k
# Slow for 201x201 - should improve this to make faster
for (i in u) {
  for (j in v) {
    new_row <- data.frame(x = i, y = j, z = f_xy(i, j))
    # Add to dataframe
    coord <- rbind(coord, new_row)
  }
}

# plot
car::scatter3d(coord$x, coord$y, coord$z, surface = F)
