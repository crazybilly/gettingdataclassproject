# Codebook - Getting and Cleaning Class Project
###### June 2014

## Summary

run_analysis.R() provides two functions for tidying the UCI smartphone data (see the readme for links to the original data and usage instructions):

1. **prepdata()** - downloads and tidys the data
2. **avgdata()** - returns averages for each subject/activity/measurement set

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
9. Return X (with subject, activity codes, activity names and measurement data)
 
#### Schema of The Returned Data Frame

prepdata() returns a data frame with 10,299 rows and 89 columns. 

Each row corresponds to a single measurement time. 

The first column gives the subject code. The second column includes an activity code and the third code an activity name.

Activity code is included to facilitate futher joining, should it be necessary, while activity name is included to ensure human readability. 

The following 86 columns are the mean and standard deviations of various sensor measurements as derived by UCI and provided in X_test and X_training, including the angle measurements (the project requirements called for "the mean and standard deviation for each measurement"--the angles are clearly a measurement, therefore they should be included in the subset of mean and standard deviation measurements). All special characters have been removed from the column names and all column names are in lower case.

### avgdata()

#### Function Walkthough

avgdata() accepts two arguments: a data frame like the one returned by prepdata() and an optional list of factors in the data frame. By default, the factors argument uses the factors generated in the results of prepdata().

It follows the steps below:

1. melt the data frame by the described factors.
2. recasts the data by the following formula: subject + activity ~ variable

#### Schema of the Returned Data Frame

Assuming you passed avgdata() the results of prepdata(), it returns a data frame of 180 rows and 88 columns.

Each row corresponds to a unique subject/activity pair (this pair is listed in the first two columns of the returned data frame).

The first column is the subject code; the second is the name of the activity. The other 86 columns are the mean of each sensor measurement for the subject/acvity pair over the entire data set, including the angle mean measurement (see justification above for why angles are included). 
