##Getting and Cleaning Data Course Project

###Introduction
This is the repo for the submission of the "Getting and Cleaning Data" Course Project through Johns Hopkins University/Coursera. 

###Dataset
The data used for this project is from the Human Activity Recognition Using Smartphones Data Set from UCI. Information about the dataset can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

###Overview
The goal of the project is to create tidy data. The script run_analysis.R does the following:
  (1) Merges the training and test set to create one dataset. 
  (2) Extracts only the measurements on the mean and standard deviation for each measurement.
  (3) Uses descriptive activity names to name the activities in the data set.
  (4) Appropriately labels the data set with descriptive variable names.
  (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
###Files
  - README.md
  - CodeBook.md describing the variables, data, and transformations performed. 
  - run_analysis.R is the script
  - ActivitySmartphonesDataAverages.txt is the tidy data set outputed at the end of run_analysis.R
  
###Notes
The script runs on a Windows 10 platform. 

###References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
