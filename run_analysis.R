## First Build up file header
features <- read.table("./data/features.txt")

#Transpose File to generate header
features <- t(features[2])

#Make index for selecting mean and std
meanCols <- grep("mean",features)
stdCols <- grep("std",features)

#Build Header
header <- cbind("Subject" ,"Activity", t(features[,meanCols]), t(features[,stdCols]) )

#Clean up header, not sure what the expected end result from coursera was
header <- tolower(header) #all lower case
header <- gsub("-","",header) #Remove - signs
header <- gsub("[()]","",header) #Remove () signs
header <- gsub("bodybody","body",header) #Typo in column header
# Rename time and frequency
header <- gsub("fbody","averagefrequencybody",header) 
header <- gsub("tbody","averagetimebody",header)



## Read in activity_labels

activity_labels <-  read.table("./data/activity_labels.txt")


## Read in test files first

subjects <- read.table("./data/test/subject_test.txt")
x_test <-read.table("./data/test/X_test.txt")
y_test <- read.table("./data/test/Y_test.txt")

## add rows from train files using rbind

subjects <- rbind(subjects, read.table("./data/train/subject_train.txt") )
x_test <-rbind(x_test,read.table("./data/train/X_train.txt"))
y_test <- rbind(y_test,read.table("./data/train/Y_train.txt"))


##Select only mean and std cols
x_test <- cbind(x_test[,meanCols] ,x_test[,stdCols])

## then make one large dataframe by using cbind
theOne <- cbind(subjects,y_test)
theOne <- cbind(theOne,x_test)

#Name the columns
names(theOne)<-header

## Now take the mean of all the measurements
theOne<- aggregate(theOne[,3:81],by=list(theOne$subject,theOne$activity),FUN=mean)

#Name the columns (the aggregate function makes group names)
names(theOne)<-header

## rename factor variable activity to text
theOne$activity<-factor(theOne$activity)
levels(theOne$activity) = t(activity_labels[2])

## Write the file to disk
write.table(theOne,"./data/UCI HAR Cleaned.txt",row.name=FALSE)
