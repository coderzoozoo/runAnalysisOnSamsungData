Introduction
-------------

This file explain how run_analysis.R works. 


Details on run_analysis.R
-------------------------
1. The data is extracted from the following source in the .zip format: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Data is extracted into the working directory.
3. The script creates a new directory 'combined' in the working directory
4. A new directory structure is created under combined similar to that under train and test directories
5. The script creates two vetors for all the files under train and test directories. Data in all the test and train files is later merged and writtent to the files under the combined directory. The files under directory follow the same naming rules as that followed by the files under test and train directories.
6. Now, the feature vector is created that defines the column names of all the columns in the X_combined.txt, which contains the merged data for X_test.txt and X_train.txt.
7. X_combined is read.
8. Column names are applied to the table read from X_combined.txt.
9. All the columns that measure mean or standard deviation are extracted in a new dataset.
10. Mean is calculated over all the colums in this dataset and written to tidydata.txt files under the combined directory.
