# get xmlvalues
get.xml.values<-function(lists,urls.list){
  lists.with.url<-mapply(append,lists,urls.list,SIMPLIFY=FALSE) %>% lapply(t %>% as.data.frame) %>% bind_rows()
  lists.with.url
}