from feat_common import *
from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab
import pylibmc

fname='data/all_pos_q_score.csv'

X = genfromtxt(fname, delimiter=',')

#xlim(0, max(X[:, 1]))
'''ylim(0.2, 0.7)
yticks(arange(0.2, 0.7, 0.1))
xticks(arange(0, 21, 1))
'''
Churn = X[X[:, 0] == 1]
NoChurn = X[X[:, 0] == 0]
MedX = matrix([0,0,0])
for K in arange(1, 21, 1):
    churnMed = median(sort(Churn[Churn[:, 1] == K, [2]]))
    noChurnMed = median(sort(NoChurn[NoChurn[:, 1] == K, [2]]))
    MedX = np.concatenate((MedX, mat([1, K, churnMed])))
    MedX = concatenate((MedX, mat([0, K, noChurnMed])))
    #print "1,",K,",",churnMed
    #print "0,",K,",",noChurnMed
m,n = shape(MedX)
MedX = MedX[1:m, :]

Churn = MedX[MedX[:, 0] == 1]
NoChurn = MedX[MedX[:, 0] == 0]
pylab.plot(Churn[:, 1],  Churn[:, 2], 'd-', label='Dead')
pylab.plot(NoChurn[:, 1], NoChurn[:, 2], 'o-', label='Alive')
legend(prop={'size':'24'}, loc='best')
savetxt('data/median_questions_with_pos_score.csv', MedX, fmt='%d', delimiter=',')

show()
