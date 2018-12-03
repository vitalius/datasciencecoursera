library(tm)
library(stringr)
library(R.utils)
library(wordcloud)
library(RWeka)
library(ggplot2)
library(readr)
library(stringi)
library(SnowballC)

## Directory
setwd("C:/Users/vitaliy/Desktop/capstone_final")
path <- getwd()

twitter <- readLines("../capstone/final/en_US/en_US.twitter.txt", encoding = "UTF-8", skipNul = TRUE)
blogs <- readLines("../capstone/final/en_US/en_US.blogs.txt", encoding = "UTF-8", skipNul = TRUE)

bin.news <- file("../capstone/final/en_US/en_US.news.txt", open="rb")
news <- readLines(bin.news, encoding="UTF-8")
close(bin.news)
rm(bin.news)


set.seed(140)
sampleTwitter <- twitter[sample(1:length(twitter),5000)]
sampleBlogs <- blogs[sample(1:length(blogs),5000)]
sampleNews <- news[sample(1:length(news),5000)]

## Combine data samples 
sampleData <- c(sampleTwitter,sampleBlogs,sampleNews)

## Save sample data and remove data not needed to free memory
writeLines(sampleData, "sampleData.txt")
rm(twitter,news,blogs,sampleTwitter,sampleNews,sampleBlogs)


library("tm")
sampleData <- readLines("sampleData.txt", encoding="UTF-8")
corpus <- Corpus(VectorSource(sampleData))

## Remove space, punctuation, numbers, whitespace, stopwords and change to lowercase
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
corpus <- tm_map(corpus, toSpace, "\"|/|@|\\|")
corpus <- tm_map(corpus, toSpace, "[^[:graph:]]")
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, PlainTextDocument)
#corpus <- tm_map(corpus, removeWords, stopwords("english"))


library("RWeka")
corpus.dataframe <-  data.frame(text = sapply(corpus, paste, collapse = " "), stringsAsFactors = FALSE)

buildDicts = function(data, n) {
  ngram <- data.frame(table(NGramTokenizer(corpus.dataframe, Weka_control(min = n, max = n))))
  sorted_ngrams = ngram[order(ngram$Freq, decreasing = T),]
  colnames(sorted_ngrams) = c("Word", "Count")
  sorted_ngrams
}

one = buildDicts(corpus.dataframe,1)
two = buildDicts(corpus.dataframe,2)
three = buildDicts(corpus.dataframe,3)
four = buildDicts(corpus.dataframe,4)

saveRDS(two, file='./app/bigram.rds')
saveRDS(three, file='./app/trigram.rds')
saveRDS(four, file='./app/quadgram.rds')




# prediction functions testing
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



















