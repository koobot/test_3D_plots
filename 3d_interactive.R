# Make 3D plot interactive
# Allows for clipping function along z-axis

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
z_lim <- c(-3, 3)
id <- rgl::persp3d(x, y, z, col = "blue", alpha = 0.7, zlim = z_lim)["clipplanes"]

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
  closed = -2,
  sides = 70
)
#wire3d(cyl_cons, col = "yellow", alpha = 0.7)
id2 <- rgl::plot3d(cyl_cons, col = "yellow", alpha = 0.7, add = TRUE, type = "wire")

# Label axes
#axes3d(edges = c("x", "y", "z"))


# Interactive plot ----------------
dvals <- c(3, -3)
widget <- rglwidget() %>%
  playwidget(
    # Clipper control on z-axis
    clipplaneControl(d = dvals, clipplaneids = id2),
    start = 0, stop = 1, step = 0.01,
    rate = 0.5)
if (interactive()) widget
options(saveopts)

###
rglwidget() %>%
  toggleWidget(ids = )