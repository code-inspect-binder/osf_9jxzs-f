# Authors:          Uwe Schnepf (1)
# Affiliations:
# 1.                Institute of Biomaterials and biomolecular Systems
#                   Research Unit Biodiveristy and Scientific Diving
#                   University of Stuttgart
# Contact:          uwe.schnepf@bio.uni-stuttgart.de
#                   uwe.schnepf91@gmx.de
# Last modified:    23.02.2022
#----------------------------------------------------------------------------------------------------------------------------------#

# We clean the environment and close all graphics devices
rm(list=ls())
graphics.off()

# We load all packages and global settings for plots
source("lib/package_globalList.R")
source("etc/globalSettingsForPlots.R")

# 1. Data wrangling -------------------------------------------------------

# We load the data
finalData <- as_tibble(read.table("data/Data_RedSeaMP_FTIR_Final.txt"))
finalData

# 2. Exploratory data analysis --------------------------------------------

# We define additional settings for plots
MAR <- c(5, 4.25, 4, 2) + 0.1

# We add a slight jitter to transmittance for better visualization
graphData <- finalData %>%
  mutate(intensity = case_when(
    id == 1 ~ intensity + 0.15,  # beach inside second
    id == 2 ~ intensity - 0.1,   # beach outside first
    id == 3 ~ intensity + 0.55,  # beach inside first
    id == 4 ~ intensity - 0.275, # beach outside second
    id == 5 ~ intensity + 0.55,  # reference NA
    id == 6 ~ intensity - 0.15,  # wreck inside first
    id == 7 ~ intensity,         # wreck outside second
    id == 8 ~ intensity - 0.85,  # wreck inside third
    id == 9 ~ intensity - 0.55,  # wreck outside third
    id == 10 ~ intensity - 0.37, # wreck inside second
    id == 11 ~ intensity - 0.25  # wreck outside first
  ))


# 2.1 Inside - Fig. 2 -----------------------------------------------------

# We create separate plots for FTIR spectra of each MP and merge them
for (part in unique(graphData$id)) {
  partData <- graphData[graphData$id  == part & graphData$location == "Inside", ]
  
  if (part != 1)
    par(new = TRUE, ps = PS, mar = MAR)
  else
    par(ps = PS, mar = MAR)
  
  plot(partData$wavenumber, 
       partData$intensity,
       xlim = rev(c(500, 4000)),
       ylim = c(-0.3, 2),
       yaxt = "n",
       xlab = expression("Wavenumber [cm"^-1*"]"),
       ylab = "Transmittance [a. u.]",
       col = ifelse(partData$site == "Beach", col_beach, col_wreck),
       type = "l",
       lwd = LWD
       )
}

# We add LDPE reference data to the plot
par(new = TRUE, ps = PS, mar = MAR)
plot(graphData$wavenumber[graphData$site == "Reference"], 
     graphData$intensity[graphData$site == "Reference"],
     xlim = rev(c(500, 4000)),
     ylim = c(-0.3, 2),
     xlab = "",
     ylab = "",
     axes = FALSE,
     col = col_reference,
     type = "l",
     lwd = LWD,
     main = "Inside"
     )

# We insert a legend
legend("topleft",
       legend = c("Beach", "Wreck", "Reference"),
       fill = c(col_beach, col_wreck, col_reference),
       bty = "n"
       )


# 2.2 Outside - Fig. S1 online --------------------------------------------


# We create separate plots for FTIR spectra of each MP and merge them
for (part in unique(graphData$id)) {
  partData <- graphData[graphData$id  == part & graphData$location == "Outside", ]
  
  if (part != 1)
    par(new = TRUE, ps = PS, mar = MAR)
  else
    par(ps = PS, mar = MAR)
  
  plot(partData$wavenumber, 
       partData$intensity,
       xlim = rev(c(500, 4000)),
       ylim = c(-0.3, 2),
       yaxt = "n",
       xlab = expression("Wavenumber [cm"^-1*"]"),
       ylab = "Transmittance [a. u.]",
       col = ifelse(partData$site == "Beach", col_beach, col_wreck),
       type = "l",
       lwd = LWD,)
}

# We add LDPE reference data to the plot
par(new = TRUE, ps = PS, mar = MAR)
plot(graphData$wavenumber[graphData$site == "Reference"], 
     graphData$intensity[graphData$site == "Reference"],
     xlim = rev(c(500, 4000)),
     ylim = c(-0.3, 2),
     xlab = "",
     ylab = "",
     axes = FALSE,
     col = col_reference,
     type = "l",
     lwd = LWD,
     main = "Outside"
     )

# We insert a legend
legend("topleft", 
       legend = c("Beach", "Wreck", "Reference"),
       fill = c(col_beach, col_wreck, col_reference),
       bty = "n"
       )
       
# 3. Correlation ----------------------------------------------------------

corResults <- finalData %>%
  group_by(site, replicate, location) %>%
  summarise(pearsons_r = cor(intensity, finalData %>% filter(site == "Reference") %>% pull(intensity))) %>%
  filter(site != "Reference")

summary_ftir_cor <- corResults %>%
  group_by(site, location) %>%
  summarise(avg = mean(pearsons_r))
