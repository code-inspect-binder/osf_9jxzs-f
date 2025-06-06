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

# We load raw data
finalData <- as_tibble(read.table("data/Data_RedSeaMP_Mass_Final.txt"))
finalData

# 2. Exploratory data analysis ---------------------------------------------------------------

# We draw a boxplot to decide whether to use mean or median as baseline
boxplot(finalData$mass[finalData$site == "Wreck"])
baseline <- mean(finalData$mass[finalData$site == "Wreck"])

# We caclulate summary statistics for mass
Summary_Mass_DescriptiveStatistics <- finalData %>%
        group_by(site) %>%
        summarise(M = mean(mass),
                  SD = sd(mass),
                  SEM = se(mass),
                  N = n(),
                  Change = mass - baseline,
                  PercChange = Change/baseline*100
                 )


# We calculate average percentage change of mass for MP from the beach
# Here, we assumed that mass of MP resin pellets from the wreck was comparable to pristine material,
# as this subsample wasn´t affected by long-term exposure to marine environmental conditions
Summary_Mass_DescriptiveStatistics %>% filter(site == "Beach") %>% pull(PercChange) %>% mean()


# 3. Graphs - Fig. S6 online ----------------------------------------------

# We draw a barplot with confidence intervals
par(ps = PS)
bargraph.CI(finalData$site,
            finalData$mass,
            xlab = "Sample site",
            ylab = "Mass [mg]",
            col = c(col_beach, col_wreck),
            ylim = c(20, 30))

# 4. NHST -----------------------------------------------------------------

# We perform a two-tailed t test
# We did not formally check test assumptions, as Welch´s t test was applied to correct for
# violation of variance homogeneity, and the t test is robust against violations of normality
# when sample size is as high as in our case.
nhstData <- finalData %>% mutate(site = as.factor(site))
tidy(t.test(nhstData$mass ~ nhstData$site, alternative = "two.sided"))
