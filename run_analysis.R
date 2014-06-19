run_analysis <- function() {

  #check to see if you've already downloaded the file
  if(!file.exists("smartphone-data.zip")) {
    
    #if not, download it
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                  ,"smartphone-data.zip"
                  ,method="curl")
    
    #then unzip it
    unzip("smartphone-data.zip")
  }
  
  #start reading in the data
    #activity codes
    activity_codes <- read.table('UCI HAR Dataset//activity_labels.txt')
    names(activity_codes) <- c("activity_code","activity")
  
    #feature codes
    feature_codes <- read.table("UCI HAR Dataset//features.txt")
    names(feature_codes) <- c("feature_codes","feature")
  
    #training data
    subject_train <- read.table("UCI HAR Dataset//train//subject_train.txt")
    X_train       <- read.table("UCI HAR Dataset//train//X_train.txt")
    y_train       <- read.table("UCI HAR Dataset//train//y_train.txt")
  
    #test data
    subject_test <- read.table("UCI HAR Dataset//test//subject_test.txt")
    X_test        <- read.table("UCI HAR Dataset//test//X_test.txt")
    y_test        <- read.table("UCI HAR Dataset//test//y_test.txt")

}
