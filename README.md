
For this project, we have the script used to run the analysis to obtain the final tidy dataset as well as the CodeBook.

I loaded the following datasets into R for the analysis:
- activity labels
- features
- subject_train/test
- x_train/test _ y_train/test

Data transformation involved:
- Matched the data in the "X_train/test" to the corresponding variables in "features" that contain the words mean or std.
- Matched the numbers in "y_train/test" to the activity names in "activity labels"
- Merged the training datasets "y_train", "subject_train", "X_train" into "train_data"
- Merged the test datasets "y_test", "subject_test", "X_test" into "test_data"
- Merged the training and test datasets into "overall_data"
- Aggregated the data by the average of each activity and each subject
- Removed the aggregate of activity and subject as those have no meaning
- Wrote the new dataset into the "tidy_data" txt file

Thank you for reading :)
