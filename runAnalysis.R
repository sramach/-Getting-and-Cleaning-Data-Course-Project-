
## Define Required Packages

require(dplyr)
require(stringr)
require(reshape2)

## Read Feature Data

feature.data <- read.table("UCI Har DataSet/features.txt",header=FALSE,col.names= c("ID","Feature"), colClasses=c("numeric","character"))
feature.data <- mutate(feature.data, AltCol = paste("V",ID,sep=""))


## Read Activity Labels 

activity.data <- read.table("UCI Har DataSet/activity_labels.txt",header=FALSE,col.names= c("ID","Activity"), colClasses=c("numeric","character"))

## Build a subset of features for just mean and std measures (features.to.include)
## pass it through a sequence of replacements to build final column names (feature.clean.names)

feature.to.include  <- filter(feature.data, str_detect(Feature, c("mean")) |  str_detect(Feature, c("std")) )
feature.clean.names <- gsub("mean","Mean",feature.to.include$Feature)
feature.clean.names <- gsub("std","Std",feature.clean.names)
feature.clean.names <- gsub("[()-]", "",feature.clean.names)


## Read the training data
## column names come from feature data

train.data.X <- read.table("UCI Har DataSet/train/X_train.txt", header=FALSE,  col.names = feature.data$AltCol, check.names=FALSE)

## filter and select just mean and standard deviation columns

train.data.X.f <- select(train.data.X, feature.to.include$ID)

## Re-establish the correct column names

names(train.data.X.f) <- feature.clean.names

## Read the Activity ID for each record

train.data.Y <- read.table("UCI Har DataSet/train/y_train.txt", header=FALSE,  col.names = c("Activity ID"))

## Read the subject ID for each record

train.data.subject <- read.table("UCI Har DataSet/train/subject_train.txt", header=FALSE, col.names = c("Subject"))

## use cbind to paste the 3 data frames together

train.data <- cbind(train.data.subject,train.data.Y,train.data.X.f)

## merge the Activity Name and drop the Activity ID column

train.data.final <- select(merge(train.data,activity.data, by.x="Activity.ID" ,  by.y="ID"),  -(Activity.ID))


## Read the test data
## column names come from feature data

test.data.X <- read.table("UCI Har DataSet/test/X_test.txt", header=FALSE,  col.names = feature.data$AltCol, check.names=FALSE)

## filter and select mean and std columns using column index

test.data.X.f <- select(test.data.X, feature.to.include$ID)

## Re-establish the correct column names, eliminate "(", "-", and ")" from original Feature string to make it more readable

names(test.data.X.f) <- feature.clean.names

## Read the Activity ID for each record

test.data.Y <- read.csv("UCI Har DataSet/test/y_test.txt", header=FALSE, sep= "", col.names = c("Activity ID"))

## Read the subject ID for each record

test.data.subject <- read.csv("UCI Har DataSet/test/subject_test.txt", header=FALSE, sep= "", col.names = c("Subject"))

## use cbind to paste the 3 test data frames together

test.data <- cbind(test.data.subject,test.data.Y,test.data.X.f)

## merge the Activity Name and drop the Activity ID column

test.data.final <- select(merge(test.data,activity.data, by.x="Activity.ID" ,  by.y="ID"),  -(Activity.ID))


## Get the combined test and train data using rowbind

uci.har.data <- rbind(train.data.final, test.data.final)



## melt the data set and turn measures into columns

uci.har.melted <- melt(uci.har.data,id=c("Subject","Activity"), measure.vars = feature.clean.names, variable.name="Measure", value.name = "Value") 


## group by Activity, Subject, Measure 

uci.subject.activity <- group_by(uci.har.melted, Subject, Activity, Measure)


## summarize each variable(using mean) to get the tidy summary data

uci.har.summary.clean <- summarise_each(uci.subject.activity, funs(mean))

## write the data into the current working directory (same as runAnalysis.R)

write.table(uci.har.summary.clean, file="project_tidy_data.txt",row.names = FALSE, quote=FALSE)
