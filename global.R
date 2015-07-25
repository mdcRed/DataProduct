

library(tm)
library(wordcloud)
library(memoise)

## Directory of where documents are kept
fullpathDirectory <- "./data";
## Code to read the documents from the file system
source(file.path(paste0("./","getDocumentsFromFileSystem.R")));
## Getting only the file names from the repository of documents 
##     Use the file names as label for choices on the UI
labels <- getDocumentsFromFileSystem(fullpathDirectory);
docs <<- labels;

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(doc) {
  # Check to ensure that the label from the UI is one of the known
  ##   label/file name of a document in the system
  if (!(doc %in% docs))
    stop("Unknown document")
  
  ## The choice is getting from the user as user select
  choiceLabel <- sprintf("%s.txt", doc);
  ## Get the fullpath file name to get the content of the file
  fullpathFn <- paste0(fullpathDirectory,"/", choiceLabel);
  text <- readLines(fullpathFn, doc,
                    encoding="UTF-8")
  
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords, stopwords("SMART"), lazy=TRUE)
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})



