# Set the working directory to UCI HAR Dataset Folder
# Install the reshape2 package for melt and cast functions
install.packages("reshape2")
library("reshape2")
# The features are read into F, the activity labels into L, then x, y and s are created after suitable merging of the training and testing data sets
F <- read.table("./features.txt",header=FALSE)
L <- read.table("./activity_labels.txt",header=FALSE)
s.test <- read.table("./test/subject_test.txt",header=FALSE)
x.test <- read.table("./test/X_test.txt",header=FALSE)
y.test <- read.table("./test/y_test.txt",header=FALSE)
s.train <- read.table("./train/subject_train.txt",header=FALSE)
x.train <- read.table("./train/X_train.txt",header=FALSE)
y.train <- read.table("./train/y_train.txt",header=FALSE)
s <- rbind(s.train,s.test)
x <- rbind(x.train,x.test)
y <- rbind(y.train,y.test)
y <- t(y)
F <- t(F)
F <- F[2,]
L <- t(L)
L <- L[2,]
y <- factor(y,levels = c(1,2,3,4,5,6),labels = L )
y <- cbind(s,y)
colnames(y) <- c("Subject_Number","Activity")
x <- rbind(x.train,x.test)
# The columns in x are named using the features vector F
colnames(x) <- F
x <- cbind(y,x)
# v is the vector that stores the columns with measurements of means and standard deviations
# v <- c(3:8,43:48,83:88,123:128,163:168,203:204,216:217,229:230,242:241,255:256,268:273,347:352,426:431,505:506,518:519,531:532,544:545)
# I have also removed meanFreq() as it is a weighted average and not a simple mean
v <- c(1,2,intersect(grep("mean()|std()",names(x)),grep("meanFreq()",names(x),invert=TRUE)))
# The desired output is x_out
x_out <- x[,v]
# Now we'll create the tinydata file which has the means of the mean() and std() variables over Subject_Number and Activity
x_melt <- melt(x_out,id=c("Subject_Number","Activity"))
x_cast <- dcast(x_melt, Subject_Number + Activity ~ variable,fun.aggregate=mean)
write.table(x_cast,"./tinydata_out.txt")
write.table(x_cast,"./tinydata_out_tabdelimited.txt",sep="\t")
# Now we'll create the tinydata file which has the means of all the variables over Subject_Number and Activity
x_melt <- melt(x,id=c("Subject_Number","Activity"))
x_cast <- dcast(x_melt, Subject_Number + Activity ~ variable,fun.aggregate=mean)
write.table(x_cast,"./tinydata_all.txt")
write.table(x_cast,"./tinydata_all_tabdelimited.txt",sep="\t")






