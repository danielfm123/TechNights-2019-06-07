source("init.R")
options("h2o.use.data.table" = TRUE)

library(h2o)
h2o.init()
data = read_feather("/media/blob/data.feather")
data.h2o = as.h2o(data,destination_frame = "dataset")

target = "FL_TARGET"
attr = setdiff(colnames(data),target)

tic()
fit = h2o.randomForest(attr,target,data.h2o,"random_h2o",ntrees = 10)
toc()

fit

tic()
fit = h2o.randomForest(attr,target,data.h2o,"random_h2o",ntrees = 20,checkpoint = "random_h2o")
toc()

fit

h2o.saveModel(fit,"/media/blob/")
h2o.shutdown(prompt = F)



