# Getting-and-Cleaning-Data

The run_analysis.R script includes the two parts, File reading and data cleaning.

PART I
1. Read the dataset and check the file list
    - Read the data files which are under the folder called UCI HAR Dataset
    
2. Read the data files and assign the data to their specified variables
    - features <- features.txt : 561 rows, 2 columns
    - activity_Labels <- activity_labels.txt : 6 rows, 2 columns
    - xtrain <- train/X_train.txt : 7352 rows, 561 columns 
    - xtest <- test/X_test.txt : 2947 rows, 561 columns 
    - ytrain <- train/y_train.txt : 7352 rows, 1 column
    - ytest<- test/y_test.txt : 2947 rows, 1 column
    - subject_train <- train/subject_train.txt :7352 rows, 1 column
    - subject_test <- test/subject_test.txt : 2947 rows  1 column


PART II
There are five steps for data cleaning.
1. Merge the training and test data files respectively and then merge them into one
    - create XYSub_train(7352 rows, 563 column) by merging the xtrain, ytrain and subject_train using cbind
    - create XYSub_test (2947 rows, 563 columns) by merging the xtest, ytest and subject_test using cbind
    - create the All_Data(10299 rows,  563 columns) by merging the XYSub_training and XYSub_test  using rbind
    
2.  Extracts the mean and standard deviation for measurements
    - Create TidyData (10299 rows, 88 columns) by subsetting All_Data using select function such as subject, code to extract the mean and standard deviation

3. Uses descriptive activity names to name the activities in the data set 
    - Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

4. Setting labels the data set with descriptive variable names 
    - All Acc in column’s name replaced by Accelerometer
    - All Gyro in column’s name replaced by Gyroscope
    - All BodyBody in column’s name replaced by Body
    - All Mag in column’s name replaced by Magnitude
    - All start with character f in column’s name replaced by Frequency
    - All start with character t in column’s name replaced by Time

5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    - FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after grouped by subject and activity.
    - Export Week4_Result.txt.

README
Peer-graded Assignment: Getting and Cleaning Data Course Project

Dataset

Human Activity Recognition Using Smartphones
Files
1.	CodeBook.md is a code book that describes the code explanations about variables and data transformation steps into final output.
2.	run_analysis.R performs the data preparation and then followed by the 5 steps required as described in the course project’s definition:
    –	Merges the training and the test sets to create one data set.
    –	Extracts only the measurements on the mean and standard deviation for each measurement.
    –	Uses descriptive activity names to name the activities in the data set
    –	Appropriately labels the data set with descriptive variable names.
    –	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

3.	Week4_Result.txt is the exported data file after processing the above steps.

