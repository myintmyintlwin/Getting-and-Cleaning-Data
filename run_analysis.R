##Here is R script called run_analysis.R that include the the following tasks. 
#1.	Merges the training and the test sets to create one data set.
#2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.	Uses descriptive activity names to name the activities in the data set
#4.	Appropriately labels the data set with descriptive variable names. 
#5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Getting the path for data source
path = "D:/MML/Coursera (Data Science)/3. Getting and Cleaning Data/Week 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset"
library(dplyr)
### checking the data files in the UCI HAR Dataset
datafiles = list.files(path, recursive=TRUE)
print(datafiles)

### Reading features and activities data file

features = read.table(file.path(path, "features.txt"),header = FALSE, col.names = c("n","functions"))
activity_Labels = read.table(file.path(path, "activity_labels.txt"),header = FALSE, col.names = c("code", "activity"))

### Reading X data file
xtrain = read.table(file.path(path, "train", "X_train.txt"),header = FALSE, col.names = features$functions)
xtest = read.table(file.path(path, "test", "X_test.txt"),header = FALSE, col.names = features$functions)


### Reading Y data file
ytrain = read.table(file.path(path, "train", "y_train.txt"),header = FALSE, col.names = "code")
ytest = read.table(file.path(path, "test", "y_test.txt"),header = FALSE, col.names = "code")


### Reading Subject data file
subject_train = read.table(file.path(path, "train", "subject_train.txt"),header = FALSE, col.names = "subject")
subject_test = read.table(file.path(path, "test", "subject_test.txt"),header = FALSE, col.names = "subject")


#Merging the train and test data files of X, Y and Subject
XYSub_train = cbind(ytrain, subject_train, xtrain)
XYSub_test = cbind(ytest, subject_test, xtest)

#Create the All data file by merging the training and testing of XYSub
All_Data = rbind(XYSub_train, XYSub_test)


TidyData <- All_Data %>% select(subject, code, contains("mean"), contains("std"))
TidyData$code <- activity_Labels[TidyData$code, 2]

## Setting labels the data set with descriptive variable names.
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

## Export the text file called Week4_Result.txt

FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(mean)
write.table(FinalData, "Week4_Result.txt", row.name=FALSE)


### Checking the results
#print("------------------- features------------------------------")
#str(features)
#print("-------------------- activity_Labels----------------------")
#str(activity_Labels)

#print("---------------------------- Xtrain-----------------------")
#str(xtrain)
#print("-------------------------- Xtest--------------------------")
#str(xtest)

#print("---------------------- ytrain-----------------------------")
#str(ytrain)
#print("----------------------- ytest-----------------------------")
#str(ytest)

#print("-------------------- subject_train------------------------")
#str(subject_train)
#print("-------------------- subject_test-------------------------")
#str(subject_test)

#print("--------------------- XYSub_train-------------------------")
#str(XYSub_train)
#print("--------------------- XYSub_test--------------------------")
#str(XYSub_test)

#print("------------------------ All Data-------------------------")
#str(All_Data)

#str(TidyData)