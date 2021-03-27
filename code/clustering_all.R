'CLUSTER ANALYSIS'

library(stringr)
library(tm)
library(stringdist)
library(wordcloud)
library(fpc)

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
########################################### Clustering #############################################
####################################################################################################

#information about text distance methods: https://amunategui.github.io/stringdist/

#identify target variable and select only unique values
sub <- data_description$description
sub <- unique(sub)

#Leventshein distance (lv)
uniquetexts <- unique(as.character(sub))
distance <- stringdistmatrix(uniquetexts,uniquetexts,method = "dl")
hc <- hclust(as.dist(distance), method = "ward.D")
plot(hc)
rect.hclust(hc,k=5)
#plot(rev(hc$height^2)[1:25], type="b")

cluster.stats(d = distance, clustering = hc.segment) 
hc.segment <- cutree(hc, k=5)
str(hc.segment)
table(hc.segment)

sub_clust <- cbind(sub, hc.segment)
sub_clust <- as.data.frame(sub_clust)

clust1 <- sub_clust[which(sub_clust$hc.segment == 1), ]
clust2 <- sub_clust[which(sub_clust$hc.segment == 2), ]
clust3 <- sub_clust[which(sub_clust$hc.segment == 3), ]
clust_others <- sub_clust[which(sub_clust$hc.segment == 4 | 
                                  sub_clust$hc.segment == 5 | 
                                  sub_clust$hc.segment == 6), ]


'Visualisation'
#in forms of wordclouds
#save in following folder: 
#setwd("//Users/Bisa/Documents/Studium/Masterstudium/3. Semester/IT Security/Wordclouds")

#wordcloud cleaned data set w/o clustering
wc_all <- Corpus(VectorSource(data_description$description))
dtm <- TermDocumentMatrix(wc_all)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 50)

png("wordfreq_porn1bis200.png", width=1280,height=800)
barplot(d[1:200,2])
dev.off()

png("wordcloud_clean_all.png", width=1280,height=800)
wordcloud(words = d$word, freq = d$freq, scale = c(8, 0.2), min.freq = 2,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
dev.off()

#wordcloud clustering with Levenshtein distance (cl 1-4 w/o others)

#cl1
wc_lv <- Corpus(VectorSource(clust1$sub))
dtm <- TermDocumentMatrix(wc_lv)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
png("wordcloud_cl1_lv.png", width=1280,height=800)
wordcloud(words = d$word, freq = d$freq, scale = c(8, 0.2), min.freq = 2,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
dev.off()

#cl2
wc_lv <- Corpus(VectorSource(clust2$sub))
dtm <- TermDocumentMatrix(wc_lv)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
png("wordcloud_cl2_lv.png", width=1280,height=800)
wordcloud(words = d$word, freq = d$freq, scale = c(8, 0.2), min.freq = 2,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
dev.off()

#cl3
wc_lv <- Corpus(VectorSource(clust3$sub))
dtm <- TermDocumentMatrix(wc_lv)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
png("wordcloud_cl3_lv.png", width=1280,height=800)
wordcloud(words = d$word, freq = d$freq, scale = c(8, 0.2), min.freq = 2,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
dev.off()
