-----------------------------------------------------------------
#User Churn in Focused Q&A Sites: Characterizations and Prediction
-----------------------------------------------------------------


##Steps to generate the data, analytical plots, and to perform classification tasks 

Skip step 1-4 if you don't intend to generate and clean the data. 

Warning: Without enough tuning of tables for performance, it might take several days to generate the data

---------------------------
##Generating the data
---------------------------
1. Download the 2008-2012 data from http://blog.stackoverflow.com/category/cc-wiki-dump/
2. Convert all the XMLs into SQL using the instructions provided in http://terokarvinen.com/2012/reading-stackoverflow-xml-dump-to-mysql-database
3. Install MySQL and create/insert all the data into a DB 
4. Go to churn/sql and execute the SQL files in this order - a)churn_create.sql  b)procedures.sql c)all except churn_time_update_features.sql c) churn_time_update_features.sql
5. Execute get_classifier_data.sh

---------------------------
##Generating plots
--------------------------
6. To generate plots, go to churn/plot_draw directory and run the corresponding python script. Python scripts are named after the corresponding feature (feat_feature_name.py)

------------------------------
##Running classification tasks
------------------------------
7. To get classification results based on the number of posts (k), run python churn_classify_driver_K.py
8. To get classification results based on the number of observation days (T), run python churn_classify_driver_T.py

Note: Classification tasks are based on 10 fold nested cross validation, using grid search to search for optimum hyper-parameters.
These scripts iterate over the four classifiers - Linear SVM, SVM with RBF kernel, Logistic Regression, and Decision Tree Classifier
