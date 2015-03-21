## Objective
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## clear workspace environment.
rm(list=ls())

## -------------------------------------------
##                Global Objects
## -------------------------------------------
## construct variable list
features <- read.table("features.txt")
variableList <- features[grep("mean\\(\\)|std\\(\\)", features[,2]),]
## read activity
activity_labels <- read.table("activity_labels.txt")

## -------------------------------------------
##            Sort test dataset
## -------------------------------------------
## load test dataset.
test_X_test <- read.table("./test/X_test.txt")
## extract the mean and std of measurements by index the columns in the test_X_test data.frame
testData <- test_X_test[,variableList[,1]]

## load activity and volunteer of test dataset
test_y_test <- read.table("./test/y_test.txt")
test_subject_test <- read.table("./test/subject_test.txt")

## add volunteer and activity into testData as variables
testData <- cbind(test_y_test, testData)
testData <-cbind(test_subject_test, testData)

## remove temperary variables.
rm(list=c("test_y_test","test_subject_test","test_X_test"))

## -------------------------------------------
##            Sort train dataset
## -------------------------------------------
## load test dataset.
train_X_train <- read.table("./train/X_train.txt")
## extract the mean and std of measurements by index the columns in the train_X_train data.frame
trainData <- train_X_train[,variableList[,1]]

## load activity and volunteer of train dataset
train_y_train <- read.table("./train/y_train.txt")
train_subject_train <- read.table("./train/subject_train.txt")

## add volunteer and activity into trainData as variables
trainData <- cbind(train_y_train, trainData)
trainData <-cbind(train_subject_train, trainData)

## remove temperary variables.
rm(list=c("train_y_train","train_subject_train","train_X_train"))

## -------------------------------------------
##            Combine two datasets
## -------------------------------------------
combinedData <- rbind(testData, trainData)
rm(list=c("testData","trainData","features"))

## add proper variable names to data. use the variable names from variableList and volunteer 
## as the test subject and activity. 
vNames <- c("volunteer","activity", as.character(variableList[,2]))
vNames <- gsub("\\(\\)","", vNames)
colnames(combinedData) <- vNames

## replace activity index with proper names from activity_labels
combinedData[,"activity"] <- activity_labels[combinedData[,"activity"], 2]

## -------------------------------------------
## Calculate the means by volunteer and activity
## -------------------------------------------
data <- ddply(combinedData, .(volunteer, activity), colwise(mean))

## remove temperary variables.
rm(list=c("vNames", "activity_labels", "combinedData","variableList"))
write.table(data, file="output.txt", row.name=FALSE)

