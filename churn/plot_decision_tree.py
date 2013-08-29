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
    #return decTree.feature_importances_
    dot_data = StringIO.StringIO()
    tree.export_graphviz(decTree, out_file=dot_data, feature_names=featNames)
    graph = pydot.graph_from_dot_data(dot_data.getvalue())
    graph.write_png(outdir +  "/" + str(label) + "_graph" + ".png")

if __name__ == "__main__":
    infoGains = [0]*10
    i=0
    X, y = getXyFromCsv('data/y_X_churn_K_1.csv', fillMissingWith0=True)
    drawDecTree(DecisionTreeClassifier(max_depth=5, criterion='entropy') , X, y, 'dectreeimg', featNames=churn_featNames, label="new_dectree_for1")
    '''
    return
    for k in  [1, 2, 3, 4, 5, 16, 17, 18, 19, 20]:  #arange(kact, kact+1, 1):
        X, y = getXyFromCsv('data/y_X_churn_K_' + str(k) + '.csv', fillMissingWith0=True)
#        print shape(X)

        m, n = shape(X)
 #   for i in arange(0, n-10, 1):
    #print "Feature ",i,
    #X_1 = X[:, i:i+9]
        X_1 = X
        print shape(infoGains)
        infoGains[i] = drawDecTree(DecisionTreeClassifier(min_samples_leaf=BEST_MINSAMP[k], criterion='entropy', compute_importances=True) , X_1, y, 'dectreeimg', featNames=churn_featNames)
        indarr = argsort(infoGains[i])
        print indarr
        print shape(infoGains)
        print shape(churn_featNames)
        arr = [(churn_featNames[ind], infoGains[i][ind]) for ind in reversed(indarr)]
        savetxt("results/Impfeats_" + str(k) + "_new.csv", arr, fmt="%s", delimiter="=")
        savetxt("results/InfoGains_" + str(k) + "_new.csv", infoGains[i], fmt="%3.2f", delimiter=",")
        i+=1
    #print infoGains
    #savetxt("results/InfoGains.csv", mat(infoGains), fmt="%3.2f", delimiter=",")
    #drawDecTree(DecisionTreeClassifier(compute_importances=True, criterion='entropy', min_samples_leaf=105, max_depth=5), X, y, 'dectreeimg', featNames=featNames)
    '''
