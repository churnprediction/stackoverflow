from sklearn import *
from classify_utils import *
from plot_decision_tree import *
import sys
#Get the data

X, y = getXyFromCsv('data/y_X_churn_time_T_' + sys.argv[1] + '.csv', fillMissingWith0=True)

linsvm = LinearSVC()
dtree = DecisionTreeClassifier(min_samples_leaf=500)  
print "Number of features", shape(X)
print performClassification(X, y, linsvm, 'LinSVC', True, scaleX=True)

print "All Done!! Have a great day"
