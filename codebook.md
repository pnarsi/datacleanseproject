Codebook
========================================================

== RAW Source Data == 


Original Source Data Details available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


== Processed data == 

The tidied data has the following variables 

1. **`subject_id`** : the unique identifier for ther subject performing the activity who's feature is being measured. This ranges from 1 to 30

2. **`activity`** : the activity being performed by the subject when a particular feature variable was being measured. There are six different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

3. **`feature_type`** : the specific feature being measured. There are 66 different features types which are listed as follows. The original feature dataset had 33 different types of signals which had 13 types of measurements. This tidy dataset keeps the same number of signals by reduces the measurements to only `mean` and `standand deviation`    
*..tBodyAcc_mean_X
*..tBodyAcc_mean_Y
*..tBodyAcc_mean_Z
*..tGravityAcc_mean_X
*..tGravityAcc_mean_Y
*..tGravityAcc_mean_Z
*..tBodyAccJerk_mean_X
*..tBodyAccJerk_mean_Y
*..tBodyAccJerk_mean_Z
*..tBodyGyro_mean_X
*..tBodyGyro_mean_Y
*..tBodyGyro_mean_Z
*..tBodyGyroJerk_mean_X
*..tBodyGyroJerk_mean_Y
*..tBodyGyroJerk_mean_Z
*..tBodyAccMag_mean
*..tGravityAccMag_mean
tBodyAccJerkMag_mean
tBodyGyroMag_mean
tBodyGyroJerkMag_mean
fBodyAcc_mean_X
fBodyAcc_mean_Y
fBodyAcc_mean_Z
fBodyAccJerk_mean_X
fBodyAccJerk_mean_Y
fBodyAccJerk_mean_Z
fBodyGyro_mean_X
fBodyGyro_mean_Y
fBodyGyro_mean_Z
fBodyAccMag_mean
*..fBodyBodyAccJerkMag_mean
*..fBodyBodyGyroMag_mean
*..fBodyBodyGyroJerkMag_mean
*..tBodyAcc_std_X
tBodyAcc_std_Y
tBodyAcc_std_Z
tGravityAcc_std_X
tGravityAcc_std_Y
tGravityAcc_std_Z
tBodyAccJerk_std_X
tBodyAccJerk_std_Y
tBodyAccJerk_std_Z
tBodyGyro_std_X
tBodyGyro_std_Y
tBodyGyro_std_Z
tBodyGyroJerk_std_X
tBodyGyroJerk_std_Y
*..tBodyGyroJerk_std_Z
*..tBodyAccMag_std
*..tGravityAccMag_std
*..tBodyAccJerkMag_std
*..tBodyGyroMag_std
*..tBodyGyroJerkMag_std
*..fBodyAcc_std_X
*..fBodyAcc_std_Y
*..fBodyAcc_std_Z
*..fBodyAccJerk_std_X
*..fBodyAccJerk_std_Y
*..fBodyAccJerk_std_Z
*..fBodyGyro_std_X
*..fBodyGyro_std_Y
*..fBodyGyro_std_Z
*..fBodyAccMag_std
*..fBodyAccJerkMag_std
*..fBodyGyroMag_std
*..fBodyGyroJerkMag_std




4. **`Mean`** : the mean of all measurements related to records that have the specific combination 
of `subject_id`, `activity` and `feature_type`