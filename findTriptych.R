# The find triptych function

find.triptych<-function(root,url){
  # The output is a a list of vectors with attributes of tryptichs  
  if(length(root)!=0){
    imgs.from.set<-getNodeSet(root,"//*[@id='mainContent']//p[descendant::img][count(img)>=3]/img")
    if(length(imgs.from.set)!=0){
      attributes<-xmlApply(imgs.from.set,xmlAttrs)
      url<-gsub("\\./","http://reed.edu/",url)
      names(url)<-"url"
      attributes<-lapply(attributes,append,value=url) %>% lapply(as.data.frame)
      #         names(img.node.set)<-"code"
      #         attributes<-lapply(attributes,append,value=img.node.set)
    df.two<-as.data.frame(c(1,2,3,4))  
    df<<-bind_rows(df,df.two)
    } 
  }
}
