# TODO:
#   Fix constraint

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


# Plot function as plane ---------------------
# Using this eliminates the dataframe!!!!!!
x <- seq(-2, 2, by = 0.1)
y <- seq(-5, 5, by = 0.1)


# f(x,y) = 8x^2 - 2y
f_xy <- function(x, y) {
  k <- 8*x^2 - 2*y
  #k <- x^2 + y^2 # known x^2 + y^2
  return(k)
}
z <- outer(x, y, f_xy) # Matrix of k's for all x,y pairs

# Plot f(x,y)
p <- rgl::persp3d(x, y, z, col = "blue", alpha = 0.7)
planes3d(a = 0, b = 0, c = 1, col = "green", alpha = 0.5)
clipplanes3d(a = 0, b = 0, c = 1) # Optional clip

# Plot x^2 + y^2
# Need to use polar coordinates: https://stackoverflow.com/a/51908543
r <- 1
phi <- seq(0, 2*pi, by = 10)
x2 <- r*cos(phi)
y2 <- r*sin(phi)
plot(x2, y2)

z2 <- outer(x2, y2, function(x,y) x^2 + y^2) # Doesn't include negatives!!

p
rgl::persp3d(x = x2, y = z2, z = z2, col = "yellow", alpha = 0.5, add = T)
clipplanes3d(a = 0, b = 0, c = 1) # Optional clip


# OLD CODE FOR SCATTER PLOT ----------------------

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

# plot scatter plot
p <- rgl::plot3d(coord$x, coord$y, coord$z, type = "s", radius = 0.5, col = "grey")
planes3d(a = 0, b = 0, c = 1, col = "blue", alpha = 0.5)

# Run with this option to clip the plane!!! Very cool!!!
p
clipplanes3d(a = 0, b = 0, c = 1)