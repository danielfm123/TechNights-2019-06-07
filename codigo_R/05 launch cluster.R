source("init.R")
library(ssh)
library(future)

workers = c("h2o-worker1","h2o-worker2","h2o-worker3","h2o-worker4")
ips = c("10.0.0.5","10.0.0.6","10.0.0.7","10.0.0.8")
writeLines(ips,"~/ips.txt")

plan(multiprocess,workers = length(ips))
process = list()
for(worker in workers){
  process[[worker]] = future({
    none = system(paste("az vm start --name",worker,"--resource-group",resource_group))
  })
}
lapply(process,value)

Sys.sleep(10)

process = list()
for(ip in c(ips)){
  process[[ip]] = future({
    session = ssh_connect(ip,passwd = "12345678Asdf")
    scp_upload(session,"~/ips.txt","~/ips.txt")
    scp_upload(session,"/usr/local/lib/R/site-library/h2o/java/h2o.jar","~/h2o.jar")
    none = ssh_exec_wait(session,"java -jar ~/h2o.jar -flatfile ips.txt -port 54321 -network 10.0.0.0/24")
    ssh_disconnect(session)
  })
}

Sys.sleep(3)

h2o.init(ips[1])
