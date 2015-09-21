library("dplyr")

urlFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#downloadDir <- paste(getwd(), "data", sep = "/")
#if(!file.exists(downloadDir)) { dir.create("data")}

zipLocalFile <- paste(".", "UCI-HAR-Dataset.zip", sep = "/")
if(!file.exists(zipLocalFile)) { download.file(urlFile, zipLocalFile, method = "curl") }
if(!file.exists("UCI HAR Dataset")) { unzip(zipLocalFile, exdir = ".") }


# read raw features from file
features <- read.csv("./UCI HAR Dataset/features.txt", sep = " ", header = FALSE)[,2]
# read activity labels from file
activityLabels <- read.csv("./UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)
colnames(activityLabels) <- c("activityID", "ActivityName")

# read training and test data and merge them together
train <- read.csv("./UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
test <- read.csv("./UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
subjectIDs <- read.csv("./UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)
subjectIDs <- rbind.data.frame(subjectIDs, read.csv("./UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE))
activityIDs <- read.csv("./UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
activityIDs <- rbind.data.frame(activityIDs, read.csv("./UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE))
allData <- rbind(train, test)
allData <- cbind.data.frame(allData, subjectIDs, activityIDs)

features <- append(as.character(features), c("Subject", "activityID"))
colnames(allData) <- features

allData <- merge(allData, activityLabels, by = "activityID")

# clean labels
featuresNames <- names(allData)
featuresNames <- gsub('-mean', 'Mean', featuresNames)
featuresNames <- gsub('-std', 'Std', featuresNames)
featuresNames <- gsub('[-()]', '', featuresNames)
colnames(allData) <- featuresNames

# select features
filteredFeatures <- grep('-mean|-std|Subj|Name', names(allData))

# filter unwanted features out
allData <- allData[,filteredFeatures]

# creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.
tidyData <- allData %>% group_by(Subject, ActivityName) %>% summarise_each(funs(mean))

#write out
write.table(tidyData, "./tidyData.txt", sep="\t", row.names = FALSE)
