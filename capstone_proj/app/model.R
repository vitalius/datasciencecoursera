library("tm")

two <- readRDS('bigram.rds',.GlobalEnv)
three <- readRDS('trigram.rds',.GlobalEnv)
four <- readRDS('quadgram.rds',.GlobalEnv)


tokenize_input <- function(text) {
  # perform same text transforms as in training/parsing the corpus
  input <- Corpus(VectorSource(text))
  input <- tm_map(input, content_transformer(function(x, pattern) gsub(pattern, " ", x)), "\"|/|@|\\|")
  input <- tm_map(input, content_transformer(function(x, pattern) gsub(pattern, " ", x)), "[^[:graph:]]")
  input <- tm_map(input, content_transformer(tolower))
  input <- tm_map(input, removePunctuation)
  input <- tm_map(input, removeNumbers)
  input <- tm_map(input, PlainTextDocument)
  input <- tm_map(input, stripWhitespace)
  input.dataframe <-  data.frame(text = sapply(input, paste, collapse = " "), stringsAsFactors = FALSE)
  input_tokens <- unlist(strsplit(input.dataframe[1,1], "[ ]"))
  result <- tail(input_tokens, 3)
  result
}


gram_lookup <- function(tokz) {
  n = length(tokz)
  
  grepl_str <- paste(c("^", paste(tokz, collapse=' ')), collapse='')
  if (n > 2 && length(four[grepl(grepl_str, four$Word),1]) > 0) {
    return(head(four[grepl(grepl_str, four$Word),1], 1))
  }
  
  grepl_str <- paste(c("^", paste(tail(tokz,2), collapse=' ')), collapse='')
  if (n > 1 && length(three[grepl(grepl_str, three$Word),1]) > 0) {
    return(head(three[grepl(grepl_str, three$Word),1], 1))
  }
  
  grepl_str <- paste(c("^", paste(tail(tokz,1), collapse=' ')), collapse='')
  if (n > 0 && length(two[grepl(grepl_str, two$Word),1]) > 0) {
    return(head(two[grepl(grepl_str, two$Word),1],1))
  }
  
  # most frequent single word
  return("the")
}


predict <- function (input) {
  t <- tokenize_input(input)
  result <- gram_lookup(t)
  tail(strsplit(as.character(result),split=" ")[[1]],1)
}





