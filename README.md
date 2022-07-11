# Course3-Week4-Project

This README file contains a precise description of how the run_analysis script works

The  script is divided into 5 main parts that tidy the dataset that was specified in the "Getting and Cleaning data" week 4 assignment.

Part 1 of the code involves setting the working directory and loading the training and test datasets into two individual dataframes and renaming all the data tables for easier use inthe next steps. The "ytest/train" datatables contain one variable called activity and subject was the variable in "subtest/train". The names of the columns in "xtrain/test" were corrected and matched with the names that were provided in the second column of "features.txt" table. At the end the two dataframes (test and train) were combined into one dataframe using the cbind function.

Part 2 of the code involved extracting the mean and standard deviations of all columns in the data set. clean_m_s dataframe contains the mean and standard deviations of all the columns of the data set.

Part 3 of the code appropriately label all the activities with the actual activity names using the activitylabels metadata file. At the end the numeric values in the "Activity" column were substituted with actual activity name. In the process, "Activity" column was chnaged from numeric to character in order for the column to accept activity names using the activitylabels metadata. as.factor function was used to factor the activity varaible in the data set.

Part 4 of the code appropriately label the list of columns in the clean_m_s dataframe containing mean and standard deviations. gsub function was used several times to make the varaible names more descriptive. 

Part 5 of the code uses the group_by funciton to take the dataset and group it by Subject first and then Activity so that the data set is organized by "Subject" first. summarize_all function was used to summarize the entire dataset by applyig the mean function and calculating the mean of each activity for each subject in the dataset. 
