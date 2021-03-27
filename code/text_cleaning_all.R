#set wd
setwd("")

#select the data set you want to executed the analysis for:

#porn (updated)
data <-  read.csv("sky_scraped_anon_1.csv", header = T, sep = ",")
for(i in 2:10){
  csv <- read.csv(paste("sky_scraped_anon_", i, ".csv", sep =""), header = T, sep = ",")
  data <- rbind(csv, data)
}

#drugs (updated)
data <- read.csv("1000 Blocked Drugs.csv", header = T, sep = ",")

#dating (updated)
data <-  read.csv("sky_scraped_dating_total.csv", header = T, sep = ",")
data <- data[,-1]

#weapons (updated)
data <- read.csv("sky_scraped_weapons_total.csv", header = T, sep = ",")
data <- data[,-1]

#suicide (updated)
data <- read.csv("sky_suicide_scraped.csv", header = T, sep = ",")

#anonymizers (updated)
data <- read.csv("sky_scraped_anonymizers_total.csv", header = T, sep = ",")
data <- data[,-1]

############

for(i in 1:ncol(data)){
  data[,i] <- ifelse(data[,i] == "Na" | data[,i] == "", NA, as.character(data[,i]))
  print(paste(colnames(data[i]), ":", sep = ""))
  print(table(is.na(data[,i])))
}

#######ANALYSIS OF DESCRIPTION

data_sub <- data[which(!is.na(data$description)), ]

for(i in 1:nrow(data_sub)){
    data_sub$lebf[i] <- str_length(data_sub$description[i]) #character with spaces
    data_sub$nowobf[i] <- sapply(strsplit(data_sub$description[i], " "), length) #no of words
}

print("Character before:") #median length of character with spaces
print(median(data_sub$lebf, na.rm = T))

print("Words before:")
print(median(data_sub$nowobf, na.rm = T))

#description
#lowercase
data_sub$description <- tolower(data_sub$description)
#replace character in order to keep german characters (especially important for weapons)
data_sub$description <- str_replace_all(data_sub$description, "ã¼", "ue")
data_sub$description <- str_replace_all(data_sub$description, "¿½", "ue")
data_sub$description <- str_replace_all(data_sub$description, "ß", "ss")
data_sub$description <- str_replace_all(data_sub$description, "ä", "ae")
data_sub$description <- str_replace_all(data_sub$description, "ü", "ue")
data_sub$description <- str_replace_all(data_sub$description, "ö", "oe")
#add space behind comma (especially relevant for keywords)
data_sub$description <- str_replace_all(data_sub$description, ",", ", ")
#remove everything that is not a number or letter
data_sub$description <- str_replace_all(data_sub$description, "[^a-zA-Z\\s]", " ")
#remove stopwords
stopwords_regex <- paste(stopwords('en'), collapse = '\\b|\\b')
stopwords_regex <- paste0('\\b', stopwords_regex, '\\b')
data_sub$description <- str_replace_all(data_sub$description, stopwords_regex, '')
#remove single letters
data_sub$description <- gsub("\\W*\\b\\w\\b\\W*", " ", data_sub$description)
#remove specific word ("also")
data_sub$description <- removeWords(data_sub$description, "also")
#shrink down to just one white space
data_sub$description <- str_replace_all(data_sub$description,"[\\s]+", " ")
#get rid of trailing "" if necessary
data_sub <- data_sub[which(data_sub$description != " "), ]
#remove whitespace from beginning and end of string
data_sub$description <- trimws(data_sub$description, which = c("both"))
#remove duplicated words within string
data_sub$description <- vapply(lapply(strsplit(data_sub$description, " "), unique), paste, character(1L), collapse = " ")

paste("Description total and unique words:")
length(unlist(strsplit(data_sub$description, " "))) #all words
length(unique(unlist(strsplit(data_sub$description, " ")))) #unique words

for(i in 1:nrow(data_sub)){
  data_sub$leaf[i] <- str_length(data_sub$description[i]) #character with spaces
  data_sub$nowoaf[i] <- sapply(strsplit(data_sub$description[i], " "), length) #no of words
}

print("Character after:") #median length of character with spaces
print(median(data_sub$leaf, na.rm = T))

print("Words after:")
print(median(data_sub$nowoaf, na.rm = T))

data_description <- data_sub

####ANALYSIS FOR TITLE

data_sub <- data[which(!is.na(data$title)), ]

for(i in 1:nrow(data_sub)){
  data_sub$lebf[i] <- str_length(data_sub$title[i]) #character with spaces
  data_sub$nowobf[i] <- sapply(strsplit(data_sub$title[i], " "), length) #no of words
}

print("Character before:") #median length of character with spaces
print(median(data_sub$lebf, na.rm = T))

print("Words before:")
print(median(data_sub$nowobf, na.rm = T))

