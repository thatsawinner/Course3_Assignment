## Building a data set.

### Source Data
Data is located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Information about the data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Data Set Information
Please read README.txt in the data download for information on the raw data.  Asummary of the raw data is as folows:
The data is the results of experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### Modifications
I have the combined the training and test in to a master data.  In addition, I have merged the Subjects and the Activity of each record in to the master data set.  In the master data I have labeled the Activity numeric value by its text value to make it readable.  The transofrmation is as follows:
Activity ID	Activity Description
1		WALKING
2		WALKING_UPSTAIRS
3		WALKING_DOWNSTAIRS
4		SITTING
5		STANDING
6		LAYING

In addition, I have turned the acronyms in the variable names of the data in to readable names.  I have used the information in the README.txt and features_info.txt files to transform the names.

### Calculation
Once the data set is built, the script calculates the mean of every Mean and Standard Deviation variable in the data set by Subject and Activity.  The results of this calculation are saved in the working directory as tidy.txt.