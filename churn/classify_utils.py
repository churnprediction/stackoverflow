#Jagat 11/04/13
#Runs 5 fold cross validation using linear SVM 
#68.5% accuracy
#Args: X file csv, y file
import sklearn
import numpy as np
from sklearn.svm import LinearSVC
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC
from sklearn import grid_search
from sklearn.cross_validation import StratifiedKFold
from sklearn.cross_validation import ShuffleSplit
from sklearn.cross_validation import LeaveOneOut
from sklearn.ensemble import RandomForestClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from numpy import *
from pylab import *
from matplotlib import *
from sklearn.preprocessing import scale
from sklearn.metrics import *
import sys
import datetime

DBG=True
def debug(msg):
    if(DBG):
        print datetime.datetime.now(),":",msg
    
def getXyFromCsv(X_csv, y_csv=None, fillMissingWith0=False):
    debug("Reading X,y from " + X_csv )
    X = matrix(np.genfromtxt(X_csv, delimiter=","))
    if fillMissingWith0:
        X[isnan(X)] = 0
    if y_csv == None:
        y = array(X[:, 0].T)[0]
        X = X[:, 1:]
    else:
        y = np.genfromtxt(y_csv, delimiter=",")
    debug("Done reading")
    return array(X), y

def gridCVParams(numFeats, numSamples):
    debug("Fetching cv params")
    paramMap = {}
    cvals = []
    gammaVals = []
    cvalstart = 1/16.0
    while cvalstart <= 16:
        cvals.append(cvalstart)
        gammaVals.append(cvalstart)
        cvalstart = cvalstart * 2;

    paramMap['LR'] = {'C':cvals, 'penalty':['l1', 'l2']}
    paramMap['LinSVC'] = {'C':cvals}
    paramMap['SVC'] = {'C':cvals, 'gamma':gammaVals}
    paramMap['DT'] = {'compute_importances':[True], 'min_samples_leaf':arange(100, numSamples/10, 10) }
    paramMap['RF'] = {'compute_importances':[True], 'min_samples_leaf':arange(100, numSamples/10, 10) }
    
    debug("Returning cv params")
    debug(paramMap)
    return paramMap


def cv(X, y, clf, gridSearch=False, gridSearchParams=None, score_type=None, numFolds=10):
    
    skf = StratifiedKFold(y, 10)
    if(gridSearch):
        debug("Performing a Grid Search")
        clf = grid_search.GridSearchCV(clf, gridSearchParams, refit=True)
        #clf.fit(X, y)
        debug("Best params")
        #print clf.best_params_
        debug("Best estimator")
        #print clf.best_estimator_
        #clf = clf.best_estimator_
    debug(clf)
    #skf = LeaveOneOut(len(y)) ; print 'Performing LOOCV'
    
    debug("Running CV")
    accuracies = sklearn.cross_validation.cross_val_score(clf, X, y, cv=skf, n_jobs=8, score_func=score_type)
    debug("Done running CV")
    if score_type == None:
       print "Mean", np.mean(accuracies), "Standard Deviation", np.std(accuracies)
    return accuracies

def performClassification(X, y, clf, classifierKey='DT', gridSearch=False, params = None, score_type=None, scaleX=True):
    debug("Performing classification")
    numSamps = shape(y)
    numFeats = shape(X)[1]
    if(params == None):
        params = gridCVParams(numFeats, numSamps[0])[classifierKey]
    if(scaleX): X = scale(X)
    acc = cv(scale(X), y, clf, gridSearch=gridSearch, \
            gridSearchParams=params, score_type=score_type)
    debug("Done performing classification")
    return acc
