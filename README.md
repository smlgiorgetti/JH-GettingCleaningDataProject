# JH-GettingCleaningDataProject

The script *run_analysis.R* downloads data from Human Activity Recognition database, merges the training and the test sets to create one data set, extracts only the measurements on the mean and standard deviation for each measurement and finally creates an independent tidy data set with the average of each variable for each activity and each subject. 

#### Prerequisites
* R version 3.2.1
* dplyr package
* R Studio (optional)
* A working directory on file system with *run_analysis.R* in it

#### Overall Workflow
The script looks for a local file named *UCI-HAR-Dataset.zip* in the working directory.
If such a file does not exist, it downloads it from [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
The archive is unzipped, files read and analysed.
Finally, analysis outcome - i.e. the average of each variable for each activity and each subject - is written in a plain text, TAB-separated file "tidyData.txt" in the working directory.
