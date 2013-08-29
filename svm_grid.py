#68.5% accuracy
#Args: X file csv, y file
import sklearn
import numpy as np
from sklearn.svm import LinearSVC
from sklearn.svm import SVC
from sklearn import grid_search
from sklearn.cross_validation import StratifiedKFold
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report

import sys

X = np.genfromtxt(sys.argv[1], delimiter=",")
y = np.genfromtxt(sys.argv[2], delimiter=",")

def cv():
    #clf = LinearSVC()
    #clf = RandomForestClassifier(n_jobs=16)
    clf = SVC()
    skf = StratifiedKFold(y, 5)
    accuracies = sklearn.cross_validation.cross_val_score(clf, X, y, cv=skf, n_jobs=16)
    print accuracies
    print np.sum(accuracies)/5.0

def gridCv():
    cvals = []
    cvalstart = 0.1
    while cvalstart < 1025:
        cvals.append(cvalstart)
        cvalstart = cvalstart * 2

    parameters = {'C':cvals}
    svr = SVC()
    #clf = grid_search.GridSearchCV(svr, parameters, refit=True)
    #clf.fit(X, y)
    skf = StratifiedKFold(y, 10)
    report = sklearn.cross_validation.cross_val_score(LinearSVC(), X, y, cv=skf, n_jobs=16, score_func=classification_report)
    print "Grid"
    print repr(report)


gridCv()
