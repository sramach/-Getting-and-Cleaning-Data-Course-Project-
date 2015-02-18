##Code book for the "Getting and Cleaning Data" course project

###Data Source

* **The data linked to from the course website represents data collected from the accelerometers from the Samsung Galaxy S smartphone.**
* **A full description is available at the [site](
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) where the data was obtained.**
* **The data for this project can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)**

###Data Files relevant to this Project

**While the complete dataset contains details of every measurement the project requirements call for us to work on the measurements within the training and test datasets. The following files are relevant to this project:**

* _**features.txt**_ **: List of all features(measurements).** 
* _**activity___labels.txt**_: **Activity Labels and the corresponding Index**
* _**train/X___train.txt**_: **Training set measurements of the 561 features**
* _**train/y___train.txt**_: **Identifies the activity performed corresponding to each observation row in X**
* _**train/subject___train.txt**_: **Identifies the subject for each observation row in X**
* _**test/X___train.txt**_: **Test set measurements of the 561 features**
* _**test/y___train.txt**_: **Identifies the activity performed corresponding to each observation row in X**
* _**test/subject___train.txt**_: **Identifies the subject for each observation row in X**

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
 * **feature measurements:  _train/X___train.txt_** 
 * **training subjects: _train/subject___train.txt_**
 * **training activity index: _train/y___train.txt_**
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

###Implementation Details

* **This implementation requires the reshape2, dplyr and string r packages**
* **The training and test datasets are read individually and then merged at a later step**
* **The full list of feature/column names have a number of duplicates which can result in challenges while filtering etc. To circumvent this issue I generated a unique list of column names** _**(feature.data.AltCol)_** **to be used while reading the X data. These columns names are later replaced with the cleaned up column names**
* **Feature labels are cleaned up to remove the _ ,( and ) characters and also converted to CamelCase**
* **To execute _runAnalysis.R_ please make sure the current working directory contains the unzipped _UCI HAR Dataset_ folder**.
* **The tidy data output file will be written to the current working folder**