#title
data_sub$title <- tolower(data_sub$title)
data_sub$title <- str_replace_all(data_sub$title, "ã¼", "ue")
data_sub$title <- str_replace_all(data_sub$title, "¿½", "ue")
data_sub$title <- str_replace_all(data_sub$title, "ß", "ss")
data_sub$title <- str_replace_all(data_sub$title, "ä", "ae")
data_sub$title <- str_replace_all(data_sub$title, "ü", "ue")
data_sub$title <- str_replace_all(data_sub$title, "ö", "oe")
data_sub$title <- str_replace_all(data_sub$title, ",", ", ")
data_sub$title <- str_replace_all(data_sub$title, "[^a-zA-Z\\s]", " ")
stopwords_regex <- paste(stopwords('en'), collapse = '\\b|\\b')
stopwords_regex <- paste0('\\b', stopwords_regex, '\\b')
data_sub$title <- str_replace_all(data_sub$title, stopwords_regex, '')
data_sub$title <- gsub("\\W*\\b\\w\\b\\W*", " ", data_sub$title)
data_sub$title <- removeWords(data_sub$title, "also")
data_sub$title <- str_replace_all(data_sub$title,"[\\s]+", " ")
data_sub <- data_sub[which(data_sub$title != " "), ]
data_sub$title <- trimws(data_sub$title, which = c("both"))
data_sub$title <- vapply(lapply(strsplit(data_sub$title, " "), unique), paste, character(1L), collapse = " ")

paste("Title total and unique words:")
length(unlist(strsplit(data_sub$title, " "))) #all words
length(unique(unlist(strsplit(data_sub$title, " ")))) #unique words

for(i in 1:nrow(data_sub)){
  data_sub$leaf[i] <- str_length(data_sub$title[i]) #character with spaces
  data_sub$nowoaf[i] <- sapply(strsplit(data_sub$title[i], " "), length) #no of words
}

print("Character after:") #median length of character with spaces
print(median(data_sub$leaf, na.rm = T))

print("Words after:")
print(median(data_sub$nowoaf, na.rm = T))

data_title <- data_sub

####ANALYSIS FOR KEYWORDS

data_sub <- data[which(!is.na(data$keywords)), ]

for(i in 1:nrow(data_sub)){
  data_sub$lebf[i] <- str_length(data_sub$keywords[i]) #character with spaces
  data_sub$nowobf[i] <- sapply(strsplit(data_sub$keywords[i], " "), length) #no of words
}

print("Character before:") #median length of character with spaces
print(median(data_sub$lebf, na.rm = T))

print("Words before:")
print(median(data_sub$nowobf, na.rm = T))

#keywords
data_sub$keywords <- tolower(data_sub$keywords)
data_sub$keywords <- str_replace_all(data_sub$keywords, "ã¼", "ue")
data_sub$keywords <- str_replace_all(data_sub$keywords, "¿½", "ue")
data_sub$keywords <- str_replace_all(data_sub$keywords, "ß", "ss")
data_sub$keywords <- str_replace_all(data_sub$keywords, "ä", "ae")
data_sub$keywords <- str_replace_all(data_sub$keywords, "ü", "ue")
data_sub$keywords <- str_replace_all(data_sub$keywords, "ö", "oe")
data_sub$keywords <- str_replace_all(data_sub$keywords, ",", ", ")
data_sub$keywords <- str_replace_all(data_sub$keywords, "[^a-zA-Z\\s]", " ")
stopwords_regex <- paste(stopwords('en'), collapse = '\\b|\\b')
stopwords_regex <- paste0('\\b', stopwords_regex, '\\b')
data_sub$keywords <- str_replace_all(data_sub$keywords, stopwords_regex, '')
data_sub$keywords <- gsub("\\W*\\b\\w\\b\\W*", " ", data_sub$keywords)
data_sub$keywords <- removeWords(data_sub$keywords, "also")
data_sub$keywords <- str_replace_all(data_sub$keywords,"[\\s]+", " ")
data_sub <- data_sub[which(data_sub$keywords != " "), ]
data_sub$keywords <- trimws(data_sub$keywords, which = c("both"))
data_sub$keywords <- vapply(lapply(strsplit(data_sub$keywords, " "), unique), paste, character(1L), collapse = " ")

paste("keywords total and unique words:")
length(unlist(strsplit(data_sub$keywords, " "))) #all words
length(unique(unlist(strsplit(data_sub$keywords, " ")))) #unique words

for(i in 1:nrow(data_sub)){
  data_sub$leaf[i] <- str_length(data_sub$keywords[i]) #character with spaces
  data_sub$nowoaf[i] <- sapply(strsplit(data_sub$keywords[i], " "), length) #no of words
}

print("Character after:") #median length of character with spaces
print(median(data_sub$leaf, na.rm = T))

print("Words after:")
print(median(data_sub$nowoaf, na.rm = T))

data_keywords <- data_sub

rm(i, stopwords_regex, data_sub)

#save output as RData (see x_forfiltering.RData)

