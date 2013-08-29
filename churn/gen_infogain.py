from numpy import *
from sklearn import tree
from random import randint
from sklearn.tree import DecisionTreeClassifier
from classify_utils import *
from feat_props import *
import StringIO, pydot
from pylab import *

def drawDecTree(decTree, X, y, outdir, label=randint(100), featNames=None):
    decTree.fit(X, y)
    return decTree.feature_importances_

if __name__ == "__main__":
    infoGains = [0]*3
    i=0
    for T in  [30]:  #arange(kact, kact+1, 1):
        X, y = getXyFromCsv('data/y_X_churn_time_T_' + str(T) + '.csv', fillMissingWith0=True)
#        print shape(X)

        m, n = shape(X)
    #print "Feature ",i,
    #X_1 = X[:, i:i+9]
        print shape(infoGains)
        X_1 = X
        infoGains[i] = drawDecTree(DecisionTreeClassifier(min_samples_leaf=BEST_MINSAMP_T[i], 
                                criterion='entropy', compute_importances=True) , X_1, y, 'dectreeimg', featNames=churn_featNames_time)
        indarr = argsort(infoGains[i])
        print indarr
        print shape(infoGains)
        print shape(churn_featNames_time)
        arr = [(churn_featNames_time[ind], infoGains[i][ind]) for ind in reversed(indarr)]
        savetxt("results/Impfeats_time_" + str(T) + "_new.csv", arr, fmt="%s", delimiter="=")
        savetxt("results/InfoGains_time_" + str(T) + "_new.csv", infoGains[i], fmt="%3.2f", delimiter=",")
        i+=1
    #print infoGains
    #savetxt("results/InfoGains.csv", mat(infoGains), fmt="%3.2f", delimiter=",")
    #drawDecTree(DecisionTreeClassifier(compute_importances=True, criterion='entropy', min_samples_leaf=105, max_depth=5), X, y, 'dectreeimg', featNames=featNames)
