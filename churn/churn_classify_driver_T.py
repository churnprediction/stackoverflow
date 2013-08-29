from sklearn import *
from classify_utils import *
from plot_decision_tree import *
import sys
#Get the data

for clf in [(SVC(), 'SVC'), (DecisionTreeClassifier(), 'DT')]:

    for T in [7, 15, 30]:
        print "T: ",T
        X, y = getXyFromCsv('data/y_X_churn_time_T_' + str(T) + '.csv', fillMissingWith0=True)
        print "Number of features", shape(X)
        print clf
        print performClassification(X, y, clf[0], clf[1], True, scaleX=True)

print "All Done!! Have a great day"
