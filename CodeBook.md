"run_analysis.R" loads the feature vectors corresponding to the means and standard deviations of each measurement from the training and test data files and labels the columns using the feature names from "features.txt"

The subject data is then read in from "subject_test.txt" and "subject_train.txt" along with the labels from "y_test.txt" and "y_train.txt". This data is then added to the data frame.

The activity factors are labelled using the labels found in "activity_labels.txt"

A new grouped data frame is then produced from the original one by aggregating by "Activity" and "Subject", taking the mean values of the other features.

The column names are then corrected to make them clearer and this new tidy dataset is printed to "tidydata.txt"

Variables
=========

"Subject": The subject ID number.
"Activity": The activity being performed.

The other variables are described in the "README.txt" of the UCI HAR Dataset.

Here the values have been averaged over the activity and subject values as described above.