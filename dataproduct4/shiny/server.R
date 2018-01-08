library(shiny)

shinyServer(function(input, output) {
   
  output$drawPlot <- renderPlot({
    
    # generate plot from input from ui.R
    pdata = pdata = data.frame(r=as.matrix(presidents), t=time(presidents))
    ydata = pdata[which(pdata$t>=(input$year) & pdata$t<(input$year+1)),]
    
    x = c(1,2,3,4)
    plot(x, ydata$r, xlab="Quater", ylab="Rating", 
         main=paste("Year", input$year, sep=" "),
         xlim=c(1,4), ylim=c(0,100), xaxt="n", col="blue")
    axis(1, at = seq(1, 4, by = 1), las=2)
    abline(lm(ydata$r ~ x), col="blue")
    points(x, c(input$q1,input$q2,input$q3,input$q4), pch=20, col="red")
    legend(1, 95, legend=c("Dataset", "Current Input"),
           col=c("blue", "red"), lty=1:1, cex=0.8)
  })
  
})
