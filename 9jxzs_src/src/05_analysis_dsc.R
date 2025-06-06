# Authors:          Uwe Schnepf (1)
# Affiliations:
# 1.                Institute of Biomaterials and biomolecular Systems
#                   Research Unit Biodiveristy and Scientific Diving
#                   University of Stuttgart
# Contact:          uwe.schnepf@bio.uni-stuttgart.de
#                   uwe.schnepf91@gmx.de
# Last modified:    25.03.2022
#----------------------------------------------------------------------------------------------------------------------------------#

# We clean the environment and close all graphics devices
rm(list=ls())
graphics.off()

# We load all packages and global settings for plots
source("lib/package_globalList.R")
source("etc/globalSettingsForPlots.R")

# 1. Data wrangling -------------------------------------------------------

# We load the data
dscData <- as_tibble(read.table("data/Data_RedSeaMP_DSC_Thermal_Final.txt"))
dscData
  
crysData <- as_tibble(read.table("data/Data_RedSeaMP_DSC_crystallinity_Final.txt"))
crysData

# 2. Graphs - Fig. 5 ------------------------------------------------------

# We create a panel which is later filled with the individual plots
layout(matrix(c(1, 2), nrow = 1, ncol = 2, byrow = TRUE))

# We calculate mean values for each time point for better visibility
graphData <- dscData %>%
  group_by(site, stadium, temp) %>%
  summarise(heatcap = mean(heatcap))

# We create the graph for thermal curves
for (part in unique(graphData$site)) {
  partData <- graphData[graphData$site== part, ]
  
  stad1 <- partData[partData$stadium == "first_heating", ] 
  stad2 <- partData[partData$stadium == "cooling", ] 
  stad3 <- partData[partData$stadium == "second_heating", ] 
  
  col_selector <- ifelse(part == "Beach", col_beach, col_wreck)
  XLIM <- c(-50, 170)
  YLIM <- c(-2, 2)
  
  if (part == "Beach")
    par(ps = PS, mar = c(5, 5, 4, 1) + 0.1)
  else if (part == "Wreck")
    par(new = TRUE, mar = c(5, 5, 4, 1) + 0.1)
  
  plot(stad1$temp, stad1$heatcap,
       xlab = "Temperature [°C]",
       ylab = expression("Heat capacity [mW mg"^-1*"]"),
       ylim = YLIM,
       xlim = XLIM,
       type = "l",
       lty = 1,
       lwd = LWD,
       col = col_selector)
  
  par(new = TRUE, ps = PS)
  plot(stad2$temp, stad2$heatcap,
       axes = FALSE,
       xlab = "",
       ylab = "",
       ylim = YLIM,
       xlim = XLIM,
       type = "l",
       lty = 2,
       lwd = LWD,
       col = col_selector)
  
  par(new = TRUE, ps = PS)
  plot(stad3$temp, stad3$heatcap,
       axes = FALSE,
       xlab = "",
       ylab = "",
       ylim = YLIM,
       xlim = XLIM,
       type = "l",
       lty = 3,
       lwd = LWD,
       col = col_selector)
}

# We add a legend to differentiate the different sample sites
legend("topright",
       legend = c("Beach", "Wreck"), 
       fill = c(col_beach, col_wreck),
       bty = "n")

# We add a legend to differentiate between heating and cooling runs
legend("bottomright", 
      legend = c("1st heating", "Cooling run", "2nd heating"), 
      lty = c(1, 2, 3),
      inset = c(0, 1), 
      xpd = TRUE, 
      bty = "n", 
      horiz = TRUE)

# We add a note to show where exogenic reactions are plotted
arrows(x0 = -50, y0 = 1, x1 = -50, y1 = 1.5, col = "black", code = 2, lwd = 1, length = 0.1)
text(-33.5, 1.225, "exo")

# We add panel label
text(x = -50, y = 2, label = expression(bold("a")))

# We create the graph for crystallinity
par(ps = PS)
bargraph.CI(crysData$site,
            crysData$crystallinity,
            xlab = "Sample site",
            ylab = "crystallinity [%]",
            col = c(col_beach, col_wreck),
            ylim = c(40, 50))

# We add panel label
text(x = 0.25, y = 49.625, label = expression(bold("b")))

# 3. NHST -----------------------------------------------------------------

# We perform a two-tailed t-test for crystallinty
# We did not formally check test assumptions, as Welch´s t test was applied to correct for
# violation of variance homogeneity, and the t test is robust against violations of normality
# when sample size is as high as in our case.
tidy(t.test(crysData$crystallinity ~ crysData$site))
