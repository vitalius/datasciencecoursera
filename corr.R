corr <- function(directory, threshold = 0) {
  result <- numeric(length = 0)
  for (fileId in subset(complete(directory), nobs >= threshold & nobs != 0)$id) {
    data <- read.csv(sprintf('%s/%0.3d.csv', directory, fileId))
    result <- c(result, cor(data[complete.cases(data),]$sulfate,
                            data[complete.cases(data),]$nitrate))
  }
  result
}
