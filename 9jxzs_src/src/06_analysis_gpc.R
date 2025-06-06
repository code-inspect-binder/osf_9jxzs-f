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
source("lib/function_errorbars.R")

# 1. Data wrangling -------------------------------------------------------

# We load the data
rawData <- read.table("data/Data_RedSeaMP_GPC_Raw.txt")

# We delete beach subsample due to methodological issues (pellets not solveable)
procData <- rawData %>%
  filter(site != "beach")

# We create final data
finalData <- procData
finalData

# 2. Calculations  --------------------------------------------

# We calculate summary statistics of our own study
Summary_GPC_DescriptiveStatistics_OwnStudy <- finalData %>%
  group_by(site) %>%
  summarise(M_Mw = mean(Mw),
            SD_Mw = sd(Mw),
            SE_Mw = se(Mw),
            M_Mn = mean(Mn),
            SD_Mn = sd(Mn),
            SE_Mn = se(Mn),
            N = n()
          )

# We extract data from the SI of ter Halle et al. (2017)
Summary_GPC_DescriptiveStatistics_terHalle <- tibble(
  site = "Reference",
  M_Mw = 140.0,
  SD_Mw = 80.3,
  SE_Mw = 80.3/sqrt(6),
  M_Mn = 23.0,
  SD_Mn = 9.2,
  SE_Mn = 9.2/sqrt(6),
  N = 6
  )

# We combine the results of the two studies
Summary_GPC_DescriptiveStatistics <- bind_rows(
  Summary_GPC_DescriptiveStatistics_OwnStudy, Summary_GPC_DescriptiveStatistics_terHalle)

Summary_GPC_DescriptiveStatistics

# 3. Graphs - Fig. 6 ------------------------------------------------------

graphData <- Summary_GPC_DescriptiveStatistics

# We create a matrix for the panel
MARGINS <- c(4, 6, 4, 4)
layout(matrix(c(1, 2), 
              nrow = 1, 
              ncol = 2,
              byrow = TRUE))

# We load the settings for the plot
par(mar = MARGINS, ps = PS)

# We fill the panel with Mn data
Mn <- graphData$M_Mn
names(Mn) <- graphData$site

Mn_plot <- barplot(height = Mn,
                   col = c(col_wreck, col_reference),
                   xlab = "Sample site",
                   ylab = expression('M'[n]*' [kg mol'^-1*']'),
                   ylim = c(0, 200)
                  )

errorbars(x = Mn_plot, y = Mn, error = graphData$SE_Mn)
text(x = 0.25, y = 195, label = expression(bold("a")))

# We fill the panel with Mw data
Mw <- graphData$M_Mw
names(Mw) <- graphData$site

Mw_plot <- barplot(height = Mw,
                   col = c(col_wreck, col_reference),
                   xlab = "Sample site",
                   ylab =  expression('M'[w]*' [kg mol'^-1*']'),
                   ylim = c(0, 200)
                  )

errorbars(x = Mw_plot, y = Mw, error = graphData$SE_Mw)
text(x = 0.25, y = 195, label = expression(bold("b")))

# 4. NHST -----------------------------------------------------------------

# We convert predictors to class factor
nhstData <- Summary_GPC_DescriptiveStatistics %>%
  mutate(site = as.factor(site))

# We perform a two-tailed t test for Mn
# We did not formally check test assumptions, as Welch´s t test was applied to correct for
# violation of variance homogeneity, and the t test is robust against violations of normality
# when sample size is as high as in our case.
Significance_GPC_tTest_Mn <- tsum.test(
  mean.x = nhstData$M_Mn[2], 
  s.x = nhstData$SD_Mn[2], 
  n.x = nhstData$N[2],
  mean.y = nhstData$M_Mn[1],
  s.y = nhstData$SD_Mn[1],
  n.y = nhstData$N[1],
  alternative = "two.sided", 
  var.equal = FALSE
)

Significance_GPC_tTest_Mn <- bind_cols(
  tidy(Significance_GPC_tTest_Mn), Significance_GPC_tTest_Mn$parameters) %>%
  rename(df = 9) %>%
  mutate(diff = estimate1 - estimate2)

Significance_GPC_tTest_Mn

# We perform a two-tailed t test for Mw
# We did not formally check test assumptions, as Welch´s t test was applied to correct for
# violation of variance homogeneity, and the t test is robust against violations of normality
# when sample size is as high as in our case.
Significance_GPC_tTest_Mw <- tsum.test(
          mean.x = nhstData$M_Mw[2], 
          s.x = nhstData$SD_Mw[2], 
          n.x = nhstData$N[2],
          mean.y = nhstData$M_Mw[1],
          s.y = nhstData$SD_Mw[1],
          n.y = nhstData$N[1],
          alternative = "two.sided", 
          var.equal = FALSE
)

Significance_GPC_tTest_Mw <- bind_cols(tidy(Significance_GPC_tTest_Mw), Significance_GPC_tTest_Mw$parameters) %>%
  rename(df = 9) %>%
  mutate(diff = estimate1 - estimate2)

Significance_GPC_tTest_Mw
