getDocumentsFromFileSystem <- function(fullpathDirectory){
  listOfFn <- list.files(fullpathDirectory);
  labelDf <- strsplit(listOfFn,".txt");
  
  labelDf <- t(data.frame(labelDf));
  
  colnames(labelDf)<- "label"
  labelDf
}


