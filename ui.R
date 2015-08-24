# ui.R

fluidPage(
  # Getting the file paths from the user
  fileInput("user.file", "Upload a file"),
  
  # The selectizeInput textbox for user to select directories
  uiOutput('selections'),
  
  # Plotting the bar graph of selected directories
  plotOutput("plot"),
  
  textOutput("number.of.urls"),
  
  actionButton("parse.button","Parse!"),
  
  verbatimTextOutput('parsed.line'),
  
  aceEditor("code", value="//img", mode = "r", theme = "xcode", height = "100px", fontSize = 10),
  
  actionButton("send", "Send code"),
  
  hr(),
  
  actionButton("search.button","Search!"),
  
  verbatimTextOutput('xpath.table.raw'),
  
  dataTableOutput('xpath.table')

)