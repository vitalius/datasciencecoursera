#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Flue Efficiency vs Engine Displacement"),
  
  # Sidebar with a slider input for number of cyl 
  sidebarLayout(
    sidebarPanel(
       sliderInput("cyl",
                   "Number of cyl:",
                   min = 4,
                   max = 8,
                   step = 2,
                   value = 4)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("mpgPlot")
    )
  )
))
