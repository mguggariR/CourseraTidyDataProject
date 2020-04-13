## It is assumed that UCI HCR Dataset files containing features.txt, activity_labels.txt, train and test folders containing
## subject_test.txt, y_test.txt, X_test.txt, subject_train.txt, y_train.txt, X_train.txt files
## This function gets the data from different sources and creates signle Dataframe for analysis
getMyData < function(){
        SubjecttestDF <- read.table("./test/subject_test.txt")  ## read data from test data sets and combine them
        YtestDF <- read.table("./test/y_test.txt")
        testDF <- read.table("./test/X_test.txt", sep = "", stringsAsFactors = FALSE)
        testDFF <- cbind(SubjecttestDF,YtestDF)
        testDFF <- cbind(testDFF,testDF)
        
        SubjecttrainDF <- read.table("./train/subject_train.txt")
        YtrainDF <- read.table("./train/y_train.txt")
        trainDF <- read.table("./train/X_train.txt", sep = "", stringsAsFactors = FALSE)
        trainDFF <- cbind(SubjecttrainDF,YtrainDF)
        trainDFF <- cbind(trainDFF, trainDF)
        
        ## combine these two data sets
        jointDF <- rbind(testDFF, trainDFF)
        
        ## get column names
        featuresDF <- read.table("features.txt", stringsAsFactors = FALSE)
        columnDF <- as.vector(c("subjectid", "activity",featuresDF[,2]))  ## create a vector of ALL column names
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
        reqColumnVectorMean <- grep("mean()", columnDF)  ##  find the index of all column names containing "mean" 
        reqColumnVectorStd <- grep("std()", columnDF)    ##  find the index of all column names containing "std" 
        reqColumnVector <- c(1,2,reqColumnVectorMean,reqColumnVectorStd) ## recreate complete needed index 
        sortedColVector <- sort(reqColumnVector)
        reqJointDF <- jointDF[ , sortedColVector]       ## select only needed columns and get final Data Frame for analysis
        
        ## Clean column names per tidy dataset conventions  
        newNames <- names(reqJointDF)
        newNames <- tolower(newNames)  ## remove upper case characters
        newNames <- gsub("-", "", newNames)   ## remove dashes
        newNames <- sub( "\\(", "", newNames) ## remove paranthesis
        newNames <- sub( "\\)", "", newNames)
        names(reqJointDF) <- newNames
        
        write.csv(reqJointDF, file = "RequiredDataFrame.csv", row.names=FALSE )  ## save the required data set in a csv file
}


## group the data per the requirement of the course project
groupMyData <- function(){
        read.csv("RequiredDataFrame.csv", reqJointDF)
        grpdByIdActDF <- group_by(reqJointDF, subjectid, activity)
        grpdByIdActDFmean <- summarize_all(grpdByIdActDF, list(mean=mean))
        write.csv(grpdByIdActDFmean, file = "groupedMeanData.csv", row.names=FALSE)
}


