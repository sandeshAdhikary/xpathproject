# This function takes a file path and converts it into a url. 

file.to.url<-function(file.path,site.name,security){
  # Inputs: 'file.path' in the format "./directory/subdirectory/sitename.html"
  #         'site.name' in the format "mainsite.com"
  #         'security' either "https" or "http"    
  prefix<-paste0(security,"://",site.name,"/")
  gsub("\\./",prefix,file.path)
}


