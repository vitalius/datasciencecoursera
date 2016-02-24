complete <- function(directory, id = 1:332) {
  result <- data.frame(row.names = c('id', 'nobs'))
  for (fileId in id) {
    data <- read.csv(sprintf('%s/%0.3d.csv', directory, fileId))
    result <- rbind(result, data.frame('id'= fileId, 
                                       'nobs'=nrow(data[complete.cases(data),])))
  }
  result
}
