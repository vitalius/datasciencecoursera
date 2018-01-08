library(shiny)

shinyServer(function(input, output) {
   
  output$mpgPlot <- renderPlot({
    
    # generate plot from input from ui.R
    data = subset(mtcars, cyl==input$cyl)
    plot(mpg ~ disp, data = data)
  })
  
})
