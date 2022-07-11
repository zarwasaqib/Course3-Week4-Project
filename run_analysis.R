library(data.table)
library(dplyr)

##Part 1
getwd()
setwd("~/Desktop/courseera/UCI HAR Dataset/test")
##read training data
xtest <- read.table("X_test.txt", header = FALSE)##features
ytest <- read.table("Y_test.txt", header = FALSE)##activity
subtest <- read.table("subject_test.txt", header = FALSE) ##subject

##read test data 
setwd("~/Desktop/courseera/UCI HAR Dataset/train")
xtrain <- read.table("X_train.txt", header = FALSE)
ytrain <- read.table("Y_train.txt", header = FALSE)
subtrain <- read.table("subject_train.txt", header = FALSE)

##merging data from two data sets above 
features <- rbind(xtest, xtrain) ##features
activity <- rbind(ytest, ytrain) ##activity
subject <- rbind(subtest, subtrain) ##subject

featureNames <- read.table("~/Desktop/courseera/UCI HAR Dataset/features.txt") ##the metadata in featureNames will be used to name the columns in the features data set
colnames(features) <- t(featureNames[2]) ##transposed featureNames data set column 2 and applied column names to features data set 

##metadata for activity names that will be used in Part3
activitylabels <- read.table("~/Desktop/courseera/UCI HAR Dataset/activity_labels.txt", header = FALSE)

##merging data
colnames(activity) <- "Activity" ##renaming columns activity to Activity 
colnames(subject) <- "Subject" ##renaming columns subject to Subject
AllData <- cbind(features,activity,subject) ##combining the data sets to make one called AllData

##Part 2 
colNames <- colnames(AllData)
##extracting the mean and standard deviation of all columns in the data set 
mean_std <- (grepl("Activity", colNames) | grepl("Subject", colNames) | grepl("mean..", colNames) | grepl("std..", colNames))
all_mean_std <- AllData[ , mean_std == TRUE]
clean_m_s <- AllData %>% select(Subject, Activity, contains("mean"), contains("std"))

##Part3
##Assigning descriptive names to the Activities in the data set 
##changing Activity column from numeric to character in order for it to accept activity names using the activitylabels metadata
clean_m_s$Activity <- as.character(clean_m_s$Activity) for (i in 1:6)
{clean_m_s$Activity[clean_m_s$Activity == i] <- as.character(activitylabels[i,2])}
##factoring the Activity variable
clean_m_s$Activity <- as.factor(clean_m_s$Activity)

##Part4
##labelling the datasets with appropriate names 
#Acc <- accelerometer
#t <- time
#f <- frequency
#Gyro <- gyroscope
#Mag <- Magnitude
names(clean_m_s) <- gsub("Acc", "Accelerometer", names(clean_m_s))  ##replace ACC with accelerometer in the clean_all data set using names()
names(clean_m_s) <- gsub("Gyro", "Gyroscope", names(clean_m_s))
names(clean_m_s) <- gsub("^t", "Time", names(clean_m_s))
names(clean_m_s) <- gsub("^f", "Frequency", names(clean_m_s))
names(clean_m_s) <- gsub("Mag", "Magnitude", names(clean_m_s))

##Part5--Taking an average of all variables for each activity and each subject
##ordering subject before activity so that R orders first by subject and then by activity
finaldata <- clean_m_s %>% group_by(Subject, Activity)
##Summarizing the final data by calculating the mean of each activity for each subject 
finaldata <- summarise_all(finaldata, funs(mean))

##Final Submission
write.table(finaldata, "finaldata.txt", row.names = FALSE)

















