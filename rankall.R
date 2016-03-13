rankall <- function(outcome, num = "best") {
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character");
  
  ## dictionary for outcome to data frame index pointer
  d_index <- list();
  d_index[["heart attack"]] <- 11;
  d_index[["heart failure"]] <- 17;
  d_index[["pneumonia"]] <- 23;
  i <- d_index[[outcome]];
    
  if (!(outcome %in% names(d_index)))
    stop("invalid outcome");
  
  states <- unique(data[,7]);
  
  ## convert rate to numeric value
  data[,i] <- suppressWarnings(as.numeric(data[,i]) );
  
  perState <- function(state) {
    d <- data[data$State == state,]
    
    if (num == "best")
      num = 1
    else if (num == "worst")
      num = nrow(na.omit(d)[,c(2,i)])
    
    d[order(d[i], d[,2]),][num,2]
  }
  
  result <- data.frame(states, 
                       unlist(lapply(states, function(x) perState(x))),
                       states)
  colnames(result) <- c("", "hospital", "state")
  result[order(result[,1]),]
}
