corr <- function(directory, threshold = 0) {
  for (fileId in 1:332) {
    data <- read.csv(sprintf('%s/%0.3d.csv', directory, fileId))
    result <- rbind(result, data.frame('id'= fileId, 
                                       'nobs'=nrow(data[complete.cases(data),])))
  }
  result
}
