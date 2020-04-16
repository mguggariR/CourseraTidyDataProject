---
title: "CodeBook for Tidy Dataset from UCI HCR data"
author: "MIG"
date: "4/14/2020"
output:
  html_document: 
    highlight: tango
    keep_md: yes
editor_options: 
  chunk_output_type: inline
---



## **Introduction:**
The original dataset contains many tables in different files to store raw data from the experiments carried out with a group of 30 volunteers. The objective is to obtain the raw data, clean it and structure it in a tidy data format for analysis.  

The data was randomly divided in two datasets represented as training data set and test data sets.  In each dataset the raw data was spread in three data files: experimental results, subject IDs and type of activity. 

In this project these distributed datasets are obtained, cleaned, combined and a tidy data set is created.  

In addition,  a new tidy data set is created with mean values of grouped dataset from original data set for further higher level analyis of the dataset. 

Following sections explain the operation of the program and provide data dictionary for the final tidy data set.  

In addition, this rmd file is designed to run the scripts and produce a subset of the data in table format for the two parts of the project. Further details of the actual program are provided the README.md file in the github depository. 

## **Program:**

It is assumed that the raw data is already down loaded and available at working directory of R in a structure similar to original zip file.  

An R based program is written in two chunks “getMyData” and “groupMyData”, to achieve the results. These program chucks can be called from the console in succession to create the required tiny dataset.  

#####  "getMyData"

This R code chunk will load data from various data files in to R environment.  Then the data is combined to form a unified dataframe.   

As the values of the activity column in the unified dataset are obscurely coded from 1-6, a descriptive activity names are substituted in the column.

A new dataframe is created with only required columns to facilitate analysis.
Column names are modified to meet tidy data practices by removing special characters (e.g. parenthesis and dashes).

This clean data is then saved as “RequiredDataFrame.csv” in R working directory.

The last line of code in this chuck also outputs partial dataframe for verification as shown below.




```
##   subjectID activity tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tBodyAccstdX
## 1         2 STANDING     0.2571778   -0.02328523   -0.01465376   -0.9384040
## 2         2 STANDING     0.2860267   -0.01316336   -0.11908252   -0.9754147
## 3         2 STANDING     0.2754848   -0.02605042   -0.11815167   -0.9938190
## 4         2 STANDING     0.2702982   -0.03261387   -0.11752018   -0.9947428
## 5         2 STANDING     0.2748330   -0.02784779   -0.12952716   -0.9938525
## 6         2 STANDING     0.2792199   -0.01862040   -0.11390197   -0.9944552
## 7         2 STANDING     0.2797459   -0.01827103   -0.10399988   -0.9958192
## 8         2 STANDING     0.2746005   -0.02503513   -0.11683085   -0.9955944
```

#####  "groupMyData"

This chunk of R code loads data from already created “RequiredDataFrame.csv” file in R working directory and converts that into a dataframe.  

This dataframe is then grouped by 30 Subject IDs and 6 Activity types.   

Using this grouped dataframe, a new dataframe with 180 rows is created with summarized average value for each measurement in the data.  

This new data frame is saved as “groupedMeanData.txt” in R working directory.  

The last line of code in this chunk also outputs partial dataframe for verification as shown below.  



```
##   subjectID           activity tBodyAccmeanXAvg tBodyAccmeanYAvg
## 1         1             LAYING        0.2215982     -0.040513953
## 2         1            SITTING        0.2612376     -0.001308288
## 3         1           STANDING        0.2789176     -0.016137590
## 4         1            WALKING        0.2773308     -0.017383819
## 5         1 WALKING_DOWNSTAIRS        0.2891883     -0.009918505
## 6         1   WALKING_UPSTAIRS        0.2554617     -0.023953149
## 7         2             LAYING        0.2813734     -0.018158740
## 8         2            SITTING        0.2770874     -0.015687994
##   tBodyAccmeanZAvg tBodyAccstdXAvg
## 1       -0.1132036     -0.92805647
## 2       -0.1045442     -0.97722901
## 3       -0.1106018     -0.99575990
## 4       -0.1111481     -0.28374026
## 5       -0.1075662      0.03003534
## 6       -0.0973020     -0.35470803
## 7       -0.1072456     -0.97405946
## 8       -0.1092183     -0.98682228
```

## DATA DICTIONARY: ##

This section describes all the variables present in the output produced by this data analysis.  


*  subjectID : (INT) Random identification number 1-30 for 30 volunteers  

*  activity : (CHAR) One of the six possible activities monitored   
    1.  WALKING    
    2.  WALKING_UPSTAIRS  
    3.  WALKING_DOWNSTAIRS  
    4.  SITTING  
    5.  STANDING  
    6. LAYING  

