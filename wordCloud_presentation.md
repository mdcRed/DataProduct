Word Cloud Used in Text Analysis
========================================================
author: My D. Coyne
date: Sat Jul 25 16:10:38 2015

Motivation
========================================================

Term Document Matrix (TDM) is often use for exploratory text analysis.  TDM is a matrix presents the frequency of words in a document.  

<span style="color:red">**Problem Statement**  TDM is not intuitive in spotting out the highest frequent term.  Is there a better presentation of the TDM than a tabular of numbers (for requency of words)?</span>

What is Word Cloud?  Why use it?
====

- **Word Cloud:** is a graphical representation of the TDM, in which the larger the word in the visual, the more common the word is in the document.  

- **Benefits:**
  - *Add clarity* The visual presentation can identify trends or patterns that may not easy to see in a tabular matrix
  
  - *Effective communicating tool*  Communicating the most salient points or themes in a reporting document that is easy to understand, yet impactful.

Approach
========================================================

- <span style="color:pink">Using R Text Mining, tm package</span> to perform the basic text mining steps; they are:
    - convert all words to lower cases
    - remove punctuation marks, numbers, English stop words (Ref. 1)
    - form a Term Document Matrix (TDM) of word frequency
- <span style="color:pink">Using R WordCloud package</span> to plot the TDM
- <span style="color:pink">Using R Shiny package</span> to implement the web application

Data Source used in this Application
====

-  <span style="color:pink">Public domain</span> of National Science Foundation (see Ref. 2) lists awarded grants.
- Extract and capture only abstracts for a handful of awards.  The abstracts are saved into files, served as corpus for text mining.  Each award abstract is in one file. 
- At run time, file name of each award abstracts is separated and serve as choices in a drop down list, from there users may select to view the word cloud respresent the text.
    
Application Structure
===
<span style="color:green">ui</span> *displays* of some simple UI widgets drop down list with choices to select; sliders to control the threshold for frequency of words and number of words in a select document, and a button to view the word cloud.  <span style="color:red">Tool tip, mouse over the heading of each UI widget,</span> is used to provide guide through the UI. 

<span style="color:green">server</span> *orchestrates* the calculation of Term Document Matrix (TDM), and plotting of the resulting word cloud

<span style="color:green">global</span> *analyzes* text to form the TDM (using R Text Mining package)

**Note** A limitation of RMarkdown is that it does not call global.R, [[reference found here]] (https://github.com/rstudio/rmarkdown/issues/211).  Alhough my application works,  I cannot embedded the application in RStudio Presenter as stated in requirement #4.  
 


server.R (code example)
========================================================

```r
library('shiny')
shinyApp(
  server = function(input, output, session) {
  # Define a reactive expression for the document term matrix
  terms <- reactive({
    # Change when the "update" button is pressed...
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$selection)
      })
    })
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(4,0.2),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(12, "Paired"))
  })
},
)
```

<!--html_preserve--><iframe src="app0c3f01266b99d630151e661912d4a7c7/?w=&amp;__subapp__=1" width="100%" height="400" class="shiny-frame"></iframe><!--/html_preserve-->

Result
=========

![my App](./images/1548001_wodcloud.png)


References
========================================================
1.  Ref.  1.  SMART Stop words. [[here]] (http://jmlr.csail.mit.edu/papers/volume5/lewis04a/a11-smart-stop-list/english.stop)

2. Ref. 2. National Science Founcation awards on public domain [[here]] (https://www.nsf.gov/awards/about.jsp).  Scroll down  and click on  [Recent Awards] (https://www.fastlane.nsf.gov/servlet/A6RecentWeeks)


![Thank You](images/thankyou.png)


