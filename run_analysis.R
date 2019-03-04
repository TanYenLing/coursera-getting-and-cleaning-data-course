# 1 Load the activity labels ----
dir <- paste0(getwd())
activity_labels <- read.table("activity_labels.txt")

# 2 Load the feature labels ----
features <- read.table("features.txt")
features$V2 <- gsub("[-()]", " ", features[, 2])

# 3.1 Load the training sets - subject_train ----
dir <- paste0(getwd(), "/train/")
subject_train <- read.table(paste0(dir, "subject_train.txt"))
names(subject_train) <- "subject"

# 3.2 Load the training sets - X_train ----
X_train <- read.table(paste0(dir, "X_train.txt"))
mean_std_col <- grep(".*mean.*|.*std.*", features$V2)
X_train <- X_train[, mean_std_col]
colnames(X_train) <- features[mean_std_col, 2]

# 3.3 Load the training sets - y_train ----
y_train <- read.table(paste0(dir, "y_train.txt"))
y_train <- as.data.frame(activity_labels[y_train$V1, 2])
names(y_train) <- "activity"

# 3.4 Merge the training sets - y_train, subject_train & X_train ----
train_data <- cbind(y_train, subject_train, X_train)

# 4.1 Load the test sets - subject_test ----
dir <- paste0(getwd(), "/test/")
subject_test <- read.table(paste0(dir, "subject_test.txt"))
names(subject_test) <- "subject"

# 4.2 Load the test sets - X_test ----
X_test <- read.table(paste0(dir, "X_test.txt"))
mean_std_col <- grep(".*mean.*|.*std.*", features$V2)
X_test <- X_test[, mean_std_col]
colnames(X_test) <- features[mean_std_col, 2]

# 4.3 Load the test sets - y_test ----
y_test <- read.table(paste0(dir, "y_test.txt"))
y_test <- as.data.frame(activity_labels[y_test$V1, 2])
names(y_test) <- "activity"

# 4.4 Merge the test sets - y_test, subject_test & X_test ----
test_data <- cbind(y_test, subject_test, X_test)

# 5 Merge the training and test datasets ----
overall_data <- rbind(train_data, test_data)

# 6.1 Aggregate the data by the average of each activity and each subject ----
tidy_data <- aggregate(overall_data, 
                       list(activity = overall_data$activity,
                            subject = overall_data$subject), 
                       mean, 
                       na.rm = TRUE, 
                       na.action = na.omit)

# 6.2 Remove the aggregate of activity and subject as those have no meaning ----
tidy_data[, 3:4] <- NULL

# 7 Write to .txt file ----
write.table(tidy_data, 
            "tidy_data.txt", 
            sep = "\t", 
            row.names = FALSE)
