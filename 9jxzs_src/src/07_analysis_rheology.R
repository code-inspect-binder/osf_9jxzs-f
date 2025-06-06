# Authors:          Uwe Schnepf (1)
# Affiliations:
# 1.                Institute of Biomaterials and biomolecular Systems
#                   Research Unit Biodiveristy and Scientific Diving
#                   University of Stuttgart
# Contact:          uwe.schnepf@bio.uni-stuttgart.de
#                   uwe.schnepf91@gmx.de
# Last modified:    23.03.2022
#----------------------------------------------------------------------------------------------------------------------------------#

# We clean the environment and close all graphics devices
rm(list=ls())
graphics.off()

# We load all packages and global settings for plots
source("etc/globalSettingsForPlots.R")
source("lib/package_globalList.R")

# 1. Data wrangling -------------------------------------------------------

# We load the data
finalData <- as_tibble(read.table("data/Data_ReadSeaMP_Rheology_Final.txt"))


# 2. Graphs - Fig. 7 ------------------------------------------------------



# We create a separate data set for plotting
graphData <- finalData %>%
  rename(`G'` = G., `G"` = G..1, `n*` = n.)

# We change margins so the plot fits the size of the device
MAR <- c(5, 4.5, 4, 2) + 0.1

layout(matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2, byrow = TRUE))

# 2.1 Complex viscosity ---------------------------------------------------

# We draw a log-log diagram of complex viscosity
par(ps = PS, mar = MAR)
plot(graphData$Freq[graphData$site == "wreck"], 
     graphData$`n*`[graphData$site == "wreck"], 
     log = "yx",
     axes = FALSE,
     xlab = "",
     ylab = "",
     type = "b",
     pch = PCH,
     col = col_wreck,
     xlim = c(0.01, 100),
     ylim = c(1e+01, 1e+06))

par(new = TRUE, ps = PS, mar = MAR)
plot(graphData$Freq[graphData$site == "beach"], 
  graphData$`n*`[graphData$site == "beach"], 
  type = "b",
  log = "yx",
  xlab = expression("Frequency [rad s"^-1 *"]"),
  ylab = expression(paste("|", eta ,"*| [Pa s]")),
  pch = PCH,
  col = col_beach,
  axes = FALSE,
  xlim = c(0.01, 100),
  ylim = c(1e+01, 1e+06))

axis(1, at = c(0, 0.1, 1, 10, 100, 1000), labels = c(0, 0.1, 1, 10, 100, 100))
axis(2, at = c(0, 1, 10, 100, 1000, 10000, 100000, 1000000))

text(x = 0.01, y = 1000000, label = expression(bold("a")))

legend("topright", legend = c("Beach", "Wreck"), fill = c(col_beach, col_wreck), bty = "n")

# 2.2 Moduli --------------------------------------------------------------

# We draw a log-log diagram of storage modulus
plot(graphData$Freq[graphData$site == "wreck"], 
     graphData$`G'`[graphData$site == "wreck"], 
     log = "yx",
     axes = FALSE,
     xlab = "",
     ylab = "",
     type = "b",
     pch = PCH,
     col = col_wreck,
     xlim = c(0.01, 100),
     ylim = c(1e+01, 1e+06))

par(new = TRUE, ps = PS, mar = MAR)
plot(graphData$Freq[graphData$site == "beach"], 
     graphData$`G'`[graphData$site == "beach"], 
     axes = FALSE,
     xlab = "",
     ylab = "",
     type = "b",
     log = "yx",
     pch = PCH,
     col = col_beach,
     xlim = c(0.01, 100),
     ylim = c(1e+01, 1e+06))

axis(1, at = c(0, 0.1, 1, 10, 100, 1000), labels = c(0, 0.1, 1, 10, 100, 100))
axis(2, at = c(0, 1, 10, 100, 1000, 10000, 100000, 1000000))

text(x = 0.01, y = 1000000, label = expression(bold("b")))

# We draw a log-log diagram of loss modulus
par(new = TRUE, ps = PS, mar = MAR)
plot(graphData$Freq[graphData$site == "wreck"], 
     graphData$`G"`[graphData$site == "wreck"], 
     log = "yx",
     axes = FALSE,
     xlab = "",
     ylab = "",
     type = "b",
     pch = PCH - 2,
     col = col_wreck,
     xlim = c(0.01, 100),
     ylim = c(1e+01, 1e+06))

par(new = TRUE, ps = PS, mar = MAR)
plot(graphData$Freq[graphData$site == "beach"], 
     graphData$`G"`[graphData$site == "beach"], 
     type = "b",
     log = "yx",
     xlab = expression("Frequency [rad s"^-1 *"]"),
     ylab = "G' G'' [Pa]",
     pch = PCH - 2,
     col = col_beach,
     axes = FALSE,
     xlim = c(0.01, 100),
     ylim = c(1e+01, 1e+06))

axis(1, at = c(0, 0.1, 1, 10, 100, 1000), labels = c(0, 0.1, 1, 10, 100, 100))
axis(2, at = c(0, 1, 10, 100, 1000, 10000, 100000, 1000000))

legend("bottomright", 
       legend = c("G'", "G''"), 
       pch = c(PCH, PCH - 2),
       inset = c(0, 1), 
       xpd = TRUE, 
       bty = "n", 
       horiz = TRUE)

# 2.3 Loss tangents -------------------------------------------------------

# We draw a diagram of loss tangents with logarithmic scale on the x-axis
plot(graphData$Freq[graphData$site == "wreck"], 
     graphData$tan[graphData$site == "wreck"], 
     log = "x",
     axes = FALSE,
     xlab = "",
     ylab = "",
     type = "b",
     pch = PCH,
     col = col_wreck,
     xlim = c(0.01, 100),
     ylim = c(0, 15))

par(new = TRUE, ps = PS, mar = MAR)
plot(graphData$Freq[graphData$site == "beach"], 
     graphData$tan[graphData$site == "beach"], 
     type = "b",
     log = "x",
     xlab = expression("Frequency [rad s"^-1 *"]"),
     ylab = expression(paste("tan ", delta)),
     pch = PCH,
     col = col_beach,
     axes = FALSE,
     xlim = c(0.01, 100),
     ylim = c(0, 15))

axis(1, at = c(0, 0.1, 1, 10, 100, 1000), labels = c(0, 0.1, 1, 10, 100, 100))
axis(2, at = c(-1 , 0, 3, 6, 9, 12, 15))

text(x = 0.01, y = 15, label = expression(bold("c")))
abline(1, 0)
