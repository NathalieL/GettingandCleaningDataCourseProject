#Load dplyr package.
library(dplyr)

#Step 1 - Merge training and test sets into one data set.

#Download data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "~/data/smartphonedata.zip")

#Record date downloaded.
dateDownloaded <- date()

#Unzip the file.
unzip("smartphonedata.zip")

#Set working directory in file set. 
setwd("~/data/UCI HAR Dataset/")

#Download Datasets
training_set <- read.table("train/X_train.txt", sep = "")
training_labels <- read.table("train/y_train.txt", sep = "")
subject_train <- read.table("train/subject_train.txt", sep = "")

test_set <- read.table("test/X_test.txt", sep = "")
test_labels <- read.table("test/y_test.txt", sep = "")
subject_test <- read.table("test/subject_test.txt", sep = "")

#Merge datasets
training_data <- cbind(subject_train, training_labels, training_set)
test_data <- cbind(subject_test, test_labels, test_set)
merged_data <- rbind(training_data, test_data)


#Step 2 - Extract only the measurements on the mean and standard deviation for each measurement.

#Download features file. 
features <- read.table("features.txt", sep = "")

#Find columns with mean() or std()
meanstd <- grep("mean()|std()", features$V2)

#Add two in order to account for first 2 columns in merged dataset.
meanstd_adjusted <- meanstd+2

#Subset mean() and std() measurements into a new dataset "merged_data_subset".
merged_data_subset <- merged_data[,c(1,2,meanstd_adjusted)]


#Step 3 - Use descriptive activity names to name the activities in the data set.

#Download activity labels data file. 
activity_labels <- read.table("activity_labels.txt", sep ="")

#Change labels to lowercase.
activity_labels$V2 <- tolower(activity_labels$V2)

#Remove underscore from labels.
activity_labels$V2 <- sub("_", "", activity_labels$V2)

#Rename columns.
activity_labels <- rename(activity_labels, activity.number = V1, activity = V2)

#Merge activity labels and merged_data_subset.
merged_data_labeled <- merge(activity_labels, merged_data_subset, by.x="activity.number", by.y="V1.1")

#Remove activity.number column.
merged_data_labeled <- select(merged_data_labeled, -activity.number)

#Move subject column.
merged_data_labeled <- select(merged_data_labeled, V1, activity, V1.2:V552) 


#Step 4 - Appropriately labels the data set with descriptive variable names.

#Rename subject column.
merged_data_labeled <- rename(merged_data_labeled, subject = V1)

#Subset feature names of only mean and standard deviation.
features_subset <- features[meanstd,]

#Rename features.
features_subset$V2 <- gsub("^t", "Time", features_subset$V2)
features_subset$V2 <- gsub("^f", "Frequency", features_subset$V2)
features_subset$V2 <- gsub("(Acc)", "Acceleration", features_subset$V2)
features_subset$V2 <- gsub("-mean()", "Mean", features_subset$V2)
features_subset$V2 <- gsub("-std()", "StdDev", features_subset$V2)
features_subset$V2 <- gsub("(Mag)", "Magnitude", features_subset$V2)
features_subset$V2 <- gsub("\\()", "", features_subset$V2)
features_subset$V2 <- gsub("(BodyBody)", "Body", features_subset$V2)

#Subset only names column.
features_names <- features_subset[,2]

#Rename columns with appropriate features.
colnames(merged_data_labeled) = c("Subject", "Activity", features_names)


#Step 5 - From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

#Create new dataframe. 
df <- tbl_df(merged_data_labeled)

#Group by subject, then activity. 
by_subject <- group_by(df, Subject, Activity)

#Create new tidy data set with the average (mean) of each activity and each subject. 
tidy_data <- summarize_each(by_subject, funs(mean))

#Export file as txt file.
write.table(tidy_data, file = "ActivitySmartphonesDataAverages.txt", row.names = FALSE)
