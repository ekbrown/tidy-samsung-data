# CodeBook.md

The tidy set created by the run_analysis.R file summarizes the values (normalized to values betwen -1 and 1) in the Samsung data set by Subject by Activity by Variable.

The tidy set that is created has four columns:
* Subject: ID numbers for the 30 participants
* Activity: The activity during which the measurement was taken, among 'laying', 'sitting', 'standing', 'walking', 'walking downstairs', 'walking upstairs'
* Variable: The 66 variable names that contain either 'mean()' or 'std()'
* Average_value: The average value for the measurements for Variable when Subject was doing Activity

The script creates the tidy set in the following steps:

## Step 1
Loads the the training files 'train/X_train.txt, 'train/y_train.txt', 'train/subject_train.txt' and the test files 'test/X_test.txt', 'test/y_test.txt', 'test/subject_test.txt' and then merges them into one data frame.

## Step 2
Loads the 'features.txt' file, which has information about the variables, and then excludes the measurements that don't contain either 'mean()' or 'std()'.

## Step 3
Loads 'activity_labels.txt', which has labels for the activities (rather than just numbers).

## Step 4
Adds the variables labels previously loaded in from 'features.txt'.

## Step 5
Uses a sweet pipeline, a la dplyr, to bend, massage, and manipulate the data into a tidy format (one variable per column). Additionally, this step saves the tidy data set to the hard drive, into the working directory of the R session.
