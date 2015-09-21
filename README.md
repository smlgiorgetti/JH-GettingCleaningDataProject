# JH-GettingCleaningDataProject

The script *run_analysis.R* downloads data from Human Activity Recognition database, merges the training and the test sets to create one data set, extracts only the measurements on the mean and standard deviation for each measurement and finally creates an independent tidy data set with the average of each variable for each activity and each subject.  

Full description of source data is available at [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

#### Prerequisites
* R version 3.2.1
* dplyr package
* R Studio (optional)
* A directory on file system with *run_analysis.R* in it. Such directory must be set as **the** working directory for R

#### Overall Workflow
The script looks for a local file named *UCI-HAR-Dataset.zip* in the working directory.
If such a file does not exist, it downloads it from [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
The archive is unzipped, files read, merged together and manipulated.  
Specifically, train and test data - i.e. 'train/X_train.txt', 'train/y_train.txt', 'test/X_test.txt', 'test/y_test.txt' - are merged together, along with subjects IDs ('train/subject_train.txt' and 'test/subject_test.txt'). Data labels are read and "cleaned": '-()' characters are removed and 'mean' and 'std' changed into 'Mean' and 'Std' respectively.  
Finally, analysis outcome - i.e. the average of each variable grouped by activity and subject - is written in a plain text, TAB-separated file "tidyData.txt" in the working directory.
