source("init.R")

library(rpart)
library(rattle)
data = read_feather("/media/blob/data.feather")

tic()
fit = rpart(FL_TARGET ~ .,data)
toc()
#322.591 sec elapsed

saveRDS(fit,"/media/blob/arbol.rds")

fit = readRDS("/media/blob/arbol.rds")
fancyRpartPlot(fit)
