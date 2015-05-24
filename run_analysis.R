
# let's view the files
# in my case, everything is in the data folder

list.files()
test = "data/test"
list.files(test)

# get the subject data 
sub_t <- "data/test/subject_test.txt"
sub_tx <- "data/test/X_test.txt"
sub_ty <- "data/test/Y_test.txt"

# subject is the subject (1:30) who performed the activity
st <- read.table(sub_t,header=F,stringsAsFactors=F)
# change the names to person
names(st) <- "person"


# analyzed data on activities performed
stx <- read.table(sub_tx,header=F,stringsAsFactors=F)


# labels of each type of activity (1:6)
sty <- read.table(sub_ty,header=F,stringsAsFactors=T)
names(sty) <- "activity"
sty$activity <- factor(sty$activity)

# names of the 1:6 activities
alab <- "data/activity_labels.txt"
albl <- read.table(alab,header=F,stringsAsFactors=T)
albl$V1 <- factor(albl$V1)

# sty and albl need to match up
# sty_labeled has col1 as activity, col2 as activity label
# factors: http://www.ats.ucla.edu/stat/r/modules/factor_variables.htm
sty_labeled <- cbind(sty,factor(sty$activity,labels=albl$V2))
names(sty_labeled) <- c("activity","act_name")
sty_labeled

# Let's pause to look at our data
# activty number is the first column, activity name is the row header 
head(sty_labeled)

# for now, for ease of use
# we are going to bind the sty_labeled (activity # with activity name)
# to the test data stx of 561 features calcuated
# later we will filter it down to sd/mean columns
# cbind sty_labeled to stx
test_data <- cbind(sty_labeled,stx)
dim(test_data)

# load the features
features <- "data/features.txt"
fts <- read.table(features,header=F, stringsAsFactors=F)
fts 

# test_data[1:2] is activity # and activity name
# test_data[3:563] is the 561 set of features calculated
# to make life easier, i'll make these column names be their names
names(test_data)[3:563] <- fts$V2
# sanity check output
names(test_data)


# next, we need to get colnames with "mean" or "std" in the name
# let's use grep() for this 

# http://www.regexr.com/
# test regexpressions, how many have mean,std? 
# also include colnames activity and act_mean
length(grep("mean\\(|std\\(|activity|act_name",names(test_data)))

# test what's not in a parentheses to make sure I didn't miss anything
# and indeed there is no mean/std value here
names(test_data)[-(grep("\\(",names(test_data)))]


# cut down the columns in test_data 
new_names <- names(test_data)[grep("mean\\(|std\\(|activity|act_name",names(test_data))]

# subset the test data with the new, grepped colnames
test_data_complete <- test_data[,new_names]

# sanity test
names(test_data_complete)

########### same exact thing for the train data!
# file reads
sub_tr <- "data/train/subject_train.txt"
sub_trx <- "data/train/X_train.txt"
sub_try <- "data/train/Y_train.txt"

str <- read.table(sub_tr,header=F,stringsAsFactors=F)
names(str) <- "person"

strx <- read.table(sub_trx,header=F,stringsAsFactors=F)
dim(strx)

# labels of each type of activity (1:6)
stry <- read.table(sub_try,header=F,stringsAsFactors=T)
dim(stry)
names(stry) <-"activity"
stry$activity <- factor(stry$activity)

# stry and albl must match up
stry_labeled <- cbind(stry,factor(stry$activity,labels=albl$V2))
names(stry_labeled) <- c("activity","act_name")
table(stry_labeled)

train_data <- cbind(stry_labeled,strx)
dim(train_data)

# apply fts to names
names(train_data)[-(1:2)] <- fts$V2

# now train data has properly labeled columns and rows

train_data_complete <- train_data[,new_names]
##########

## test_data_complete and train_data_complete need to be merged
# question: should we have a test/train column marker? 

test_data_complete$datatype <- "test"
train_data_complete$datatype <- "train"

complete_data_set <- rbind(test_data_complete,train_data_complete)
dim(complete_data_set)

## now data is "cleaned up" 

# average all columns
# by activity and act_name, which are the same
# remove the datatype (test/train) 
ans <- aggregate(. ~ act_name+activity,data=complete_data_set[-69],FUN=mean)
dim(ans)
head(ans)
# write table
# http://www.statmethods.net/input/exportingdata.html
write.table(ans, "output.txt",sep="\t",row.names=FALSE)

