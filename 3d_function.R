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
library(car)
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
  mutate(z = 8*x^2 - 2*y)

# plot
car::scatter3d(coord$x, coord$y, coord$z, surface = F)

# Test different package ---------------------------
# https://stackoverflow.com/questions/13550501/adding-a-plane-to-a-scatterplot3d
library(scatterplot3d)
# NOT INTERACTIVE!!!
# But allows for gradient of coordinate

# f(x,y) = 8x^2 - 2y
scatterplot3d::scatterplot3d(coord$x, coord$y, coord$z, highlight.3d = T)

# Add plane along z-axis
scatterplot3d::scatterplot3d(c(coord$x, coord$x), c(coord$y, coord$y), c(coord$z, rep(1, nrow(coord))),
                             highlight.3d = T, pch = 20)
