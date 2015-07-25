library("shiny")



fluidPage(
  # Application title
  titlePanel("Word Cloud used in Text Analysis"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      ## select an award id from NSF to see the word cloud of the abtract
      tags$div(title="Choose an abstract of an award, which is labeled by it award id",
              selectInput("selection", "Choose a National Science Foundation (NSF) Award Id:",
                  choices = docs)
      ),
      
      tags$div(title="Choose the mininum frequency. Lower the frequency results in most often used in the document",
                sliderInput("freq",
                            "Minimum Frequency:",
                            min = 1,  max = 50, value = 15)
      ),
      tags$div(title="Maxinum number of words in the text document to ingest when calculate the frequency.",
                sliderInput("max",
                            "Maximum Number of Words:",
                            min = 1,  max = 300,  value = 100)
      ),
      tags$div(title="Press the button to view the word cloud",
                actionButton("update", "View WordCloud")
      ),
      hr()
    ),
    
    # Show Word Cloud
    
    mainPanel(
      plotOutput("plot")
    )
    
  )
)

