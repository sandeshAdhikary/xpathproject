make.file.path.df<-function(url,security){
  path.list.split<-url %>% gsub(paste0(security,"://"),"",.) %>% strsplit(split="/") %>% lapply(t)%>% pblapply(as.data.frame) #splitting the name
  bind_rows(path.list.split)
}

