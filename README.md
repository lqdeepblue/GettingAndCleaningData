## GettingAndCleaningData

The data source
===============
A full description of the data source is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

You can find the data used in the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Files are used
=========================================
Download and extract the .zip file into your R-Studio workspace. 
The following files are required to generate the target output

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'train/subject_train.txt'

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'test/subject_test.txt': Test labels.

- 'run_analysis.R': R script used to generate the output.

Feature selection
=================
Extracts only the measurements on the mean and standard deviation for each measurement. The “features.txt” contains all feature names and their indexes. The script grep feature names that contain “mean” or “std” to construct the new feature list. The indexes of the feature correspond to the column indexes of the data stored in “./test/X_test.txt” or “./train/X_train.txt” datasets.

Extract data from files
===============================
Using the constructed feature list, a new train dataset is extracted from “train/X_train.txt”. The new dataset contains the variables referred by the feature list only. The activity of each record is given by “train/y_text.txt”. Two columns are added to the new dataset to refer the subject and its activity. The subject is read from the file “train/subject_train.txt”. “train/y_test.txt” file gives the activity. 

Another new dataset is extracted from folder “test” by following the same procedure mentioned above.

Combine the two dataset
=======================
Combining the dataset is straight forward. The two dataset contains the same variables and structure. The R script uses rbind() function to combine them. The variable names are extracted from file “features.txt”, with two additional names “volunteer” and “activity”. The order of the variable name are arranged according to the column of the dataset.  

the script uses activity names in “activity_labels.txt” to name the activities in the data set. This is achieved by replace the values in activity column by the activity label respectively. 

Aggregate the data
==================
In the final data output, the R script calculates the mean of each variable for each activity and each subject. The data set is written into a txt file “output.txt” created with write.table() function with row.name=FALSE. 


