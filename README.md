# Internet Censorship - The State of Censoring in the United Kingdom

Internet censorship is not a topic exclusive to countries with oppressive regimes. Over the last two decades, the government of the United Kingdom (UK) has introduced a number of policies to restrict access to certain types of content on the internet. The extent of censorship in the UK is illustrated by analysing data from internet censorship measurements, provided by OONI and the Blocked project. Furthermore, we outline the problem of legitimate websites being
falsely blocked as a result of the enforced policies. In spite of the amount of applied internet censoring rules in the UK, the applied blocking mechanisms can still be relatively easy circumvented. This raises the question whether the social costs of a restriction in personal freedom for all citizens can be justified by a hampered access to harmful and indecent content on the internet.

We scraped and analyzed the URLs of all blocked websites on the Sky network that were detected by the Blocked project measurements (s. detailed explanation in paper). Thereby we focused on the following categories: suicide, weapons, drugs, porn, anonymizers and dating. The goal was to not only find overblocked websites, which would be additional proof of overblocking but to find similarities among these websites in order to find out why they were being blocked and how overblocking could have been prevented. Therefore, we tried to access a website’s description, keywords, title, tags, heading, content and overall text. 

The analysis (text cleaning, clustering, wordclouds, filtering etc.) was conducted in R within RStudio. The code for this is uploaded to this repository. However, the web scraping code is not uploaded. Only the resulting data sets are available in this repository. The web scraper was written in Python within a Jupyter Notebook environment. The scraping was executed via Colab. The whole process is described in detail in the attached final paper.

## Organization

__Author:__ Anna Franziska Bothe, Jan Krol, Louis Kiesewetter <br>
__Institute:__ Humboldt University Berlin, Chair of Information Systems <br>
__Course__: IT-Security <br>
__Semester:__ WS 2019/20 <br>


## Content

```
.
├── data                  # folder contains the scrapped data sets per category
├── code                  # folder contains all R files, they can be execuded independently from each other
├── RData files           # folder contains RData files to skip text cleaning step
├── IT_Security_Paper.pdf # final paper describing project in details
├── README.md             # this readme file
├── requirements.txt      # contains all used libraries
├── setup.txt             # describes execution of pipeline in detail

```






