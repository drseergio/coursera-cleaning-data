# Code Book

This first part of this code book describes the format of data used in the project. The source of data is [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) project.

The second part of this code books captures necessary steps performed to transform the source data into a new data set.

## Data Set Information

The original data represents experiments carried out with a group of 30 volunteers. Each volunteer performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Data captures signals from the embedded accelerometer and gyroscope.

This source data is not included in this repository and needs to be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.)

## Files in the original Data Set

Data is split into two sets: Test and Train. Information that is common to both data sets resides in the parent folder.

 - 'features\_info.txt': Shows information about the variables used on the feature vector.

 - 'features.txt': List of all features (variable names).

 - 'activity\_labels.txt': Links the class labels with their activity name (names of the activities). There are 6 activity types: WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING.

 - 'train/X\_train.txt': Training set (experimental observations). Total of 7352 observations across 561 variables.

 - 'train/y\_train.txt': Training labels (activities, matching the experiments). 7352 observations.

 - 'test/X\_test.txt': Test set (experimental observations). Total of 2947 observations across 561 variables.

 - 'test/y\_test.txt': Test labels (activities, matching the experiments). 2947 observations.

The following files are available for the train and test data. Their descriptions are equivalent.

 - 'train/subject\_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

## Processing steps

The goal of this project was to create a data set that identifies average values of some source variables grouped by subject and the type of the performed activity. All processing is performed by the "run\_analysis.R" script. The script assumes that source data is unpacked and placed into "UCI HAR Dataset" folder placed in the current working directory. The script produces a data set that is then written to "tidy\_data.txt" file in the current working directory.

The script performs the following:

 1. Read X\_train.txt. Then merge the data with activity information from y\_train.txt, followed by a merge with subject information from subject\_train.txt.

 2. Repeat the same for the X\_test.txt and y\_test.txt and subject\_test.txt files.

 3. Remove all variables except those containing "std()" and "mean()" in their names.

 4. Merge "train" and "test" sets into one long one.

 5. Replace activity ids with activity names.

 6. Group the data set by subject id and activity name, summarizing all variables using mean().

 7. Finally, order the observations on subject id, activity name.

 8. Write the data set to disk.
