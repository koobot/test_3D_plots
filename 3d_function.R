# TODO:
#   Make adding rows to dataframe more efficient
#   Make colour gradient so easier to see change

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
library(tidyverse)

# input
u <- seq(-2, 2, by = 0.1)
v <- seq(-5, 5, by = 0.1)

# get idea of big inputs
rows <- length(u)*length(v)
if (rows > 10000) {message("Lots of rows (rows=", rows, ")")}

# f(x,y) = 8x^2 - 2y
f_xy <- function(x, y) {
  k <- 8*x^2 - 2*y
  #k <- x^2 + y^2 # known x^2 + y^2
  return(k)
}

# dataframe of coordinates
coord <- data.frame(expand.grid(u, v))
coord <- coord %>%
  rename(x = Var1, y = Var2) %>%
  mutate(z = f_xy(x, y))

# plot
rgl::plot3d(coord$x, coord$y, coord$z, type = "s", radius = 0.5)
planes3d(a = 0, b = 0, c = 1, col = "blue")