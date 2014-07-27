##########################################################
#        PROJECT - GETTING  AND CLEANING DATA
#########################################################

#----------------------------------------------------
#  CLEANING WORKSPACE
#-----------------------------------------------------
rm(list=ls())


#----------------------------------------------------
#  READING FILE FROM THE WEB
#-----------------------------------------------------
install.packages("downloader")
library(downloader)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(fileUrl, "./uci.zip", mode = "wb")


#----------------------------------------------------
#  UNZIP FILE UCI.ZIP
#-----------------------------------------------------
unzip("uci.zip")


#----------------------------------------------------
#  READING FILE USING read.table(...)
#-----------------------------------------------------

train_X<-read.table("./UCI HAR Dataset/train/X_train.txt")
train_y<-read.table("./UCI HAR Dataset/train/y_train.txt") 
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

test_X<-read.table("./UCI HAR Dataset/test/X_test.txt")
test_y<-read.table("./UCI HAR Dataset/test/y_test.txt")  # 1-6
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt") #2-24


#----------------------------------------------------
#  1. MERGE DATA SETS (TRAIN AND SET)
#-----------------------------------------------------
trainBD <- cbind(subject=as.factor(subject_train[,1]), activity=as.factor(train_y[,1]), train_X)
testBD  <- cbind(subject=as.factor(subject_test[,1]), activity=as.factor(test_y[,1]), test_X)
trainTestBD <-rbind(trainBD,testBD)


#----------------------------------------------------
# 2. MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION
#-----------------------------------------------------
features<-read.table("./UCI HAR Dataset/features.txt", 
                        colClasses=c("integer","character")) 
posMeanStd <- grep("mean[(]|std[(]", features$V2)
ttMeanStdBD<-trainTestBD[,c(1,2,posMeanStd+2)]


#----------------------------------------------------
# 3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES
#    IN THE DATA SET
#-----------------------------------------------------
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                        colClasses=c("integer","character")) 
levels(ttMeanStdBD$activity)<-tolower(activity$V2)


#----------------------------------------------------
# 4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE
#    VARIABLE NAMES
#-----------------------------------------------------
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


#----------------------------------------------------
# 5. AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND 
#    EACH SUBJECT
#-----------------------------------------------------
splitData<-split(ttMeanStdBD, f=list(ttMeanStdBD$subject,ttMeanStdBD$activity))
meanData<-t(sapply(splitData, function(x) colMeans(x[,-c(1,2)]) ))

cols1to2<-matrix(unlist(strsplit(row.names(meanData),"[.]")), nrow(meanData), byrow=T)
colnames(cols1to2)<-colnames(ttMeanStdBD[,1:2])

tidyData<-data.frame(cols1to2, meanData)
rownames(tidyData)<-NULL

if(!file.exists("data")) dir.create("data")
write.csv(tidyData, "./data/tidyData.csv", row.names=FALSE)


#----------------------------------------------------
#   DELETE AUXILIARY OBJECTS
#-----------------------------------------------------

rm(subject_train, train_y, train_X, subject_test, test_y, test_X, 
   testBD, trainBD, features, posMeanStd, activity, namesVar, splitData,
   meanData, cols1to2, fileUrl)

