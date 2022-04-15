# TODO:
#   Allow zoom
#   Make clip slider have meaningful numbers
#   Export as some sort of html

# Make 3D plot interactive
# Allows for clipping function along z-axis

# Load libraries ----------------------------
library(rgl)
library(tidyverse)

# Set up -------------
open3d()
saveopts <- options(rgl.useNULL = TRUE)

# Create plot objects ----------------
# Inputs x,y for f(x,y)
x <- seq(-5, 5, by = 0.1)
y <- seq(-5, 5, by = 0.1)

# f(x,y) = 8x^2 - 2y
f_xy <- function(x, y) {
  k <- 8*x^2 - 2*y
  return(k)
}
z <- outer(x, y, f_xy) # Matrix of k's for all x,y pairs [f(x,y) = k]

# Limit z-axis ------
z_lim <- c(-3, 10)

# Add constraint g(x,y) = x^2 + y^2 = 1
# c(start, end)
x2 <- c(0, 0)
y2 <- c(0, 0)
# Becomes:
#   start_x,  start_y,  start_z
#   end_x,    end_y,    end_z
cyl_cons <- cylinder3d(
  center = cbind(x2, y2, z_lim),
  radius = 1,
  sides = 20
)

# PLOT ---------------
id <- rgl::persp3d(x, y, z, col = "blue", alpha = 0.7, zlim = z_lim)
id2 <- rgl::plot3d(cyl_cons, col = "yellow", alpha = 0.7, add = TRUE, type = "shade")

# Label axes
#axes3d(edges = c("x", "y", "z"))

# Interactive plot ----------------
dvals <- c(3, -3)
rglwidget() %>%
  # Adds constraint
  toggleWidget(ids = id2, label = "Constraint") %>%
  # Control to clip along z-axis
  playwidget(
    clipplaneControl(d = dvals, clipplaneids = id["clipplanes"]),
    start = 0, stop = 1, step = 0.1, rate = 0.5
  )

# For future to look at
# widget <- rglwidget() %>%
#   playwidget(
#     # Clipper control on z-axis
#     clipplaneControl(d = dvals, clipplaneids = id),
#     start = 0, stop = 1, step = 0.01,
#     rate = 0.5)
# if (interactive()) widget
# options(saveopts)