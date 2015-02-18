## Getting-and-Cleaning-Data-Course-Project
#

###Project Goal

The goal this project is to get the student to demonstrate ability to collect, work with, and clean a data set and prepare tidy data that can be used for later analysis. 
### Submission Requirements
1. **Tidy data set** which contains the average of each variable for each activity and each subject across the training and test datasets.
2. **Link to a Github repository** with your script for performing the analysis. 
3. A **code book** (_CodeBook.md_) that describes the variables, the data, and any transformations or work performed to clean up the data.

###Approach
. **_runAnalysis.R_**  **follows a sequential approach to accomplish the desired goal of creating a tidy data set**

* **Get Feature Labels**
 * **source _features.txt_**
* **Get Activity Labels**
 * **source _activity labels.txt_** 
* **Filter and Clean Feature Labels**
 *  **Get the Mean and Standard Deviation Columns**
 *  **Clean the column labels, removing _ and () and convert to CamelCase**
* **Get Training Data**
 * **feature measurements:  _train/X train.txt_** 
 * **training subjects: _train/subject train.txt_**
 * **training activity index: _train/y train.txt_**
* **Select Mean and Std Columns**
 * **Rename the columns based using cleaned feature labels from step above.** 
* **Bind the X, Y and Subject Data frames**
* **Add the Activity Label Column and drop the Activity.ID column from the bound data frame**
* **Test Data: Repeat above Get, Select, Bind and Add Activity Label steps for the test data** _**(from /test sub folder)**_
* **Create a combined test and train data frame** _**(uci.har.data)**_
*  **Melt the data frame to create a Measure column and move feature measures into rows**
*  **Group the data by Subject, Activity and Measure**
*  **Summarize each variable(using mean) to get the tidy summary data**
*  **Finally write the data into an output file**
 
###Assumptions
* **The UCI Dataset is available in the current working directory and has the original folder structure**
* **The output file can be written to the current working directory** 

