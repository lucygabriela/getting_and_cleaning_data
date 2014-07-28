## PROJECT - GETTING  AND CLEANING DATA

---

### PRELIMINARY WORK
This section shows code lines to reading file from the web, unzip the file and create dataframes with the raw datas.

------

#### Deleting objects from Work Space
	rm(list=ls()) 

#### Reading file from the web 

	install.packages("downloader")
	library(downloader)

	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download(fileUrl, "./uci.zip", mode = "wb")
