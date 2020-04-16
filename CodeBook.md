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
The original dataset contains many tables is different files to store raw data from the experiments carried out with a group of 30 volunteers. The objective is to obtain the raw data, clean it and structure it in tidy data format for analysis.  

The data was randomly divided in two datasets represented as training data set and test data sets.  In each dataset the raw data was spread in three data files: experimental results, subject IDs and type of activity. 

In this project these distributed datasets are obtained, cleaned, combined and a tidy data set is created.  In addition,  a new tidy data set is created with mean values of grouped dataset from original data set. 

Following sections explain the operation of the program and data dictionary for the tidy data set.  Further details of the actual program is provided the readme.txt file in the github depository. 

## **Program:**

It is assumed that the raw data is already down loaded and available at working directory of R in a structure similar to original zip file.  

An R based program was used to write two functions “getMyData” and “groupMyData”, to achieve the results. These programs should be called from the console in succession to create the required tiny dataset.  

#### *	"getMyData"

This function will load data from various data files in to R environment.  Then the data is combined to form a unified dataframe.   

As the values of the activity column in the unified dataset are obscurely coded from 1-6, a descriptive activity names are substituted in the column.

A new dataframe is created with only required columns to facilitate analysis.
Column names are modified to meet tidy data practices by removing special characters (e.g. parenthesis and dashes) and upper-case letters.

This clean data is then saved as “RequiredDataFrame.csv” in R working directory.

The function also outputs partial dataframe for verification as shown below.


 


```
##   subjectID activity tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ
## 1         2 STANDING     0.2571778   -0.02328523   -0.01465376
## 2         2 STANDING     0.2860267   -0.01316336   -0.11908252
## 3         2 STANDING     0.2754848   -0.02605042   -0.11815167
## 4         2 STANDING     0.2702982   -0.03261387   -0.11752018
## 5         2 STANDING     0.2748330   -0.02784779   -0.12952716
## 6         2 STANDING     0.2792199   -0.01862040   -0.11390197
## 7         2 STANDING     0.2797459   -0.01827103   -0.10399988
## 8         2 STANDING     0.2746005   -0.02503513   -0.11683085
```


#### b.	"groupMyData"

This function with load data from already created “RequiredDataFrame.csv” file in R working directory and converts that into a dataframe.  

This dataframe is then grouped by 30 Subject ID and 6 Activity types. 

Using this grouped dataframe, a new dataframe with 180 rows is created with summarized average value for each measurement in the data.  

This new data frame is saved as “groupedMeanData.csv” in R working directory.

The function also outputs partial dataframe for verification as shown below.



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


subjectID : (INT) Random identification number 1-30 for 30 volunteers  

activity : (CHAR) One of the six possible activities monitored  
* WALKING  
* WALKING_UPSTAIRS  
* WALKING_DOWNSTAIRS  
* SITTING  
* STANDING  
* LAYING  

All the following variables are of class NUM.  Variables with “t” suffix represent time domain signals. Variables with “f” suffix represent variables derived in frequency domain using Fast Fourier Transform.    

Average of the mean values of time domain accelerometer in 3 axis measurements for the body are represented by these variables.  

tBodyAccmeanXAvg  
tBodyAccmeanYAvg  
tBodyAccmeanZAvg  
fBodyAccmeanXAvg  
fBodyAccmeanYAvg  
fBodyAccmeanZAvg  

Average of the standard deviation of time domain accelerometer in 3 axis measurements for the body are represented by these variables.  
tBodyAccstdXAvg  
tBodyAccstdYAvg  
tBodyAccstdZAvg  
fBodyAccstdXAvg  
fBodyAccstdYAvg  
fBodyAccstdZAvg  

Average of the mean values of time domain accelerometer in 3 axis measurements for gravity are represented by these variables.
tGravityAccmeanXAvg
tGravityAccmeanYAvg
tGravityAccmeanZAvg

Average of the standard deviation of time domain accelerometer in 3 axis measurements for the body are represented by these variables.
tGravityAccstdXAvg
tGravityAccstdYAvg
tGravityAccstdZAvg

Average of mean value of Jerk signals derived from linear acceleration in 3 axis for body are represented by these variables. 
tBodyAccJerkmeanXAvg
tBodyAccJerkmeanYAvg
tBodyAccJerkmeanZAvg
fBodyAccJerkmeanXAvg
fBodyAccJerkmeanYAvg
fBodyAccJerkmeanZAvg

Average of standard deviation value of Jerk signals derived from linear acceleration in 3 axis for body are represented by these variables. 
tBodyAccJerkstdXAvg
tBodyAccJerkstdYAvg
tBodyAccJerkstdZAvg
fBodyAccJerkstdXAvg
fBodyAccJerkstdYAvg
fBodyAccJerkstdZAvg

Average of mean value of gyroscope signals  in 3 axes for body are represented by these variables. 
tBodyGyromeanXAvg
tBodyGyromeanYAvg
tBodyGyromeanZAvg
fBodyGyromeanXAvg
fBodyGyromeanYAvg
fBodyGyromeanZAvg

Average of standard deviation value of gyroscope signals in 3 axes for body are represented by these variables. 
tBodyGyrostdXAvg
tBodyGyrostdYAvg
tBodyGyrostdZAvg
fBodyGyrostdXAvg
fBodyGyrostdYAvg
fBodyGyrostdZAvg

Average of mean value of Jerk signals derived from angular velocity  in 3 axes for body are represented by these variables. 
tBodyGyroJerkmeanXAvg
tBodyGyroJerkmeanYAvg
tBodyGyroJerkmeanZAvg

Average of standard deviation value of Jerk signals derived from angular velocity  in 3 axes for body are represented by these variables. 
tBodyGyroJerkstdXAvg
tBodyGyroJerkstdYAvg
tBodyGyroJerkstdZAvg

Average of the mean and standard deviation of the magnitude of body acceleration using Euclidean norm are represented by these variables.
tBodyAccMagmeanAvg
tBodyAccMagstdAvg
fBodyAccMagmeanAvg
fBodyAccMagstdAvg

Average of the mean and standard deviation of the acceleration by gravity using Euclidean norm are represented by these variables.
tGravityAccMagmeanAvg
tGravityAccMagstdAvg

Average of the mean and standard deviation of the magnitude of Jerk of body acceleration using Euclidean norm are represented by these variables.
tBodyAccJerkMagmeanAvg
tBodyAccJerkMagstdAvg
fBodyBodyAccJerkMagmeanAvg
fBodyBodyAccJerkMagstdAvg

Average of the mean and standard deviation of the magnitude of gyro using Euclidean norm are represented by these variables.
tBodyGyroMagmeanAvg
tBodyGyroMagstdAvg
fBodyBodyGyroMagmeanAvg
fBodyBodyGyroMagstdAvg

Average of the mean and standard deviation of the magnitude of Jerk due to gravity-based  acceleration using Euclidean norm are represented by these variables. 
tBodyGyroJerkMagmeanAvg
tBodyGyroJerkMagstdAvg
fBodyBodyGyroJerkMagmeanAvg
fBodyBodyGyroJerkMagstdAvg


This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
```

## Including Plots

You can also embed plots, for example:

![](CodeBook_files/figure-html/pressure-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
