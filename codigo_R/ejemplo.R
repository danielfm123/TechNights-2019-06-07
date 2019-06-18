options("h2o.use.data.table" = TRUE)
options(stringsAsFactors = FALSE)
options(java.parameters = "-Xmx4096m")
options(dplyr.width = Inf) 
Sys.setenv(TZ='GMT')

library(tidyverse)
library(tictoc)
library(data.table)
library(feather)

resource_group = "resource_group"