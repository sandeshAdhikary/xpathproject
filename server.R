require(shiny)
require(dplyr)
require(ggplot2)
require(pbapply)
require("XML")
require("RCurl")
source('makeFilePathdf.R')
source('fileToUrl.R')
source('findTriptych.R')
source('binder.R')
require('tidyr')
source('getXmlAttrs.R')
library('shinyAce')

# server.R

function(input,output){
  
  # Making a dataframe out of the user entered file paths
  path.table.reactive<-reactive({
    # Reading the data
    file.paths.df<-read.table(input$user.file$datapath, quote="\"", comment.char="", stringsAsFactors=FALSE)
    # Converting file paths to urls and binding all rows
    file.urls.df<-file.paths.df[,1] %>% file.to.url(site="reed.edu",security="http") %>% make.file.path.df(security="http")
    # Adding a column of the urls
    file.urls.df<-file.urls.df %>% mutate(url = file.to.url(file.paths.df[,1],site="reed.edu",security="http"))
    })
  
  # This is the list of choices for the selectize Input text box: User picks directories to analyze
  choice.list.reactive<-reactive({
    path.table.reactive() %>% select(V2) %>% unique()
    })
  
  # The SelectizeInput UI. We use renderUI since both input and output of the selectizeInput are reactive
  output$selections<-renderUI({
    selection.list<-choice.list.reactive()
    selectizeInput("selected.directories","Pick something",choices=selection.list[,1],selected=c("about_reed"),multiple=TRUE)
  })
  
  # The table filtered accroding to the user's selected directories in SelectizeInput
  filtered.table.reactive<-reactive({
    path.table.reactive() %>% filter(V2 %in% input$selected.directories)
  })
  
  # Bar plot of the filtered table
  output$plot<-renderPlot({
    url.df.pivot<-filtered.table.reactive()%>% group_by(V2)%>% summarise(count=n())
    ggplot(url.df.pivot,aes(x=V2,y=count))+geom_bar(stat="identity")+xlab("Directories")+ylab("Websites")
  })
  
  # Text to be printed for total number of urls and estimated time
  output$number.of.urls<-renderText({
    paste0("You have a total of ",nrow(filtered.table.reactive())," files. This will take about ____ minutes")
  })
  
  # A vector of just the urls
  urls<-reactive({
    filtered.table.reactive() %>% select(url) %>% collect %>% .[["url"]] # Everything after collect is to get a vector. Bit clumsy here. 
  })
  
  # Parsing the urls when the user presses the Parse! button
  parsed.reactive<-eventReactive(input$parse.button,{
      lapply(urls(),htmlParse)
  })
  
   # Checking the output of the parsing (will be deleted later on)
   output$parsed.line<-renderPrint({
     all.parsed<-parsed.reactive()
     print(paste0("Parsed ",length(all.parsed)," files successfully."))
  })
  
    # Getting the user's code for the search
    coded.reactive<-reactive({
      input$send
      isolate({
        p<-parse(text=input$code)
      })
      p
    }) 
   
   
  # xpath searching
  xpath.search<-eventReactive(input$search.button,{
      urls.list<-urls()
      names(urls.list)<-"url"
       parsed<-parsed.reactive()
      user.code<-eval(coded.reactive())
        lists<-lapply(parsed,xpathSApply,path=user.code,fun=xmlAttrs)
        df<-get.xml.attrs(lists,urls.list)
        df
    })
  
  # output table from xpath searching
  output$xpath.table.raw<-renderPrint({
    xpath.search()
  })
  
  # final table from xpath searching
  output$xpath.table<-renderDataTable({
    xpath.search()
  })
  
}
