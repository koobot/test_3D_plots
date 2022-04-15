# Make 3D plot interactive

# Load libraries ----------------------------
library(rgl)
library(tidyverse)

# Set up -------------
open3d()
saveopts <- options(rgl.useNULL = TRUE)

# Function ----------------
x <- seq(-2, 2, by = 0.1)
y <- seq(-5, 5, by = 0.1)

# f(x,y) = 8x^2 - 2y
f_xy <- function(x, y) {
  k <- 8*x^2 - 2*y
  return(k)
}
z <- outer(x, y, f_xy) # Matrix of k's for all x,y pairs

# Plot -------------------
id <- rgl::persp3d(x, y, z, col = "blue", alpha = 0.7, zlim = c(-3,3))["clipplanes"]

# Interactive plot ----------------
dvals <- c(3, -3)
widget <- rglwidget() %>%
  playwidget(
    # Clipper control on z-axis
    clipplaneControl(d = dvals, clipplaneids = id),
    start = 0, stop = 1, step = 0.01,
    rate = 0.5)
if (interactive()) widget
options(saveopts)