All the following variables are of class NUM.  Variables with “t” suffix represent time domain signals. Variables with “f” suffix represent variables derived in frequency domain using Fast Fourier Transform.    

Average of the mean values of time domain accelerometer in 3 axis measurements for the body are represented by these variables.    

*    tBodyAccmeanXAvg    
*    tBodyAccmeanYAvg  
*    tBodyAccmeanZAvg  
*    fBodyAccmeanXAvg  
*    fBodyAccmeanYAvg  
*    fBodyAccmeanZAvg  

Average of the standard deviation of time domain accelerometer in 3 axis measurements for the body are represented by these variables.  

*    tBodyAccstdXAvg  
*    tBodyAccstdYAvg  
*    tBodyAccstdZAvg  
*    fBodyAccstdXAvg  
*    fBodyAccstdYAvg  
*    fBodyAccstdZAvg  

Average of the mean values of time domain accelerometer in 3 axis measurements for gravity are represented by these variables.  

*    tGravityAccmeanXAvg  
*    tGravityAccmeanYAvg  
*    tGravityAccmeanZAvg

Average of the standard deviation of time domain accelerometer in 3 axis measurements for the body are represented by these variables.  

*    tGravityAccstdXAvg
*    tGravityAccstdYAvg
*    tGravityAccstdZAvg

Average of mean value of Jerk signals derived from linear acceleration in 3 axis for body are represented by these variables.  

*    tBodyAccJerkmeanXAvg
*    tBodyAccJerkmeanYAvg
*    tBodyAccJerkmeanZAvg
*    fBodyAccJerkmeanXAvg
*    fBodyAccJerkmeanYAvg
*    fBodyAccJerkmeanZAvg

Average of standard deviation value of Jerk signals derived from linear acceleration in 3 axis for body are represented by these variables.  

*    tBodyAccJerkstdXAvg
*    tBodyAccJerkstdYAvg
*    tBodyAccJerkstdZAvg
*    fBodyAccJerkstdXAvg
*    fBodyAccJerkstdYAvg
*    fBodyAccJerkstdZAvg

Average of mean value of gyroscope signals  in 3 axes for body are represented by these variables.  

*    tBodyGyromeanXAvg  
*    tBodyGyromeanYAvg  
*    tBodyGyromeanZAvg  
*    fBodyGyromeanXAvg  
*    fBodyGyromeanYAvg  
*    fBodyGyromeanZAvg  

Average of standard deviation value of gyroscope signals in 3 axes for body are represented by these variables.  

*    tBodyGyrostdXAvg
*    tBodyGyrostdYAvg
*    tBodyGyrostdZAvg
*    fBodyGyrostdXAvg
*    fBodyGyrostdYAvg
*    fBodyGyrostdZAvg

Average of mean value of Jerk signals derived from angular velocity  in 3 axes for body are represented by these variables.  

*    tBodyGyroJerkmeanXAvg  
*    tBodyGyroJerkmeanYAvg  
*    tBodyGyroJerkmeanZAvg  

Average of standard deviation value of Jerk signals derived from angular velocity  in 3 axes for body are represented by these variables.   

*    tBodyGyroJerkstdXAvg  
*    tBodyGyroJerkstdYAvg  
*    tBodyGyroJerkstdZAvg  

Average of the mean and standard deviation of the magnitude of body acceleration using Euclidean norm are represented by these variables.  

*    tBodyAccMagmeanAvg  
*    tBodyAccMagstdAvg  
*    fBodyAccMagmeanAvg  
*    fBodyAccMagstdAvg  

Average of the mean and standard deviation of the acceleration by gravity using Euclidean norm are represented by these variables.  

*    tGravityAccMagmeanAvg  
*    tGravityAccMagstdAvg  

Average of the mean and standard deviation of the magnitude of Jerk of body acceleration using Euclidean norm are represented by these variables.  

*    tBodyAccJerkMagmeanAvg  
*    tBodyAccJerkMagstdAvg  
*    fBodyBodyAccJerkMagmeanAvg  
*    fBodyBodyAccJerkMagstdAvg  

Average of the mean and standard deviation of the magnitude of gyro using Euclidean norm are represented by these variables.   

*    tBodyGyroMagmeanAvg  
*    tBodyGyroMagstdAvg   
*    fBodyBodyGyroMagmeanAvg  
*    fBodyBodyGyroMagstdAvg  

Average of the mean and standard deviation of the magnitude of Jerk due to gravity-based  acceleration using Euclidean norm are represented by these variables.    

*    tBodyGyroJerkMagmeanAvg  
*    tBodyGyroJerkMagstdAvg  
*    fBodyBodyGyroJerkMagmeanAvg  
*    fBodyBodyGyroJerkMagstdAvg  
