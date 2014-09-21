library(dplyr)
library(plyr)

### ----------------- READ IN SOURCE DATAFILES -------------------------###

# Read in File Listing Features
features <- read.table ("./UCI HAR Dataset/features.txt", quote="\"")

# Read in the recorded measurements for training Set
X_train <- read.table ("./UCI HAR Dataset/train/X_train.txt", quote="\"")

# Read in the file listing the activity being measured for each record in the 
# training set
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")

# Read in the file listing the subject performing activity being measured in 
# training set
subject_train <- read.table ("./UCI HAR Dataset/train/subject_train.txt"
                             , quote="\"")

# Read in recorded measurements for test Set
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")

# Read in the file listing theactivity being measured for each record in the 
# training set
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")

# Read in the file listing the subject performing activity for each record in 
# test set
subject_test <- read.table ("./UCI HAR Dataset/test/subject_test.txt", 
                            quote="\"")


###-------------------- MERGE TRAINING and TEST DATA -------------------###

# Merge Training and Test Measurement Data
measurement_data <-rbind(X_train,X_test)
rm(X_test, X_train)

# Merge the activity information of the training and test data
measurement_activity <- rbind(y_train, y_test)
rm(y_train, y_test)

# Merge the subject information of the training and test data 
measurement_subject <- rbind(subject_train, subject_test)
rm(subject_train, subject_test)

# Provide descriptive variable names to the columns of the measurement_data
names(measurement_data) <- as.array(features[,2])

##------Extract only the measurements on mean and standard deviation ----###

# Firstly need Identify the columns of the measurements dataset that is related 
# to standard deviation and mean ...
features_sd_mean_index <- c(grep("mean()",as.array(features[,2]),fixed=TRUE),
                    grep("std()",as.array(features[,2]), fixed=TRUE))

rm(features)
# .. then we use the index above to subset the original measure_data and extract
# out only the columns that relate to standard deviation and mean.

measurement_sd_mean_data <- measurement_data[,features_sd_mean_index]
rm(features_sd_mean_index)
rm(measurement_data)

### - Add Descriptive Column that articulates the Activity being measured - ### 

# Read in Source Activity Labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                              quote="\"")

# Convert Activity Codes to Activity Names
measurement_activity_name <- activity_labels[match(measurement_activity$V1, 
                                                   activity_labels[,1]),2]

rm(activity_labels)
rm(measurement_activity)
# Add Activity Names to the sub-setted measurement data
measurement_sd_mean_data <- cbind(measurement_activity_name , 
                                  measurement_sd_mean_data)
names(measurement_sd_mean_data)[1] <- "activity"
rm(measurement_activity_name)

### -------------Add the the subject column to the data -------------------- ### 

# Add Subject ID to the sub-setted measurement data
measurement_sd_mean_data <- cbind(measurement_subject , 
                                  measurement_sd_mean_data)
names(measurement_sd_mean_data)[1] <- "subject_id"
rm(measurement_subject)

### -------- Cleanup the variable names to make it more readable ------------###

# Removing all '()'
names(measurement_sd_mean_data) <- gsub("()","",names(measurement_sd_mean_data),
                                        fixed=TRUE)

# Changing all '-' to '_' as it is more readable
names(measurement_sd_mean_data) <- gsub("-","_",names(measurement_sd_mean_data),
                                        fixed=TRUE)

# Fix minor issue in souce data
names(measurement_sd_mean_data) <- gsub("fBodyBody","fBody",
                                        names(measurement_sd_mean_data),
                                        fixed=TRUE)

### ----------------------------- Tidy the Data -----------------------------###

# Tidy up the data. Convert the 66 'Feature' Columns into key value pairs.
# Treating each of the 66 features as a variable a type of measurement that 
# therefore needs to be in it's own row.

tidy_detail_data <- gather(measurement_sd_mean_data,feature_type, feature_value, 
                           tBodyAcc_mean_X:fBodyGyroJerkMag_std)

rm(measurement_sd_mean_data)

### ------------------------Group and Calculate Mean -----------------------###

# Group the tidied up data by the subject, activity and feature so that the 
# mean can be calculated
group_tidy_detail_data <- group_by(tidy_detail_data,subject_id,activity,
                                   feature_type)
rm(tidy_detail_data)

# Calculate the mean of each grouped set of data
tidy_summarised_data <- summarise(group_tidy_detail_data, 
                                  feature_mean = mean(feature_value))

rm(group_tidy_detail_data)

### -------------------Write the tidied data to file ------------------------###

write.table(tidy_summarised_data,file = "./output.txt",row.name=FALSE)
rm(tidy_summarised_data)