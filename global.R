
setwd("/Users/ghfmhf/git/NSS_project/TN_Land_Use/")

load("data/TN_LU_2.Rda")
# Has loaded six datasets
# TN_crop
# TN_farm
# TN_wood
# TN_pasture
# TN_home
# TN_pin

library(shiny)
library(dplyr)

droplist <- as.list(TN_pin$county)

