source("init.R")
options("h2o.use.data.table" = TRUE)

library(h2o)

# Start H2O context
data = read_feather("/media/blob/data.feather")
target = "FL_TARGET"
attr = setdiff(colnames(data),target)

data.h2o = as.h2o(data,destination_frame = "dataset")

tic()
fit = h2o.deeplearning(attr,target,data.h2o,hidden = c(100,30,10),epochs = 5,model_id = "nnet")
toc()

fit

tic()
fit2 = h2o.deeplearning(attr,target,data.h2o,hidden = c(100,30,10),epochs = 20,model_id = "nnet2",checkpoint = "nnet")
toc()

fit2

h2o.saveModel(fit2,path = "/media/blob/")


