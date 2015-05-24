Code Book of Variables and Script Explanation
=============================================

This document describes the codebook of variables from the UCLA Samsung
Galaxy S [data
set.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
The data has been cleaned and cut down into a final form, which is
available in the [output.txt
file.](https://github.com/kamilien1/get-clean-final/blob/master/output.txt)

Script Explanation
------------------

The `run_analysis.R` script performs five basic functions:  
1. Merges training and test data sets  
2. Extracts mean and standard deviation measurements from the data
sets  
3. Provides descriptive names for activities 1 to 6  
4. Labels the measurements with appropriate, descriptive names  
5. Writes an output file of average values of sd and mean measurements,
by **test subject** and by **activity type**

Top level, the script does the steps in the following order:  
1. Load and process test data  
2. Load and process train data  
3. Merge the data sets 4. Take the mean of the values of interest, by
test subject 5. Write the file into output\_ppl.txt

Step 1: Look at the Raw Data
----------------------------

*Note: The Inertial Signals data folder was not needed for this
assignment, and thus is ignored.*

    test = "../data/test"
    list.files("../data")

    ## [1] "activity_labels.txt" "features_info.txt"   "features.txt"       
    ## [4] "README.txt"          "test"                "train"

    list.files(test)

    ## [1] "Inertial Signals" "subject_test.txt" "X_test.txt"      
    ## [4] "y_test.txt"

Looking at the files, we see **generic** and **specific** files.

Generic files that we care about are:  
- `activity_labels.txt`: the 6 activities with text labels  
- `features.txt`: the 561 features calucated from XYZ data

The three files specific to test/train data, for test data are:  
- `subject_test.txt`: Subject 1 through 30, showing what subject was
tested  
- `X-test.txt`: Specific data points for the 561 features calcuations
performed  
- `Y-test.txt`: The label of the 6 tests

Step 2: Process the Test Data
-----------------------------

Let's get the test data and process it.

    # get the subject data 
    sub_t <- "../data/test/subject_test.txt"
    sub_tx <- "../data/test/X_test.txt"
    sub_ty <- "../data/test/Y_test.txt"

### Process the People Data

Read in the subject test people, 1 through 30.

    # subject is the subject (1:30) who performed the activity
    st <- read.table(sub_t,header=F,stringsAsFactors=F)
    # change the names to person
    names(st) <- "person"
    st$person <- factor(st$person)
    dim(st)

    ## [1] 2947    1

### Process the 561 Feature Data

    # analyzed data on activities/features performed
    stx <- read.table(sub_tx,header=F,stringsAsFactors=F)

### Process the Activity Data

    # labels of each type of activity (1:6)
    sty <- read.table(sub_ty,header=F,stringsAsFactors=T)
    names(sty) <- "activity"
    sty$activity <- factor(sty$activity)

    # names of the 1:6 activities
    alab <- "../data/activity_labels.txt"
    albl <- read.table(alab,header=F,stringsAsFactors=T)
    albl$V1 <- factor(albl$V1)

### Merge Data

Merging is a multi-step process, shown below. We merge the people to
their activity first, and then we further merge `sty_labeled_ppl` with
the 561 features.

    sty_labeled_ppl <- cbind(factor(sty$activity,labels=albl$V2),st)
    # TODO: remove activity column? 
    names(sty_labeled_ppl) <- c("activity","person")
    head(sty_labeled_ppl)

    ##   activity person
    ## 1 STANDING      2
    ## 2 STANDING      2
    ## 3 STANDING      2
    ## 4 STANDING      2
    ## 5 STANDING      2
    ## 6 STANDING      2

    # fully merged
    test_data_ppl <- cbind(sty_labeled_ppl,stx)
    dim(test_data_ppl)

    ## [1] 2947  563

    # load the features and label the columns 
    features <- "../data/features.txt"
    fts <- read.table(features,header=F, stringsAsFactors=F)

    # test_data_ppl[1:2] is activity # and person #
    # test_data_ppl[3:563] is the 561 set of features calculated
    # to make life easier, i'll make these column names be their names
    names(test_data_ppl)[3:563] <- fts$V2
    # sanity check output
    names(test_data_ppl)[c(1:3,560:563)]

    ## [1] "activity"                            
    ## [2] "person"                              
    ## [3] "tBodyAcc-mean()-X"                   
    ## [4] "angle(tBodyGyroJerkMean,gravityMean)"
    ## [5] "angle(X,gravityMean)"                
    ## [6] "angle(Y,gravityMean)"                
    ## [7] "angle(Z,gravityMean)"

### Use Grep() to Find Mean and SD Data

In the final step, we use `grep()` to find mean and standard dev data.

    new_names_ppl <- names(test_data_ppl)[grep("mean\\(|std\\(|activity|person",names(test_data_ppl))]
    # subset the test data with the new, grepped colnames
    test_data_complete_ppl <- test_data_ppl[,new_names_ppl]

    # sanity test
    names(test_data_complete_ppl)

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

Step 3: Process the Train Data
------------------------------

This is the same as **step 2**, except for train data. Only the final
size of the data frame is displayed.

    ## [1] 7352  563

Step 3: Merge Test and Train, Get Output Data
---------------------------------------------

Now that we have cleaned up our data, let's merge it one more time into
`complete_data_set_ppl`. Then we'll use aggregate() to aggregate all
data by `activity` and by `person`, and use the mean() function to take
the average of each feature **by** activtity **and** person. The output
will be 180 rows (30 people, 6 activities) by 68 columns (activity,
person, and 66 standard dev or mean features).

    complete_data_set_ppl <- rbind(test_data_complete_ppl,train_data_complete_ppl)
    ## now data is "cleaned up" 

    # average all columns
    # by activity and act_name, which are the same
    ans_ppl <- aggregate(.~activity+person,data=complete_data_set_ppl,FUN=mean)
    dim(ans_ppl)

    ## [1] 180  68

    ans_ppl[1:3,1:4]

    ##             activity person tBodyAcc-mean()-X tBodyAcc-mean()-Y
    ## 1            WALKING      2         0.2764266       -0.01859492
    ## 2   WALKING_UPSTAIRS      2         0.2471648       -0.02141211
    ## 3 WALKING_DOWNSTAIRS      2         0.2776153       -0.02266142

    # write table
    # http://www.statmethods.net/input/exportingdata.html
    write.table(ans_ppl, "output_ppl.txt",sep="\t",row.names=FALSE)
