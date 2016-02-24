pollutantmean <- function(directory, pollutant, id = 1:332) {
  result <- c()
  for (fileId in id) {
    data <- read.csv(sprintf('%s/%0.3d.csv', directory, fileId))
    result = append(result, data[[pollutant]])
  }
  mean(result, na.rm=TRUE)
}
