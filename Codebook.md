# Codebook - Getting and Cleaning Class Project
###### June 2014

## Summary

run_analysis.R() provides three functions for tidying the UCI smartphone data. 

1. **prepdata()** - downloads and tidys the data
2. **avgdata()** - returns averages for each subject/activity/measurement set
3. **run_analysis()** - a wrapper function to call both functions above. returns the results of avgdata().

## About the data

From the UCI's description of the data:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
>
>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

See README.md for links to the original data and UCI's full usage instructions.

## About the functions

### prepdata()

#### Function Walkthough

prepdata() accepts no arguments and returns a single dataframe with the mean and standard deviation measurements for the smartphone summary data.

It follows the general flow below:

1. Downloads data - looks for "smartphone-data.zip" in the current working directory--if the file is not found, the data is downloaded and unzipped.
2. The test and training data sets are read into R. Data include:
    -	X_test.txt and X_training.txt
    -	y_test.txt and y_training.txt
    -	subject_test.txt and subject_train.txt
    -  features.txt
    -  activity_labels.txt
3. Combine the test and training data, in that order, for each of the following:
    -	X
    -	y
    -	subject
4. Merge y data with activity_labels 
5. Remove special characters from feature names and change all letters to lowercase
6. Use feature codes as column names for X
7. Add subject code as first column of X
8. Add both activity code and activity name to x as new columns (at the beginning of the data frame)
9. Remove all columns which do not have names including the strings "mean", "Mean" or "std" to ensure we only have mean and standard deviation column. Note that these summaries were calculated by UCI and provided in the X data sets.
9. Return X (with subject, activity codes, activity names and measurement data).
 
#### Schema of The Returned Data Frame

prepdata() returns a data frame with 10,299 rows and 89 columns. 

Each row corresponds to a single measurement time. 

The first column gives the subject code. The second column includes an activity code and the third code an activity name.

Activity code is included to facilitate futher joining, should it be necessary, while activity name is included to ensure human readability. 

The following 86 columns are the mean and standard deviations of various sensor measurements as derived by UCI and provided in X_test and X_training, including the angle measurements (the project requirements called for "the mean and standard deviation for each measurement"--the angles are clearly a measurement, therefore they should be included in the subset of mean and standard deviation measurements). All special characters have been removed from the column names and all column names are in lower case.

### avgdata()

#### Function Walkthough

avgdata() accepts one argument: a data frame like the one returned by prepdata(). 

It follows the steps below:

1. melt the data frame by the described factors.
2. recasts the data by the following formula: subject + activity ~ variable

#### Schema of the Returned Data Frame

Assuming you passed avgdata() the results of prepdata(), it should return a data frame of 180 rows and 88 columns.

Each row corresponds to a unique subject/activity pair (this pair is listed in the first two columns of the returned data frame with subject code as the first column and the name of the activity in the second column).

The other 86 columns are the mean of each sensor measurement for the subject/acvity pair over the entire data set, including the angle mean measurement (see justification above for why angles are included). 
