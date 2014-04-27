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
F <- t(F)
F <- F[2,]
L <- t(L)
L <- L[2,]
y <- factor(y,
                    levels = c(1,2,3,4,5,6),
                    labels = L )
t <- cbind(s,y)

