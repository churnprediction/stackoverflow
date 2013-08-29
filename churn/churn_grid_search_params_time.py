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
    for k in [7, 15, 30]: # [1, 2, 3, 4, 5, 16, 17, 18, 19, 20]:
        X, y = getXyFromCsv('data/y_X_churn_time_T_' + str(k) + '.csv', fillMissingWith0=True)
        print "Number of samples, Number of features: ", shape(X)
        _,n = shape(X)
        Xm1 = X[:, 13:14] #Temporal
        Xm2 = X[:, 23:24] #Temporal
        X0 = X[:, [13, 22, 23, 24, 25]] #Temporal
        X2 = X[:, [0, 1, 2, 14]] #Frequency
        X3 = X[:, [4, 5]] #Quality
        X4 = X[:, [6, 7]] #Consistency
        X5 = X[:, [9]] #Speed
        X6 = X[:, [17, 18]] #Clarity
        X7 = X[:, [8]] #Relative Quality
        X8 = X[:, [15, 16]] #Content  length
        X9 = X[:, [3, 10, 11, 12, 19, 20, 21]] #Knowledge Relevance
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


'''
0 num_posts
1 num_questions
2 num_answers
3 num_answers_recvd
4 a_score
5 q_score
6 a_score_stddev
7 q_score_stddev
8 relative_rank_pos
9 answering_speed
10 mean_rep_co_answerers
11 mean_rep_answerers
12 mean_rep_questioner
14 a_q_ratio
15 a_post_length
16 q_post_length
17 a_comments
18 q_comments
19 num_q_answered
20 mean_max_rep_answerer
21 mean_accepted_answerer_rep
'''
