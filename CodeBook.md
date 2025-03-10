Codebook
========

-   **person**: Person number 1 through 30 in experiments  
-   **activity**: 6 different activities, listed below

**Activities**:  
- WALKING  
- WALKING\_UPSTAIRS  
- WALKING\_DOWNSTAIRS  
- SITTING  
- STANDING  
- LAYING

Extracted Features
------------------

The features are listed below, in the order of the output\_ppl.txt file.

The units are the following:

-   contains **acc**: g, gravity  
-   contains **gyro**: radians/second  
-   activity and person are string and numeric, respectively

<!-- -->

    ##  [1] "activity"                    "person"                     
    ##  [3] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
    ##  [5] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
    ##  [7] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
    ##  [9] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
    ## [11] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
    ## [13] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
    ## [15] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
    ## [17] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
    ## [19] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
    ## [21] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
    ## [23] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
    ## [25] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
    ## [27] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
    ## [29] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
    ## [31] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
    ## [33] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
    ## [35] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
    ## [37] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
    ## [39] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
    ## [41] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
    ## [43] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
    ## [45] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
    ## [47] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
    ## [49] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
    ## [51] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
    ## [53] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
    ## [55] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
    ## [57] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
    ## [59] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
    ## [61] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
    ## [63] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
    ## [65] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
    ## [67] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"
