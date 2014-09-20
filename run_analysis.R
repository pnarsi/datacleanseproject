

# Read in File Listing Features
features <- read.table ("./UCI HAR Dataset/features.txt", quote="\"")

# Read in the subject performing activity being measured in training set
subject_train <- read.table ("./UCI HAR Dataset/train/subject_train.txt"
                             , quote="\"")

# Read in Measurements for training Set
X_train <- read.table ("./UCI HAR Dataset/train/X_train.txt", quote="\"")

# Read in activity being measured what is being measured for training set
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
   
# Read in subject performing activity for each measurement in test set
subject_test <- read.table ("./UCI HAR Dataset/test/subject_test.txt", 
                            quote="\"")

# Read in Measurements for test Set
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")

# Read in the activity being measured for training set
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")

# Start Step 1 - Merge Training and Test Data

# Merge Training and Test Measurement Data
measurement_data <-rbind(X_train,X_test)
rm(X_test, X_train)

# Add column description to dataset
names(measurement_data) <- as.array(features[,2])

# Merge the activity information of the training and test data
measurement_activity <- rbind(y_train, y_test)
rm(y_train, y_test)

# Merge the subject information of the training and test data 
measurement_subject <- rbind(subject_train, subject_test)
rm(subject_train, subject_test)

# End Step 1

# Start Step 2 - Extract only the measurements on mean and standard deviation 

# Identify the columns of the measturements dataset that is related to 
# standard deviation and mean
features_sd_mean_index <- c(grep("mean()",as.array(features[,2]),fixed=TRUE),
                    grep("std()",as.array(features[,2]), fixed=TRUE))

# Extract only the mean and the standard deviation

measurement_sd_mean_data <- measurement_data[,features_sd_mean_index]
rm(features_sd_mean_index)

# End Step 2

# Start Step 3 and 4 

# Read in Activity Labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                              quote="\"")

# Convert Activity Codes to Activity Names
measurement_activity_name <- activity_labels[match(measurement_activity$V1, 
                                                   activity_labels[,1]),2]

# Add Activity Names to the sub-setted measurement data
measurement_sd_mean_data <- cbind(measurement_activity_name , 
                                  measurement_sd_mean_data)
names(measurement_sd_mean_data)[1] <- "activity"

# Add Subject OD to the sub-setted measurement data
measurement_sd_mean_data <- cbind(measurement_subject , 
                                  measurement_sd_mean_data)
names(measurement_sd_mean_data)[1] <- "subject_id"
rm(measurement_subject)

# Cleanup feature name to make it more readable
names(measurement_sd_mean_data) <- gsub("()","",names(measurement_sd_mean_data),
                                        fixed=TRUE)
names(measurement_sd_mean_data) <- gsub("-","_",names(measurement_sd_mean_data),
                                        fixed=TRUE)

# Tidy up the data. Convert the 66 Feature Columns into key value pairs
tidy_detail_data <- gather(measurement_sd_mean_data,feature_type, feature_value, 
                           tBodyAcc_mean_X:fBodyBodyGyroJerkMag_std)

# Group the tidied up data by the subject, activity and feature
group_tidy_detail_data <- group_by(tidy_detail_data,subject_id,activity,
                                   feature_type)

# Calculate the mean of each grouped set of data
tidy_summarised_data <- summarise(group_tidy_detail_data, mean = mean(feature_value))


