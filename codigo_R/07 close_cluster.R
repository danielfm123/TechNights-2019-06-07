h2o.shutdown(prompt = F)

plan(multiprocess,workers = length(ips))
process = list()
for(worker in workers){
  process[[worker]] = future({
    none = system(paste("az vm stop --name",worker,"--resource-group",resource_group))
  })
}
