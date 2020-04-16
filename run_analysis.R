## It is assumed that UCI HCR Dataset files contain features.txt, activity_labels.txt files.
## And train and test folders contain subject_test.txt, y_test.txt, X_test.txt, 
## subject_train.txt, y_train.txt, and X_train.txt files respectively
## It is also assumed that project directory where thes files are located is used as working directory for R.
## Following code chunk gets the data from different sources and creates single Dataframe for analysis
## @knitr GatherData         
        SubjecttestDF <- read.table("./test/subject_test.txt")  ## read data from test data sets and combine them
        YtestDF <- read.table("./test/y_test.txt")
        testDF <- read.table("./test/X_test.txt", sep = "", stringsAsFactors = FALSE)
        testDFF <- cbind(SubjecttestDF,YtestDF)
        testDFF <- cbind(testDFF,testDF)
        
        SubjecttrainDF <- read.table("./train/subject_train.txt") ## read data from train data sets and combine them
        YtrainDF <- read.table("./train/y_train.txt")
        trainDF <- read.table("./train/X_train.txt", sep = "", stringsAsFactors = FALSE)
        trainDFF <- cbind(SubjecttrainDF,YtrainDF)
        trainDFF <- cbind(trainDFF, trainDF)
        
        ## combine these two data sets
        jointDF <- rbind(testDFF, trainDFF)
        
        
        featuresDF <- read.table("features.txt", stringsAsFactors = FALSE) ## get column names
        columnDF <- as.vector(c("subjectID", "activity",featuresDF[,2]))  ## create a vector of ALL column names
        names(jointDF) <- columnDF   ## add apprppriate column names to combinded data set
        
        ## add descriptive names to activities column
        activityVector <- as.vector(jointDF[,2]) 
        activityVector <- as.character(activityVector)
        activityVector <- sub("1", "WALKING", activityVector)
        activityVector <- sub("2", "WALKING_UPSTAIRS", activityVector)
        activityVector <- sub("3", "WALKING_DOWNSTAIRS", activityVector)
        activityVector <- sub("4", "SITTING", activityVector)
        activityVector <- sub("5", "STANDING", activityVector)
        activityVector <- sub("6", "LAYING", activityVector)
        jointDF[,2] <- activityVector   ## update the dataframe with descriptive values 
        
        ## Identify required columns to be preserved for analysis
        reqColumnVectorMean <- grep("\\mean()\\b", columnDF)  ##  find the index of all column names containing "mean()" 
        reqColumnVectorStd <- grep("std()", columnDF)    ##  find the index of all column names containing "std" 
        reqColumnVector <- c(1,2,reqColumnVectorMean,reqColumnVectorStd) ## recreate complete needed index 
        sortedColVector <- sort(reqColumnVector)
        reqJointDF <- jointDF[ , sortedColVector]       ## select only needed columns and get final Data Frame for analysis
        
        ## Clean column names per tidy dataset conventions  
        newNames <- names(reqJointDF)
        newNames <- gsub("-", "", newNames)   ## remove dashes
        newNames <- sub( "\\(", "", newNames) ## remove paranthesis
        newNames <- sub( "\\)", "", newNames)
        names(reqJointDF) <- newNames
        
        reqJointDF <- as.data.frame(reqJointDF) ## remove groupng information to save to a csv file
        
        write.csv(reqJointDF, file = "RequiredDataFrame.csv", row.names=FALSE )  ## save the required data set in a csv file
        
        reqJointDF[1:8, 1:6]## output partial table for varification
##

## Following chunk of code groups the data per the requirement of the course project and create tidy data set
## @knitr GroupData
        reqJointDF <- read.csv("RequiredDataFrame.csv", stringsAsFactors = FALSE)
        grpdByIdActDF <- group_by(reqJointDF, subjectID, activity)
        grpdByIdActDFmean <- as.data.frame( summarize_all(grpdByIdActDF, list(Avg = mean)))
        newNames <- names(grpdByIdActDFmean)
        newNames <- gsub("_", "", newNames)   ## remove dashes
        names(grpdByIdActDFmean)<- newNames
        write.csv(grpdByIdActDFmean, file = "groupedMeanData.csv", row.names=FALSE)
        
        grpdByIdActDFmean[1:8,1:6]   ## output partial table for varification
##