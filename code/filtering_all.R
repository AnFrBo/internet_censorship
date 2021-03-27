#Filter (after cleaning)

#set wd
setwd("")

#select the data set you want to executed the analysis for:

'PORN'
#open porn_forfiltering.RData

#filter:

  #description: 4490
head(sort(table(unlist(strsplit(tolower(data_description$description), " "))), decreasing = T),50) #shows first twenty most used words
table(str_count(data_description$description,"\\gay")) #count how my column contain gay and how often, e.g. gggggay or gays counts as well
data_description$gay <- str_count(data_description$description,"\\gay")
      #findings:
        #many german websites (de = 290)
        #ae (459) results from transformation of ä and ä results form bad encoding?
        #information occurs 262 times
        #hope 240 times (how is it related to the context?)
        #sale occurs 232 - illegal activity?
          #if needed check with: data_description$sale <- str_count(data_description$description,"\\sale")
        #gay occurs 189 times
        #teen: 179 times // girls: 388
        #health and education does not occur at all
        #help once (not significant)

  #keywords: 2471
head(sort(table(unlist(strsplit(tolower(data_keywords$keywords), " "))), decreasing = T),50)
        #similar to description
        #in general: very related to woman and youth: girls (279), teen (195), pussy (121), babes (104), 
          #girl (100), young (94), teens (93), lesbian (86), models (86), women (86), tits (82) -- all in the top 50
  #title: 5772
head(sort(table(unlist(strsplit(tolower(data_title$title), " "))), decreasing = T),50)

'DRUGS'
#open drugs_forfiltering.RData

  #filter:

    #description: 481
head(sort(table(unlist(strsplit(tolower(data_description$description), " "))), decreasing = T),50) #shows fifth most frequently used words
table(str_count(data_description$description,"\\ quit")) 

        #findings:
          #information top 4 (50)
          #medical (30)
          #addition (16)
          #health (16)
          #help (15)
        #IDEA: count how often e.g. health, help and information occur and make a ranking; if all three
              #occur, high prob. that this is a website that should not be blocked
          #rehab occurs once, prevention not at all, quit twice (all not significant)

    #keywords: 253
head(sort(table(unlist(strsplit(tolower(data_keywords$keywords), " "))), decreasing = T),50)
        #keywords much more into drugs, 8 out of the 10 top words are names or forms of drugs (4 of 10 for descriptions)

    #title: 675
head(sort(table(unlist(strsplit(tolower(data_title$title), " "))), decreasing = T),50)
        #4 of 10 words are related to buying

'WEAPONS'
#open weapons_forfiltering.RData

  #filter:

    #description: 2024
head(sort(table(unlist(strsplit(tolower(data_description$description), " "))), decreasing = T),50)
table(str_count(data_description$description,coll("schuetz"))) #123*1+9*2+5*3+1*4 = 160

      #findings:
        #second most word is "und" --> German, de (110), der (93)...
        #schuetzenverein (65), ...schuetz... (160 times)
        #information top 4 (60)
        #for German URL see URL analysis

    #keywords: 1297
head(sort(table(unlist(strsplit(tolower(data_keywords$keywords), " "))), decreasing = T),50)
      #very focued on weapons out 11 of 12 of the top words are weapons or the usage of a weapon (hunting, shooting)
    
    #title: 3187
head(sort(table(unlist(strsplit(tolower(data_title$title), " "))), decreasing = T),50)
      #145 times Schuetzenverein (4th rank) 
      #105 times de (5th rank)
      #filter Schuetzenverein names? 

'SUICIDE'
#open weapons_forfiltering.RData

  #filter:

    #description: 47
head(sort(table(unlist(strsplit(tolower(data_description$description), " "))), decreasing = T),50) 

      #findings:
        #de (9) -- second rank, many German sites
        #information (7)
        #many related to (eating) disorders (anorexie, boulimie, eating, anorexia)
    
    #keywords: 21
head(sort(table(unlist(strsplit(tolower(data_keywords$keywords), " "))), decreasing = T),50)
      
    #title: 77
head(sort(table(unlist(strsplit(tolower(data_title$title), " "))), decreasing = T),50)
table(str_count(data_description$description,"\\information")) 
        #dignitiy (5) and information (5, 7 times if it is contained in another word) -- 5th rank --> why blocked?
        #prevention and health not existing, help (3)
  