# get the data and compile it into a single dataframe
#  where feature names become the column names
#  and the rows are:
#        subject code
#        activity code
#        activity name
#        measurement data from X (aother 561 rows)
# 
# returns the compiled dataframe
prepdata <- function() {

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
    activity_codes <- read.table("UCI HAR Dataset//activity_labels.txt", stringsAsFactors=F)
    names(activity_codes) <- c("activity_code","activity")
  
    #feature codes
    feature_codes <- read.table("UCI HAR Dataset//features.txt", stringsAsFactors=F)
    names(feature_codes) <- c("feature_codes","feature")
  
    #training data
    subject_train <- read.table("UCI HAR Dataset//train//subject_train.txt", stringsAsFactors=F)
    X_train       <- read.table("UCI HAR Dataset//train//X_train.txt", stringsAsFactors=F)
    y_train       <- read.table("UCI HAR Dataset//train//y_train.txt", stringsAsFactors=F)
  
    #test data
    subject_test <- read.table("UCI HAR Dataset//test//subject_test.txt", stringsAsFactors=F)
    X_test        <- read.table("UCI HAR Dataset//test//X_test.txt", stringsAsFactors=F)
    y_test        <- read.table("UCI HAR Dataset//test//y_test.txt", stringsAsFactors=F)

  
  #concatenate the training and test sets using rbind.fill to fill in NAs if data is missing in any columns
     X       <- rbind.fill(X_train,X_test)
     y       <- rbind.fill(y_train,y_test)
     subject <- rbind.fill(subject_train,subject_test)
  
  #merge y and the activity codes
     colnames(y) <- "activity_code"
     y       <-  join(y,activity_code)
  
  #fill in the column headings for X and subject
   # TODO ---------------------- before you do this, you need to rewrite these names--they're awful
     colnames(X) <- as.character(feature_codes$feature)
     colnames(subject) <- "subject"
  
  #add the subject and activity columns to X
     syX <- cbind(subject,y,X)
  
  
  #return only the mean and standard deviation columns
     
     #which columns are mean/std cols 
     #  (need to add 3 TRUE values at the beginning b/c we want to keep subject and activity names/codes)
     # I'm keeping everything with the word "mean" or "std" in it, including the angles
     meanstd.index <-c(TRUE, TRUE, TRUE, grepl("mean|std|Mean", feature_codes$feature))
     syX.msd <- syX[,meanstd.index]
  
     
return (syX.msd)
  
}



#return the average by .(subject,activity_code)
#can't figure this out...if there was was only one column, you'd use tapply...maybe you should, and do it in a loop


