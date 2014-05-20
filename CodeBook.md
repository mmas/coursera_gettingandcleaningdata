#Data dictionary - Human Activity Recognition Using Smartphones 

The dataset corresponds with the average of signals collected from the accelerometer of a smartphone meanwhile the user is doing 6 different activities in 30 subjects. The dataset contains 130 rows and 88 variables.

##Original data 
Original data taken from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Data transformation
Training and testing data from the original dataset have been merged.
Only the mean and the standard deviation of the signals from the original data have been taken in account and the different measurements per subject and activity have been simplified by its average.

##Variables
Variables correspond with the different signals mean and standard deviation from the original data except:

activity - *Name of the activitiy. 6 different activities in the study*

subject - *Number of the subject. [1-30]*