from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab



fig = pylab.figure()    
ax = fig.add_subplot(1,1,1)
title('K vs Avg score received per question', {'fontsize':'24'})
xlabel('Number of observation posts(K)', {'fontsize':'24'})
ylabel('Avg score received per question', {'fontsize':'24'})
fname='data/feat_avg_q_score.csv'
X = genfromtxt(fname, delimiter=',')
#xlim(0, max(X[:, 1]))
'''ylim(0.2, 0.7)
yticks(arange(0.2, 0.7, 0.1))
xticks(arange(0, 21, 1))
'''
xticks(arange(0, 20, 1))
ax.yaxis.grid(color='gray', linestyle='dashed')
ax.xaxis.grid(color='gray', linestyle='dashed')
Churn = X[X[:, 0] == 1]
NoChurn = X[X[:, 0] == 0]
ax.plot(Churn[:, 1],  Churn[:, 2], 'd-', label='Dead')
ax.plot(NoChurn[:, 1], NoChurn[:, 2], 'o-', label='Alive')
legend(prop={'size':'24'}, loc='best')

show()
