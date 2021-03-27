'FREQUENCIES (AFTER CLEANING)'

#set wd
setwd("")

#select the data set you want to executed the analysis for:

#porn
load("porn_forfiltering.RData")

#drugs
load("drugs_forfiltering.RData")

#dating
load("dating_forfiltering.RData")

#weapons
load("weapons_forfiltering.RData")

#suicide
load("suicide_forfiltering.RData")

#anonymizers
load("anonymizers_forfiltering.RData")


####################################################################################################
###################################### FREQUENCIES #################################################
####################################################################################################

'DESCRIPTION ANALYSIS'
wc_all <- Corpus(VectorSource(data_description$description))
dtm <- TermDocumentMatrix(wc_all)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 30)

'TITLE ANALYSIS'
wc_all <- Corpus(VectorSource(data_title$title))
dtm <- TermDocumentMatrix(wc_all)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 30)

'KEYWORDS ANALYSIS'
wc_all <- Corpus(VectorSource(data_keywords$keywords))
dtm <- TermDocumentMatrix(wc_all)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 30)

