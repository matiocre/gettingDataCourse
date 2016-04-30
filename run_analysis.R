### 
library(dplyr); library(tidyr)
###

linkToFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(linkToFile, "dataSet.zip")
# Sys.time() #---> "2016-04-28 15:52:48 ART" ### date and time when the file was download 

unzip("dataSet.zip") # Unzipping the file

features_code <- tbl_df(read.table("UCI\ HAR\ Dataset/features.txt")) # getting the features names

# test
subject_test <- tbl_df(read.table("UCI\ HAR\ Dataset/test/subject_test.txt")) # getting the subjects index
data_test <- tbl_df(read.table("UCI\ HAR\ Dataset/test/X_test.txt")) # getting the data
activity_test <- tbl_df(read.table("UCI\ HAR\ Dataset/test/y_test.txt")) # getting the activities index

names(data_test) <- features_code[[2]] # assigning names to the variables (columns names)

testTidy <- data_test[,grep("mean[^F]|std", names(data_test),value=T)] # performing the selection of the variables
testTidy$subject <- subject_test[[1]] # matching the subjects index 
testTidy$activity_code <- activity_test[[1]] # matching the activities index
testTidy <- gather(testTidy, sensor, value, -subject, -activity_code) # tidying the data
testTidy$dataSet <- "test" #labelling the origin of the data
#
# train
subject_train <- tbl_df(read.table("UCI\ HAR\ Dataset/train/subject_train.txt"))
data_train <- tbl_df(read.table("UCI\ HAR\ Dataset/train/X_train.txt"))
activity_train <- tbl_df(read.table("UCI\ HAR\ Dataset/train/y_train.txt"))

names(data_train) <- features_code[[2]]

trainTidy <- data_train[,grep("mean[^F]|std", names(data_train),value=T)]
trainTidy$subject <- subject_train[[1]] 
trainTidy$activity_code <- activity_train[[1]]
trainTidy <- gather(trainTidy, sensor, value, -subject, -activity_code)
trainTidy$dataSet <- "train"
#
# Getting labels for the data
activity_labels <- read.table(("UCI\ HAR\ Dataset/activity_labels.txt")) # getting the activity labels
names(activity_labels) <- c("activity_code", "activity") # making it easy to read

# Merging the data
dataSet <- bind_rows(testTidy, trainTidy) # merging the "test" and "train" data sets
dataSet <- inner_join(dataSet, activity_labels) # matching the activity labels with data
write.table(dataSet, "tidyDataSet.txt", row.names = F) # optional: write the results to a file

# average values
(average_value <- dataSet %>% group_by(subject, activity, sensor) %>% summarise(average_value=mean(value))) 
write.table(average_value, "average_value.txt", row.names = F) # optional: write the results to a file



