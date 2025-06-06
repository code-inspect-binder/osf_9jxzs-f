# Authors:          Uwe Schnepf (1)
# Affiliations:
# 1.                Institute of Biomaterials and biomolecular Systems
#                   Research Unit Biodiveristy and Scientific Diving
#                   University of Stuttgart
# Contact:          uwe.schnepf@bio.uni-stuttgart.de
#                   uwe.schnepf91@gmx.de
# Last modified:    25.02.2022
#----------------------------------------------------------------------------------------------------------------------------------#

# We clean the environment and close all graphics devices
rm(list=ls())
graphics.off()

# We load all packages and global settings for plots
source("etc/globalSettingsForPlots.R")
source("lib/package_globalList.R")

# 1. Data wrangling -------------------------------------------------------

# We load the data
finalData <- as_tibble(read.table("data/Data_RedSeaMP_PSDShape_Final.txt"))
finalData

# 2. Summary statistics - Table S2 online ---------------------------------

# We calculate summary statistics for particle size and the three shape descriptors
Summary_PSDShape_DescriptiveStats <- finalData %>%
  group_by(site) %>%
  summarise(diam_m = mean(diam),
            diam_s = sd(diam),
            D50_diam = median(diam),
            IQR_diam = IQR(diam),
            D10_diam = quantile(diam, 0.1),
            D90_diam = quantile(diam, 0.9),
            D90_D10_diam = quantile(diam, 0.9)/quantile(diam, 0.1),
            Width = calc_width(diam),
            f1_m = mean(f1),
            f1_s = sd(f1),
            flatness_m = mean(flatness),
            flatness_s = sd(flatness),
            elongation_m = mean(elongation),
            elongation_s = sd(elongation),
            N = n(),
            No_MP = length(diam < 5)
  )


# 3. Graphs - Fig. S2 online ----------------------------------------------

# We create a panel which is later filled with the individual plots
layout(matrix(c(1, 2, 3, 4, 5, 6, 7, 8), nrow = 4, ncol = 2, byrow = TRUE))

# We fill the panel with individual plots and add text
# Size - settings
xRange_Size <- c(2, 5)
yRange_Size <-  c(0, 200) 
xTicks_Size <- seq(2, 5, by = 0.5)
yTicks_Size <- seq(0, 200, by = 50)
y2lab_Size <- expression("Normalized frequency [mm"^-1 *"]")
breaks_Size <- seq(0, 200, by = 0.2)
par(ps = PS)

# Size - beach
draw_dist(
  data = filter(finalData, site == "Beach"),
  sors = "diam",
  tick_Xaxis = xTicks_Size,
  tick_Yaxis = yTicks_Size,
  ylim = yRange_Size, 
  xlim = xRange_Size,
  breaks = breaks_Size,
  ylab2 = y2lab_Size,
  xlab = "Equivalent diameter [mm]",
  margins = c(4, 6, 4, 4),
  cex = 0.75, 
  col_normalized = col_beach
  )

text(x = 2, y = 1000, label = expression(bold("a")))
mtext(text = expression(paste(bold("Beach"))), side = 3, line = 1)

# Size - wreck
draw_dist(
  data = filter(finalData, site == "Wreck"),
  sors = "diam",
  tick_Xaxis = xTicks_Size,
  tick_Yaxis = yTicks_Size,
  ylim = yRange_Size, 
  xlim = xRange_Size,
  breaks = breaks_Size,
  ylab2 = y2lab_Size,
  xlab = "Equivalent diameter [mm]",
  margins = c(4, 6, 4, 4),
  cex = 0.75,
  col_normalized = col_wreck
  )

text(x = 2, y = 1000, label = expression(bold("b")))
mtext(text = expression(paste(bold("Wreck"))), side = 3, line = 1)

# Shape - settings
xRange_Shape <- c(0, 1)
yRange_Shape <-  c(0, 300) 
xTicks_Shape <- seq(0, 1, by = 0.2)
yTicks_Shape <- seq(0, 300, by = 100)
y2lab_Shape <- expression("Normalized frequency")
breaks_Shape <- seq(0, 1, by = 0.1)
par(ps = PS)

# f1 - beach
draw_dist(
  data = filter(finalData, site == "Beach"),
  sors = "f1",
  tick_Xaxis = xTicks_Shape,
  tick_Yaxis = yTicks_Shape,
  ylim = yRange_Shape, 
  xlim = xRange_Shape,
  breaks = breaks_Shape,
  ylab2 = y2lab_Shape,
  xlab = expression("Isoperimetric shape factor f"[1]),
  margins = c(4, 6, 4, 4),
  cex = 0.75,
  col_normalized = col_beach
  )

text(x = 0, y = 3000, label = expression(bold("c")))

# f1 - wreck
draw_dist(
  data = filter(finalData, site == "Wreck"),
  sors = "f1",
  tick_Xaxis = xTicks_Shape,
  tick_Yaxis = yTicks_Shape,
  ylim = yRange_Shape, 
  xlim = xRange_Shape,
  breaks = breaks_Shape,
  ylab2 = y2lab_Shape,
  xlab = expression("Isoperimetric shape factor f"[1]),
  margins = c(4, 6, 4, 4),
  cex = 0.75,
  col_normalized = col_wreck
  )

text(x = 0, y = 3000, label = expression(bold("d")))

# Flatness - beach
draw_dist(
  data = filter(finalData, site == "Beach"),
  sors = "flatness",
  tick_Xaxis = xTicks_Shape,
  tick_Yaxis = yTicks_Shape,
  ylim = yRange_Shape, 
  xlim = xRange_Shape,
  breaks = breaks_Shape,
  ylab2 = y2lab_Shape,
  xlab = "Flatness",
  margins = c(4, 6, 4, 4),
  cex = 0.75,
  col_normalized = col_beach
  )

text(x = 0, y = 3000, label = expression(bold("e")))

# Flatness - wreck
draw_dist(
  data = filter(finalData, site == "Wreck"),
  sors = "flatness",
  tick_Xaxis = xTicks_Shape,
  tick_Yaxis = yTicks_Shape,
  ylim = yRange_Shape, 
  xlim = xRange_Shape,
  breaks = breaks_Shape,
  ylab2 = y2lab_Shape,
  xlab = "Flatness",
  margins = c(4, 6, 4, 4),
  cex = 0.75,
  col_normalized = col_wreck
  )

text(x = 0, y = 3000, label = expression(bold("f")))

# Elongation - beach
draw_dist(
  data = filter(finalData, site == "Beach"),
  sors = "elongation",
  tick_Xaxis = xTicks_Shape,
  tick_Yaxis = yTicks_Shape,
  ylim = yRange_Shape, 
  xlim = xRange_Shape,
  breaks = breaks_Shape,
  ylab2 = y2lab_Shape,
  xlab = "Elongation",
  margins = c(4, 6, 4, 4),
  cex = 0.75,
  col_normalized = col_beach
  )

text(x = 0, y = 3000, label = expression(bold("g")))

# Elongation - wreck
draw_dist(
  data = filter(finalData, site == "Wreck"),
  sors = "elongation",
  tick_Xaxis = xTicks_Shape,
  tick_Yaxis = yTicks_Shape,
  ylim = yRange_Shape, 
  xlim = xRange_Shape,
  breaks = breaks_Shape,
  ylab2 = y2lab_Shape,
  xlab = "Elongation",
  margins = c(4, 6, 4, 4),
  cex = 0.75,
  col_normalized = col_wreck
  )

text(x = 0, y = 3000, label = expression(bold("h")))