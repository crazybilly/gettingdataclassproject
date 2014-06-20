# Tidying Up Smartphone Data
###### a project for the Getting and Cleaning Data class on Coursera, June 2014 

This repo contains my coursework for the Getting & Cleaning Data course,
specifically an R script to acquire and tidy a set of data from the [UCI
Machine Learning
Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Included in this repo are:

  * **run_analysis.R** - provides functions to download and tidy the data
  * **loaddatafortesting.R** - loads the downloaded data files into R objects for manual, exploratory analysis. This function was not a course requirement and is provided for convenience only. 

A copy of the data is included in the repo for my own convenience--if you're
running this on your own, I recommend deleting the data and re-downloading it,
to ensure you get a first generation copy (see links below).

### Dependencies 

The data preparation script depends on the following R packages:

  * rshape2
  * plyr 

Prepdata() will attempt to load these packages and will bomb out with an error if these packages are not installed. 

### Usage	

1. source(run_analysis.R) - creates two functions:

    1. prepdata() - this function accepts no arguments and returns a data frame of all the data. It will look in the current directory for a
file named 'smartphone-data.zip'--if it does not find this file, it will
download and unzip a new copy, then bring the data together into a
single data frame and return it (see the codebook for details about how this process
works).

    2. avgdata(x,factors=c("subject","activity","activity_code")) - this
function takes two arguments:

        1. x - a data frame, usually the one prepared by prepdata().
        2. a list of strings, naming the factor columns within x. This argument
defaults to the factor columns returned by
prepdata().

    Avgdata returns a dataframe with the average of all measurements for
each subject/activity/measurement set (see the codebook for futher
explanation)

2. loaddatafortesting.R - If you have already downloaded and unzipped the data via prepdata (the
unzipping process should create a subdirectory in the current working
directory called "UCI HAR Dataset"), you can source(loaddatafortesting.R)
to load the top level data into a series of R objects. This script does not
provide any functions--it immediately loads the data into various R
objects. This scrpt is provided solely as a convienence for testing and
futher exploration.


### References

  * [Coursera course page](https://class.coursera.org/getdata-004)
  * [Original data
  set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  )
  * [UCI's information about the
  data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
