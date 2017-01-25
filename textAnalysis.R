tweet=read.csv("tweets.csv",stringsAsFactors = FALSE) #SO THAT TEXT IS READ PROPERLY
tweet$negative=as.factor(tweet$Avg<=-1)

#text mining package
library(tm)
library(SnowballC) #helps running tm library

#corpus- collection of documents, we need to convert our tweets into corpus to pre process it
corpus=Corpus(VectorSource(tweet$Tweet)) #Tweet- content of each tweet
#first tweet in the corpus
corpus[[1]]

#pre-processing the data 

#changing all the tweet test into lower case
corpus=tm_map(corpus,tolower)
corpus = tm_map(corpus, PlainTextDocument)corpus = tm_map(corpus, PlainTextDocument)
corpus=tm_map(corpus,removePunctuation)
#to check the stop words provided by tm
stopwords("english")[1:10]
#removing words if they are too obvious to occur in all sentences
corpus=tm_map(corpus,removeWords,c("apple",stopwords("english"))

corpus=tm_map(corpus,stemDocument)

