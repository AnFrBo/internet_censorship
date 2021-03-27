'URLs ALL'

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
########################################### URL ENDINGS ############################################
####################################################################################################

data$urlend <- sub('.*\\.', '', data$url)

data$urlend <- gsub("/.*","",data$urlend)
data$urlend <- gsub("\\?.*","",data$urlend)
unique0 <- unique(data$urlend)
data$urlend <- str_replace_all(data$urlend, "[^a-zA-Z\\s]", " ")
data$urlend <- tolower(data$urlend)
data$urlend <- gsub("\\W*\\b\\w\\b\\W*", " ", data$urlend)
data$urlend <- str_replace_all(data$urlend,"[\\s]+", "")
unique1 <- unique(data$urlend)
data <- data[which(data$urlend != ""), ]

freq <- as.data.frame(sort(table(data$urlend), decreasing = T))
freq[1:30,]

png("urlending_freqplot1to50.png", width=1280,height=800)
barplot(freq[1:50,2])
dev.off()

png("urlending_freqplot1to30.png", width=1280,height=800)
barplot(freq[1:30,2])
dev.off()
