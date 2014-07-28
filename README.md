## PROJECT - GETTING  AND CLEANING DATA

---

### PRELIMINARY WORK
This section shows code lines to reading file from the web, unzip the file and create dataframes with the raw datas.

#### Deleting objects from Work Space
	rm(list=ls()) 

#### Reading file from the web 
	install.packages("downloader")
	library(downloader)

	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download(fileUrl, "./uci.zip", mode = "wb")

#### Unzip file uci.zip
	unzip("uci.zip")

#### Reading files into Work Space
	train_X<-read.table("./UCI HAR Dataset/train/X_train.txt")
	train_y<-read.table("./UCI HAR Dataset/train/y_train.txt") 
	subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
	
	test_X<-read.table("./UCI HAR Dataset/test/X_test.txt")
	test_y<-read.table("./UCI HAR Dataset/test/y_test.txt") 
	subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

---

### PRELIMINARY WORK
This sections shows the R code to develop the five points in the  project

#### 1. Merge data sets - train and test
	trainBD <- cbind(subject=as.factor(subject_train[,1]), activity=as.factor(train_y[,1]), train_X)
	testBD  <- cbind(subject=as.factor(subject_test[,1]), activity=as.factor(test_y[,1]), test_X)
	trainTestBD <-rbind(trainBD,testBD)

We can see some features:

	dim(trainTestBD)
	  10299   563


