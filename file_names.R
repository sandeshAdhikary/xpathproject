## Builds a data frame consisting of all html files with subdirectories in the columns
require("pbapply")
require("dplyr")
source('~/Desktop/Sandesh/Image Search/binder.R') #getting the binder() function

#Getting the file paths
path.list <- read.table("~/Desktop/Sandesh/Image Search/files-all.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

#Splitting file paths into subdirectory names
path.list.split<-pbsapply(path.list,strsplit,split="/") #splitting the name

#building data frame
df<-data.frame()
sapply(path.list.split,binder)
View(df)
