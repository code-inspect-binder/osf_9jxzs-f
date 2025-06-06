library(groundhog)
groundhog_date <- "2021-07-17"

groundhog.library("readxl", groundhog_date)
groundhog.library("sciplot", groundhog_date)
groundhog.library("tidyverse", groundhog_date)
groundhog.library("broom", groundhog_date)
groundhog.library("BSDA", groundhog_date)
groundhog.library("devtools", groundhog_date)

if (!require(MPA)) {
  devtools::install_github("UweSchnepf/MPA")
  library(MPA)
}
