## This script cleans up the data from the following sources
##actual source
##http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##project data
##https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##After downloading the files and converting to csv format, the following lines read
##the important files into R


xtrain<-read.csv("c:/misc/data science/uci/train/X_train.csv",header=FALSE)
ytrain<-read.csv("c:/misc/data science/uci/train/y_train.csv",header=FALSE)
subtrain<-read.csv("c:/misc/data science/uci/train/subject_train.csv",header=FALSE)
subtest<-read.csv("c:/misc/data science/uci/test/subject_test.csv",header=FALSE)
ytest<-read.csv("c:/misc/data science/uci/test/y_test.csv",header=FALSE)
xtest<-read.csv("c:/misc/data science/uci/test/X_test.csv",header=FALSE)
features1<-read.delim("c:/misc/data science/uci/features.txt",header=FALSE)

##Rename the columns of the xtrain and xtest data frames using the features.txt names
realnames<-1:561
realnames<-features1[,1]

colnames(xtrain)<-realnames
colnames(xtest)<-realnames

## rename the ytrain,ytest,subtrain, and subtest columns to read clearer
names(ytrain)<-"activityLabel"
names(ytest)<-"activityLabel"
names(subtrain)<-"subjectTrain"
names(subtest)<-"subjectTest"


##Using, regular expressions, extract the columns that give the mean (9 columns)
## and standard deviations (9 columns) of each measurables. 
xtrain2<-xtrain[,grep("mean\\()$|std\\()$",features1[,1])]
xtest2<-xtest[,grep("mean\\()$|std\\()$",features1[,1])]

##Read the file containing the activity labels
actlab<-read.delim("c:/misc/data science/uci/activity_labels.txt",header=FALSE)
actlab<-as.vector(actlab[,1])

##Use regular expressions to replace the numbers in ytrain(and ytest) with appropriate
## values as given in actlab

for(i in 1:6){
	karakter<-as.character(i)
	ytrain[,1]<-sub(karakter,actlab[i],ytrain[,1])
	ytest[,1]<-sub(karakter,actlab[i],ytest[,1])
	}

##Merge the xtrain data frame with the subject and ytrain variables. Repeat for the test variables
 Mergedtr1<-data.frame(subtrain,ytrain,xtrain2)
 Mergedtest1<-data.frame(subtest,ytest,xtest2)

##Merge the test and train data using the ytest and ytrain variables respectivel.

merged_data<-merge(Mergedtr1,Mergedtest1,by.x="subjectTrain",by.y="subjectTest",all=TRUE)
