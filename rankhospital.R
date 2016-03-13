rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## dictionary for outcome to data frame index pointer
  d_index <- list();
  d_index[["heart attack"]] <- 11;
  d_index[["heart failure"]] <- 17;
  d_index[["pneumonia"]] <- 23;
  i <- d_index[[outcome]];
  
  if (!(state %in% unique(data[,7])))
    stop("invalid state");
  
  if (!(outcome %in% names(d_index)))
    stop("invalid outcome");

  ## subset to a specific state
  data <- data[data$State == state,]  
  
  ## convert rate to numeric value
  data[,i] <- suppressWarnings(as.numeric(data[,i]) )
  
  if (num == "best")
    num = 1
  else if (num == "worst")
    num = nrow(na.omit(data)[,c(2,i)])
  
  data[order(data[i], data[,2]),][num,2]
}