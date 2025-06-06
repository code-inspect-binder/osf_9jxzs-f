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
source("lib/package_globalList.R")
source("etc/globalSettingsForPlots.R")

# 1. Data wrangling -------------------------------------------------------

# We load the data
finalData <- as_tibble(read.table("data/Data_RedSeaMP_Color_Final.txt"))

# 2. Graphs - Fig. S3 online ----------------------------------------------

# We transpose data for plotting and reorder colors
graphData <- finalData %>%
  pivot_wider(names_from = site, values_from = proportion) %>%
  mutate(colour = factor(colour, c("White", "Beige", "Grey", "Yellow", "Red", "Black")),
         colour = as.numeric(colour))

# We draw a lollipop diagram to illustrate color distribution
par(ps = PS, mar = c(5, 5, 4, 2) + 0.1)
plot(x = graphData$colour, y = graphData$Beach, 
     type = "p", 
     col = col_beach, 
     ylim = c(0, 65),
     xlab = "Colour",
     ylab = "Proportion [%]", 
     pch = PCH,
     xaxt = "n", 
     cex = SS)

axis(1, at = seq(1, 6, by = 1), labels = c("White", "Beige", "Grey", "Yellow", "Red", "Black"))

par(ps = PS, new = TRUE, mar = c(5, 5, 4, 2) + 0.1)
plot(x = graphData$colour, 
     y = graphData$Wreck, 
     type = "p", 
     col = col_wreck, 
     ylim = c(0, 65),
     axes = FALSE, 
     xlab = "",
     ylab = "",
     pch = PCH,
     cex = SS)

arrows(x0 = graphData$colour, x1 = graphData$colour, y0 = graphData$Beach, y1 = graphData$Wreck, angle = 90, length = 0, )
legend("topright", legend = c("Beach", "Wreck"), fill = c(col_beach, col_wreck), bty = "n")
