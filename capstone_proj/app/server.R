library(shiny)

source("model.R")

shinyServer(function(input, output) {
  output$nextword <- renderText({ result <- as.character(predict(as.character(input$text))) })
})