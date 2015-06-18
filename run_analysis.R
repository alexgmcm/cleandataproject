#Merges the training and the test sets to create one data set.
#setwd("/home/alexgmcm/Documents/data/UCI HAR Dataset")
featTable<-read.table("./features.txt",stringsAsFactors = FALSE)
colInds<-grepl("-mean\\(\\)|-std\\(\\)",featTable$V2,fixed=FALSE)
#We only want to read in the mean() and std() results of each measurement
#Extracts only the measurements on the mean and standard deviation for each measurement.
colNums<-featTable$V1[colInds]
colVec<-c(rep("NULL",length(colInds)))
colVec[colInds]<-"numeric"
#Appropriately labels the data set with descriptive variable names. 
#Therefore we need to get the names for the colNames as well - use featTable
xTest<-read.table("./test/X_test.txt",colClasses=colVec,col.names=featTable$V2)
yTest<-read.table("./test/y_test.txt",col.names=c("Activity"),stringsAsFactors = FALSE)
subjTest<-read.table("./test/subject_test.txt")
xTest$Activity<-yTest[,1] #combine labels
xTest$Subject<-subjTest[,1]
#get training data
xTrain<-read.table("./train/X_train.txt",colClasses=colVec,col.names=featTable$V2)
yTrain<-read.table("./train/y_train.txt",col.names=c("Activity"),stringsAsFactors = FALSE)
subjTrain<-read.table("./train/subject_train.txt")
xTrain$Activity<-yTrain[,1] #combine labels
xTrain$Subject<-subjTrain[,1]
#combine train and test set
data<-rbind(xTest,xTrain)

#Uses descriptive activity names to name the activities in the data set
activityLabels<-read.table("./activity_labels.txt",stringsAsFactors = FALSE)
#data$Activity<-unlist(lapply(data$Activity,function(x) activityLabels[x,2]))
data$Activity<-factor(data$Activity,levels=as.character(activityLabels$V1),labels=activityLabels$V2)
data$Subject<-factor(data$Subject)
#From the data set in step 4, creates a second, independent tidy data set with the average
#of each variable for each activity and each subject.


groupedData<-aggregate(data[,!names(data) %in% c("Activity", "Subject")], list(data$Subject,data$Activity),mean)
names(groupedData)[1]<-"Subject"
names(groupedData)[2]<-"Activity"
names(groupedData)[c(-1,-2)]<-lapply(names(groupedData)[c(-1,-2)],function(x) paste0("GRPMEAN_",x))

write.table(groupedData,file="./tidydata.txt",row.names=FALSE)

#(Each variable you measure should be in one column, 
#Each different observation of that variable should be in a different row).