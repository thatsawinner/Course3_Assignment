library(dplyr)

######################################################################################
# Download the data and unzip it in to the working directory.                        #
# Read in the Activities and Features data and label the variables.                  #
# Read in the Training data, combine it in to one data set, and label the variables. #
# Read in the Test data, combine it in to one data set, and label the variables.     #
# Combine the Training and Test data sets in to one data set.                        #
######################################################################################
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "dataset.zip"

# Download
download.file(url, destfile = zipFile)
unzip(zipFile)

# Activities and Features data
activities <- read.table('UCI HAR Dataset/activity_labels.txt')
colnames(activities) <- c('activityID', 'activityName')
features <- read.table('UCI HAR Dataset/features.txt', as.is = TRUE)
colnames(features) <- c('featureID', 'featureName')

# Training data
trainLabels <- read.table('UCI HAR Dataset/train/y_train.txt')
trainSubjects <- read.table('UCI HAR Dataset/train/subject_train.txt')
trainData <- read.table('UCI HAR Dataset/train/X_train.txt')
trainData <- cbind(trainSubjects, trainLabels, trainData)
rm(trainLabels, trainSubjects)
colnames(trainData) <- c('Subject', 'Activity', features$featureName)

# Test data
testLabels <- read.table('UCI HAR Dataset/test/y_test.txt')
testSubjects <- read.table('UCI HAR Dataset/test/subject_test.txt')
testData <- read.table('UCI HAR Dataset/test/X_test.txt')
testData <- cbind(testSubjects, testLabels, testData)
rm(testLabels, testSubjects)
colnames(testData) <- c('Subject', 'Activity', features$featureName)

allData <- rbind(trainData, testData)
rm(trainData, testData) # Remove the training and test data sets as they are no longer needed.

###########################################################
# Keep only the mean and standard deviation measurements. #
###########################################################
allData <- allData[, grep("Subject|Activity|.*mean.*|.*std.*", colnames(allData))]

#########################################################
# Set Subject to a factor for later use.                #
# Set Activity to factor and apply labels to variables. #
#########################################################
allData$Subject <- as.factor(allData$Subject)
allData$Activity <- factor(allData$Activity, levels = activities$activityID, labels = activities$activityName)

################################################
# Clean up the Feature labels for readability. #
################################################
cleanedNames <- colnames(allData)
cleanedNames <- gsub("^f", "Frequency_", cleanedNames)
cleanedNames <- gsub("^t", "Time_", cleanedNames)
cleanedNames <- gsub("Acc", "Accelerometer_", cleanedNames)
cleanedNames <- gsub("Gyro", "Gyroscope_", cleanedNames)
cleanedNames <- gsub("Mag", "Magnitude_", cleanedNames)
cleanedNames <- gsub("std", "StandardDeviation", cleanedNames)
cleanedNames <- gsub("BodyBody", "Body", cleanedNames)
colnames(allData) <- cleanedNames

######################################################################################
# Create a separate data set of the average of each variable by Subject and Activity #
######################################################################################
allData_Averages <- summarize_all(group_by(allData, Subject, Activity), mean)
write.table(allData_Averages, "tidy.txt", row.names = FALSE, quote = FALSE)
