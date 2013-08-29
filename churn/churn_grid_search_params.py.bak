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
    for depth in arange(300, 1000, 50): 
        perf = performClassification(X, y,  DecisionTreeClassifier(min_samples_leaf=depth), 'DT', False)
        #print 'DT',depth,perf
        if mean(perf) > best:
            best = mean(perf)
            bestDepth = depth

    return best, bestDepth

def gridSearchRF(X, y, minSamp=10, maxSamp=300, diff=10):
    print "Using Random Forests"
    best = 0
    bestDepth = -10
    for depth in arange(20, 500, 20): 
        perf = performClassification(X, y,  DecisionTreeClassifier(min_samples_leaf=depth), 'DT', False)
        print 'RF',depth,perf
        if mean(perf) > best:
            best = mean(perf)
            bestDepth = depth
    return best, bestDepth

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
    '''MIN=int(sys.argv[1])
    MAX=int(sys.argv[2])
    k=MIN
    '''
    #while k <= MAX:
    for k in [7, 15, 30]:
        X, y = getXyFromCsv('data/y_X_churn_time_T_' + str(k) + '.csv', fillMissingWith0=True)
        print "Number of samples, Number of features: ", shape(X)
        _,n = shape(X)
   #     X = X[:, n-1:n]
        print "Number of samples, Number of features: ", shape(X)

        print "K: " + str(k)
      #  res = gridSearchRF(X, y)
    #    res = gridSearchDT(X, y)
       # print "Best DT: ",res
        #res = gridSearchLinSVM(X, y)
       # print "Best LSVM: ",res
        res = gridSearchSVMRBF(X, y)
        print "Best RBF: ",res
        res = gridSearchLR(X, y)
        print "Best LR : ",res
   #     k+=1


    
