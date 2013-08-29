from feat_common import *
from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab



YL = 'Avg score of answers with postitive score'
title('K vs ' + YL, {'fontsize':'24'})
xlabel('Number of observation posts(K)', {'fontsize':'24'})
ylabel(YL, {'fontsize':'24'})
fname='data/answers_with_avg_pos_score.csv'
X = genfromtxt(fname, delimiter=',')
#xlim(0, max(X[:, 1]))
'''ylim(0.2, 0.7)
yticks(arange(0.2, 0.7, 0.1))
xticks(arange(0, 21, 1))
'''
Churn = X[X[:, 0] == 1]
NoChurn = X[X[:, 0] == 0]
pylab.plot(Churn[:, 1],  Churn[:, 2], 'd-', label='Dead')
pylab.plot(NoChurn[:, 1], NoChurn[:, 2], 'o-', label='Alive')
legend(prop={'size':'24'}, loc='best')

show()
