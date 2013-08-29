from sklearn import *
from classify_utils import *
from plot_decision_tree import *
import sys
import itertools
#Get the data

for clf in [(LogisticRegression(), 'LR'), (LinearSVC(), 'LinSVC'), (SVC(), 'SVC'),(DecisionTreeClassifier(), 'DT') ]:

    for K in itertools.chain(range(1,6), range(16, 21)):
        print "K: ",K
        X, y = getXyFromCsv('data/y_X_churn_K_' + str(K) + '.csv', fillMissingWith0=True)
        print "Number of features", shape(X)
        print clf
        print performClassification(X, y, clf[0], clf[1], True, scaleX=True)

print "All Done!! Have a great day"
