best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

  ## dictionary for outcome to data frame index pointer
  d_index <- list();
  d_index[["heart attack"]] <- 11;
  d_index[["heart failure"]] <- 17;
  d_index[["pneumonia"]] <- 23;
  
  if (!(state %in% unique(data[,7])))
    stop("invalid state");
  
  if (!(outcome %in% names(d_index)))
    stop("invalid outcome");
  
  ## subset to a specific state
  data <- data[data$State == state,]
  
  ## convert rate to numeric value
  data[,d_index[[outcome]]] <- suppressWarnings(
    as.numeric(data[,d_index[[outcome]]]) )
  
  ## filter best rate
  data[order(data[d_index[[outcome]]]),][1,2]
  ##data[ which(
  ##     data[,d_index[[outcome]]] == min(data[,d_index[[outcome]]], na.rm = TRUE) ), 2]
 
}