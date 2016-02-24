corr <- function(directory, threshold = 0) {
  result <- numeric(length = 0)
  for (fileId in subset(complete(directory), nobs>=threshold)$id) {
    data <- read.csv(sprintf('%s/%0.3d.csv', directory, fileId))
    data_complete <- data[complete.cases(data),]
    result <- c(result, cor(data_complete$sulfate,data_complete$nitrate))
  }
  result
}
