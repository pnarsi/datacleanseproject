datacleanseproject
==================


### Description  

This README file describes the run-analysis.R which contains code to convert
the original **Human Activity Recognition** dataset  into a tidy independant dataset that provides the mean
of each variable being measured for each activity and for each subject.

The original dataset is available from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

and is described at: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### How it Works

The ANALYSIS FILE assumes that the source files for the data have been extracted
into the working directory of the script and that the README.TXT file of the source data is available at
`./UCI HAR Dataset/README.txt`

Furthermore the following R packages need to be installed:

  * `dplyr`
  * `tidyr`

The script can be run using the following command

`Rscript run_analysis.R`


### Opening the Output File

`read.table(*<filelocation>*, header=T, quote="\"")`


### ANALYSIS FILE Description  

At a high level, the analysis file performs the following actions in order

1. Read in the source data files for both the training and test datasets. Each 
dataset includes a file that has the measurements, another file describing 
the activity the measurement is recording and third file that details the 
subject performing the action.

2. The training and test data are merged into one.

3. The standard deviation and mean columns of the data are extracted and the 
rest of the data is discarded. It is assumed that only measurement variables 
(aka features) that have `sd()` and `mean()` in the name are of interest as these 
have been called out explicitly as the *Standard Deviation* and the *Mean Value* 
in the feature_info.txt of the original 
dataset.

4. The data is then augmented with the details of the activity being recorded. 
The original dataset uses factors with 6 values to record the activity being 
measured. The analyis converts the factor to a descriptive label before attaching
it to the dataset.

5. In the next step the subject details are added to the measurement as an 
additional column.

6. Minor cleanup is done with the variable names to make it more readable. 
Specifically all 'brackets' -`'()'` are removed from the name and all 'dashes' `'-'` are converted to 'underscores' `'_'`

7. The next step is to convert the short, wide dataset to a long, narrow one. As
per Hadley Wickhan's paper[1], *tidy data* is one where each variable forms a 
column and each observation forms a row. One can argue that the various 
'variables' in the original dataset are in reality part of a set of features that
can be measured. Therefore each of these feature variables should each be in 
it's own row [2]. The multiple columns are converted into row-value pairs using 
`tidtr::gather()`

8. This detailed tidy data is then groups by subject, activity and feature. 
The mean of each group is then calculated.

9. In the final step, the tidied, summarised data is written to file.



### References

 * [1] Hadley Wickham Tiday, "Tidy Data", Journal of Statistical Software, http://vita.had.co.nz/papers/tidy-data.pdf
 * [2] David Hood, Forum Post on Long Data, Wide Data, and Tidy Data for the Assignment https://class.coursera.org/getdata-007/forum/thread?thread_id=214

