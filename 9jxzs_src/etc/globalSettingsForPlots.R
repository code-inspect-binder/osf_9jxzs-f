
# Color -------------------------------------------------------------------

library(groundhog)
groundhog_date <- "2021-07-17"

groundhog.library("viridis", groundhog_date)

col_all <- cividis(n = 2, begin = 0.1, end = 0.75)
col_beach <- col_all[2]
col_wreck <- col_all[1]
col_reference <- cividis(n = 1, begin = 0.5)

# Text --------------------------------------------------------------------

PS <- 10 
  
# Symbols -----------------------------------------------------------------

LWD <- 1
PCH <- 19
SS <- 1.5
