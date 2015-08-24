# get xmlAttrs  
get.xml.attrs<-function(lists,urls.list){
  df<-data.frame()
  lists.with.url<-lists
  for(i in 1:length(lists)){
    lists.with.url[[i]]<-sapply(lists[[i]],append,values=urls.list[i])
  }
  unlisted<-lists.with.url%>% unlist(recursive=FALSE) %>% lapply(t %>% as.data.frame)
  for(i in 1:length(unlisted)){
    df<-bind_rows(df,unlisted[[i]])
  }
  df
}