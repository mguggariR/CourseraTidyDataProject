---
title: "README"
author: "MIG"
date: "4/16/2020"
output: 
  html_document: 
    keep_md: yes
---



##  Program Description    

It is assumed that the raw data is already downloaded and available at working directory of R in a structure similar to original zip file. The scripts used to perform the tasks required by the class project are described in this document. Accompanying codebook.md presents the results of the code outputs. 

## Scripts used in this project:  

Following code chunk will read rlevant data files from "test" folder and convert the data into dataframes. Then combine them in to one dataset using cbind function.   

```r
        SubjecttestDF <- read.table("./test/subject_test.txt") ##read data from test datasets & combine them
        YtestDF <- read.table("./test/y_test.txt")
        testDF <- read.table("./test/X_test.txt", sep = "", stringsAsFactors = FALSE)
        testDFF <- cbind(SubjecttestDF,YtestDF)
        testDFF <- cbind(testDFF,testDF)
```

Similarly, following code chunk will read rlevant data files from "train" folder and convert the data into dataframes. Then combine them in to one dataset using cbind function.  

```r
        SubjecttrainDF <- read.table("./train/subject_train.txt")##read data from train datasets & combine them
        YtrainDF <- read.table("./train/y_train.txt")
        trainDF <- read.table("./train/X_train.txt", sep = "", stringsAsFactors = FALSE)
        trainDFF <- cbind(SubjecttrainDF,YtrainDF)
        trainDFF <- cbind(trainDFF, trainDF)
```

The dataframes testDFF and trainDFF created above are joined by the rbind command as follows.   


```r
        ## combine these two data sets
        jointDF <- rbind(testDFF, trainDFF)
```

Following code chunk will read variable names stored in "features.txt" file to get proper variables 
(column) names for the table. In addition, "subjectID" and "activity" are added as proper variable
names for first two columns respectively.  

```r
        featuresDF <- read.table("features.txt", stringsAsFactors = FALSE) ## get column names
        columnDF <- as.vector(c("subjectID", "activity",featuresDF[,2])) ## create a vector of ALL column names
        names(jointDF) <- columnDF   ## add apprppriate column names to combinded data set
```

Following R code chunk will replace non-descriptive number values for activity variable into proper descriptive values.  

```r
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
```

Following code chunk will select only those columns of the data set that have mean and standard deviation values of the measurements. Then a subset of the joint dataframe is created as per the project requirements.     

```r
       ## Identify required columns to be preserved for analysis
        reqColumnVectorMean <- grep("\\mean()\\b", columnDF)  ## find the index of all column names containing "mean()" 
        reqColumnVectorStd <- grep("std()", columnDF)    ##  find the index of all column names containing "std()" 
        reqColumnVector <- c(1,2,reqColumnVectorMean,reqColumnVectorStd) ## recreate complete needed index 
        sortedColVector <- sort(reqColumnVector)
        reqJointDF <- jointDF[ , sortedColVector]       ## select only needed columns and get final Data Frame for analysis
```

Following code chunk will cleanup the names of the variables by removing special characters as per tidy dataset principles.

```r
        ## Clean column names per tidy dataset conventions  
        newNames <- names(reqJointDF)
        ## newNames <- tolower(newNames)  ## remove upper case characters
        newNames <- gsub("-", "", newNames)   ## remove dashes
        newNames <- sub( "\\(", "", newNames) ## remove paranthesis
        newNames <- sub( "\\)", "", newNames)
        names(reqJointDF) <- newNames
```

Following code chunk will prepare and save the dataset as a dataframe in a csv file for easy retrieval

```r
        reqJointDF <- as.data.frame(reqJointDF) 
        
        write.csv(reqJointDF, file = "RequiredDataFrame.csv", row.names=FALSE )  ## save the required data set in a csv file
```

A subset of the combined dataset can be returned for varification using this code chuck.  

```r
        reqJointDF[1:8, 1:6]## output partial table for varification
```

For the second part of the project the combined dataset created in previous section is read and saved as dataframe for R based operations on the data frame as shown below.  

```r
        reqJointDF <- read.csv("RequiredDataFrame.csv", stringsAsFactors = FALSE)
```

Following code chunk will use group_by and summarize functions to group the data based on subjectID and activity and then find group based average values for each variables. 

```r
        grpdByIdActDF <- group_by(reqJointDF, subjectID, activity)
        grpdByIdActDFmean <- as.data.frame( summarize_all(grpdByIdActDF, list(Avg = mean)))
```

Following code chunk will clean the column names by removing dashes introduces by summerize_all function.  

```r
        newNames <- names(grpdByIdActDFmean)
        newNames <- gsub("_", "", newNames)   ## remove dashes
        names(grpdByIdActDFmean)<- newNames
```

Following code chunk will create and store data in a txt file as requested.  

```r
write.table(grpdByIdActDFmean, file = "groupedMeanData.txt", row.names=FALSE)
```

A subset of the combined dataset can be returned for varification using this code chunk.  

```r
grpdByIdActDFmean[1:8,1:6]   ## output partial table for varification
```

As indicated earlier codebook.md presents the results of the code outputs. 
