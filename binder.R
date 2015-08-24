## Before searching for image attributes, we need to define the following binding function that will be used later. We don't want this function to be nested inside another one (to prevent reinitializing everytime), so we define it outside here. 
binder<-function(new.row,df){
  # This function binds a new row to our data frame "df"
  framed<-as.data.frame(new.row) # we convert the row into a data frame to use "bind_row" tool in dplyr which is faster than rbind
  if(nrow(framed)>1){framed<-as.data.frame(t(framed))}
  # The transposing "t" is due to the data format we end of getting from our later function
  assign("df",bind_rows(df,framed),envir=globalenv()) # We're using "assign" to append "framed" to the globally defined dataframe "df"
}     
