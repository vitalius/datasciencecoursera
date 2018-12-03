library(shiny)
library(shinythemes)

shinyUI(
  navbarPage("Capstone",
    theme = shinytheme("flatly"),
    tabPanel("App",
      pageWithSidebar(
        headerPanel("Word prediction"),
        sidebarPanel( 
          textInput("text", label = h3("Input phrase"), value = ""),
          submitButton("Predict"),
          br()
        ),
        mainPanel(
          h4("Next word is ..."),
          verbatimTextOutput("nextword")
        )
      )
    ),
    tabPanel("About",
      h3("About the model"),
      br(),
      p("Twitter, blogs and news articles were used to build 3 word frequency dictionaries. Ngram tokenization was done with Weka library."),
      p("Basically, this model consists of 4-grams 3-grams and 2-grams lookup tables. With 3 words phrase, look up most frequent 4-gram that begins with the given phrase, and if only 2 words are specified look in 3-gram, for single word lookup most frequent bi-gram. If previous lookups resulted in no results, yield most frequent English word 'the'."),
      br()
    )
  )
)