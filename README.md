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

	> head(trainTestBD[,1:7])
	  subject activity        V1          V2         V3         V4         V5
	1       1        5 0.2885845 -0.02029417 -0.1329051 -0.9952786 -0.9831106
	2       1        5 0.2784188 -0.01641057 -0.1235202 -0.9982453 -0.9753002
	3       1        5 0.2796531 -0.01946716 -0.1134617 -0.9953796 -0.9671870
	4       1        5 0.2791739 -0.02620065 -0.1232826 -0.9960915 -0.9834027
	5       1        5 0.2766288 -0.01656965 -0.1153619 -0.9981386 -0.9808173
	6       1        5 0.2771988 -0.01009785 -0.1051373 -0.9973350 -0.9904868



