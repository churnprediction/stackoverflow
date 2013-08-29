from sklearn import *
from numpy import *
from classify_utils import *
from plot_decision_tree import *
from sklearn.linear_model import LogisticRegression
from sklearn.cross_validation import LeaveOneOut

#Get the data

def gridSearchDT(X, y, minSamp=20, maxSamp=300, diff=10):
    print "Using Decision Trees"
    best = 0
    bestDepth = -10
    '''
    for depth in arange(minSamp, 150, 10): 
        perf = performClassification(X, y,  DecisionTreeClassifier(min_samples_leaf=depth), 'DT', False)
        #print 'DT',depth,perf
        if mean(perf) > best:
            best = mean(perf)
            bestDepth = depth
    '''        
    for depth in arange(20, 500, 20): 
        perf = performClassification(X, y,  DecisionTreeClassifier(min_samples_leaf=depth, criterion='entropy'), 'DT', False)
        #print 'DT',depth,perf
        if mean(perf) > best:
            best = mean(perf)
            bestDepth = depth

    return best, bestDepth

def gridSearchRF(X, y, minSamp=10, maxSamp=300, diff=10):
    print "Using Random Forests"
    best = 0
    bestParms = -10
    for estimators in arange(40,100,20):
        for max_features in arange(5, 20, 5):
            perf = performClassification(X, y,  RandomForestClassifier(n_estimators=estimators, max_features=max_features), 'DT', False)
            print 'RF',estimators,max_features,perf
            if mean(perf) > best:
                best = mean(perf)
                bestParams = (estimators, max_features)
    return best, bestParams


def gridSearchLinSVM(X, y, minC=1.0/128, maxC=128):
    print "Using SVM with linear kernel"
    C=1.0/128
    best = 0
    bestC = 0
    while C < 128:
        perf = performClassification(X, y,  SVC(kernel='linear', C=C), 'SVC', False, scaleX=True)
        print "LSVM",C,perf
        if mean(perf) > best:
            best = mean(perf)
            bestC = C
        C*=2
    return best, bestC

def gridSearchSVMRBF(X, y, minC=1.0/128, maxC=128, minGamma=1.0/1024, maxGamma=8):
    print "Using SVM with RBF kernel"
    C=1.0/128
    best = 0
    bestC = 0
    bestGamma = 0
    while C < 8:
        gam = 1.0/1024
        while gam < 4:
            perf = performClassification(X, y,  SVC(kernel='rbf', C=C, gamma=gam), 'SVC', False, scaleX=True)
            print 'LRBF',C,gam,perf
            gam *= 2
            if mean(perf) > best:
                best = mean(perf)
                bestC = C
                bestGamma = gam
        C*=2
    return best, bestC, bestGamma

def gridSearchLR(X, y, minC=1.0/128, maxC=128):
    print "Using Logistic Regression"
    C=1.0/128
    regs = ['l1', 'l2']
    best = 0
    bestC = 0
    bestReg = 'l1'
    while C < 128:
        for reg in regs:
            perf = performClassification(X, y,  LogisticRegression( C=C, penalty=reg), 'SVC', False)
            print 'LRC',C,reg,perf
        C*=2
        if mean(perf) > best:
            best = mean(perf)
            bestC = C
            bestReg = reg
    return best, bestC, bestReg

if __name__ == "__main__":
#    MIN=int(sys.argv[1])
#    MAX=int(sys.argv[2])
    bestDepth = []
    bestRes = []
    for k in arange(1, 21, 1): # [1, 2, 3, 4, 5, 16, 17, 18, 19, 20]:
        X, y = getXyFromCsv('data/y_X_churn_K_' + str(k) + '.csv', fillMissingWith0=True)
        print "Number of samples, Number of features: ", shape(X)
        _,n = shape(X)
        Xm1 = X[:, n-1:n] #Temporal
        X0 = X[:, n-k:n-k+1] #Temporal
        X1 = X[:, n-k:n] #Temporal
        X2 = X[:, [0, 1, 13]] #Frequency
        X3 = X[:, [3, 4]] #Quality
        X4 = X[:, [5, 6]] #Consistency
        X5 = X[:, [8]] #Speed
        Xsp = X[:, [8, 7]]
        X6 = X[:, [16, 17]] #Clarity
        X7 = X[:, [7]] #Relative Quality
        X8 = X[:, [14, 15]] #Content length
        X9 = X[:, [9, 10, 11, 12, 19, 20]] #Knowledge Relevance
        print "Number of samples, Number of features: ", shape(X)

        print "K: " + str(k)
      #  res = gridSearchRF(X, y)
        res = gridSearchRF(X, y)
        print "Best DT: ",res
        bestDepth.append(res[1])
        bestRes.append(res[0])
        #res = gridSearchLinSVM(X, y)
       # print "Best LSVM: ",res
   #     res = gridSearchSVMRBF(X, y)
   #     print "Best RBF: ",res
   #     res = gridSearchLR(X, y)
   #     print "Best LR : ",res
        k+=1
    print bestDepth
    print bestRes


    
