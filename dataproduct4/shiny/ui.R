library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("US President Approval Ratings"),
  
  # Sidebar with inputs
  sidebarLayout(
    sidebarPanel(

      tags$div(class="header", checked=NA,
               tags$p("View quarterly presidential approval ratings from the past (years 1945-1974) 
                      and compare to custom values. Default custom values are for president Trump 2017")),
            
      tags$div(class="header", checked=NA,
               tags$p("Select dataset year to compare")),
      
       sliderInput("year",
                   "Year:",
                   min = 1945,
                   max = 1974,
                   step = 1,
                   value = 1974,
                   sep = ""),
      
      tags$div(class="header", checked=NA,
               tags$p("Manual input")),
      
       numericInput("q1", "Qrt 1", 41.3, min = 1, max = 100),
       numericInput("q2", "Qrt 2", 38.8, min = 1, max = 100),
       numericInput("q3", "Qrt 3", 36.9, min = 1, max = 100),
       numericInput("q4", "Qrt 4", 32.0, min = 1, max = 100)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("drawPlot")
    )
  )
))
