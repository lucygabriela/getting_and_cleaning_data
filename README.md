## COURSE PROJECT 

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

### FIVE STEPS TO DEVELOP THE PROJECT
This sections shows the R code to develop the five points in the  project

#### 1. Merge data sets - train and test
	trainBD <- cbind(subject=as.factor(subject_train[,1]), activity=as.factor(train_y[,1]), train_X)
	testBD  <- cbind(subject=as.factor(subject_test[,1]), activity=as.factor(test_y[,1]), test_X)
	trainTestBD <-rbind(trainBD,testBD)

We can see some features:

	> dim(trainTestBD)
	  10299   563

	> head(trainTestBD[,1:7])
	  subject activity        V1          V2         V3         V4         V5
	1       1        5 0.2885845 -0.02029417 -0.1329051 -0.9952786 -0.9831106
	2       1        5 0.2784188 -0.01641057 -0.1235202 -0.9982453 -0.9753002
	3       1        5 0.2796531 -0.01946716 -0.1134617 -0.9953796 -0.9671870
	4       1        5 0.2791739 -0.02620065 -0.1232826 -0.9960915 -0.9834027
	5       1        5 0.2766288 -0.01656965 -0.1153619 -0.9981386 -0.9808173
	6       1        5 0.2771988 -0.01009785 -0.1051373 -0.9973350 -0.9904868

#### 2. Measurements on the mean and standard deviation 
	features<-read.table("./UCI HAR Dataset/features.txt", 
	                        colClasses=c("integer","character")) 
	posMeanStd <- grep("mean[(]|std[(]", features$V2)
	ttMeanStdBD<-trainTestBD[,c(1,2,posMeanStd+2)]

ttMeanStdBD is a new data base where:

	> dim(ttMeanStdBD)
	[1] 10299    68

	> head(ttMeanStdBD[,1:7])
	  subject activity        V1          V2         V3         V4         V5
	1       1        5 0.2885845 -0.02029417 -0.1329051 -0.9952786 -0.9831106
	2       1        5 0.2784188 -0.01641057 -0.1235202 -0.9982453 -0.9753002
	3       1        5 0.2796531 -0.01946716 -0.1134617 -0.9953796 -0.9671870
	4       1        5 0.2791739 -0.02620065 -0.1232826 -0.9960915 -0.9834027
	5       1        5 0.2766288 -0.01656965 -0.1153619 -0.9981386 -0.9808173
	6       1        5 0.2771988 -0.01009785 -0.1051373 -0.9973350 -0.9904868

#### 3. Descriptive activity names are used to name the activities in the data set
	activity <- read.table("./UCI HAR Dataset/activity_labels.txt", 
	                        colClasses=c("integer","character")) 
	levels(ttMeanStdBD$activity)<-tolower(activity$V2)

Now, ttMeanStdBD data base is:

	> head(ttMeanStdBD[,1:6])
	  subject activity            V1            V2            V3          V4         
	1       1 standing     0.2885845   -0.02029417    -0.1329051   -0.9952786
	2       1 standing     0.2784188   -0.01641057    -0.1235202   -0.9982453
	3       1 standing     0.2796531   -0.01946716    -0.1134617   -0.9953796
	4       1 standing     0.2791739   -0.02620065    -0.1232826   -0.9960915
	5       1 standing     0.2766288   -0.01656965    -0.1153619   -0.9981386
	6       1 standing     0.2771988   -0.01009785    -0.1051373   -0.9973350

#### 4. Appropriate labels to the data set with descriptive variable names
	namesVar<-tolower(features$V2[posMeanStd])
	namesVar<-gsub("[(][)]","", namesVar)
	namesVar<-gsub("bodybody", "body", namesVar)
	
	namesVar<-gsub("-mean-x","MeanX", namesVar)
	namesVar<-gsub("-mean-y","MeanY", namesVar)
	namesVar<-gsub("-mean-z","MeanZ", namesVar)
	
	namesVar<-gsub("-std-x","StdX", namesVar)
	namesVar<-gsub("-std-y","StdY", namesVar)
	namesVar<-gsub("-std-z","StdZ", namesVar)
	
	namesVar<-gsub("-std","Std", namesVar)
	namesVar<-gsub("-mean","Mean", namesVar)
	
	colnames(ttMeanStdBD)<-c("subject", "activity", namesVar)

Mainly, symbols like - and () were eliminated from original variables names:

	> head(ttMeanStdBD[,1:6])
	  subject activity tbodyaccMeanX tbodyaccMeanY tbodyaccMeanZ tbodyaccStdX
	1       1 standing     0.2885845   -0.02029417    -0.1329051   -0.9952786
	2       1 standing     0.2784188   -0.01641057    -0.1235202   -0.9982453
	3       1 standing     0.2796531   -0.01946716    -0.1134617   -0.9953796
	4       1 standing     0.2791739   -0.02620065    -0.1232826   -0.9960915
	5       1 standing     0.2766288   -0.01656965    -0.1153619   -0.9981386
	6       1 standing     0.2771988   -0.01009785    -0.1051373   -0.9973350

#### 5. Average of each variable for each activity and each subject
	splitData<-split(ttMeanStdBD, f=list(ttMeanStdBD$subject,ttMeanStdBD$activity))
	meanData<-t(sapply(splitData, function(x) colMeans(x[,-c(1,2)]) ))
	
	cols1to2<-matrix(unlist(strsplit(row.names(meanData),"[.]")), nrow(meanData), byrow=T)
	colnames(cols1to2)<-colnames(ttMeanStdBD[,1:2])
	
	tidyData<-data.frame(cols1to2, meanData)
	rownames(tidyData)<-NULL
	
	if(!file.exists("data")) dir.create("data")
	write.csv(tidyData, "./data/tidyData.csv", row.names=FALSE)

tidyData looks like:

	> dim(tidyData)
	[1] 180  68
	
	> head(tidyData[,1:6])
	  subject activity tbodyaccMeanX tbodyaccMeanY tbodyaccMeanZ tbodyaccStdX
	1       1  walking     0.2773308   -0.01738382    -0.1111481   -0.2837403
	2       3  walking     0.2755675   -0.01717678    -0.1126749   -0.3603567
	3       5  walking     0.2778423   -0.01728503    -0.1077418   -0.2940985
	4       6  walking     0.2836589   -0.01689542    -0.1103032   -0.2965387
	5       7  walking     0.2755930   -0.01865367    -0.1109122   -0.3272432
	6       8  walking     0.2746863   -0.01866289    -0.1072521   -0.1736057

### COMPLEMENTARY R CODE
In This sections, auxiliary variables are deleted.

	rm(subject_train, train_y, train_X, subject_test, test_y, test_X, 
	   testBD, trainBD, features, posMeanStd, activity, namesVar, splitData,
	   meanData, cols1to2, fileUrl)



