from numpy import *
from sklearn import tree
from random import randint
from sklearn.tree import DecisionTreeClassifier
from classify_utils import *
from feat_props import *
import StringIO, pydot
from pylab import *

if __name__ == "__main__":
    kact = int(sys.argv[1])
    for k in arange(kact, kact+1, 1):
        #X = genfromtxt("InfoGains_1_20.csv", delimiter=",")
        infoGain = genfromtxt("InfoGains_" + str(k) + ".csv", delimiter=",")
        for featIdx in list(reversed(argsort(infoGain))):
           print churn_featNames[featIdx],":", infoGain[featIdx]

