Word Predictor
========================================================
author: Vitaliy Pavlenko
date: December 2, 2018
autosize: true

Overview
========================================================
The goal of this app is to build and demonstrate a model for predicting next word in a string of text.

For training corpus a collection of tweets, news feeds and blogs in English language was provided by SwiftKey. An n-gram probabilistic language model is built with simplified Katz back-off algorithm to rank next-word candidates.

How to use the app
========================================================
Navigate to the [App](https://vitalius.shinyapps.io/csfinal/) url and type text into 'Input phrase' field, then Click *Predict*.

The app will render the most likely next word to follow.

How was it built?
========================================================
Text data was sampled for random 5000 documents (lines of text) and compiled into a single training corpus.

A number of text transforms were performed to clean up and normalize the data.

1. All text was converted to lower case
2. Non-text characters were removed
3. Non-English characters were removed
4. All punctuation was removed

Using Weka tokenizer, training corpus was further tokenezed and sorted by frequency of occurrence into 3 n-gram lookup dictionaries (4-gram, 3-gram and 2-gram).

Prediction logic
========================================================
With dictionaries in place, server portion of the app attempts to lookup the last few words of the input phrase in n-gram dictionaries and return next most frequently occurring word. 

When 3 words are given, app looks for most frequent phrase that begins with those 3 words in 4-gram dictionary, to return last word as the most probable candidate. If no matches are found in 4-gram dictionary, search 3-gram dictionary with the last 2 words, etc until next word is found.

If at the end, all n-gram dictionary lookups resulted in no matches, then return word 'the' because it's the most frequent word in English language, and probably the best next candidate.
