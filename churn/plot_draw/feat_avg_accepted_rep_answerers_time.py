from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab
from common_mpl_props import *
fig, ax = plt.subplots()


YL = 'Reputation of the accepted answerer'
fname='data/feat_accepted_answerer_time.csv'

ax.set_title('T vs ' + YL, {'fontsize':'24'})
ax.set_xlabel('Observation period(T)', {'fontsize':'24'})
ax.set_ylabel(YL, {'fontsize':'24'})
X = genfromtxt(fname, delimiter=',')
ax.set_ylim((20000, 30000))
#xlim(0, max(X[:, 1]))
'''ylim(0.2, 0.7)
yticks(arange(0.2, 0.7, 0.1))
xticks(arange(0, 21, 1))
'''
Churn = X[X[:, 0] == 1]
NoChurn = X[X[:, 0] == 0]
ax.set_xticklabels(['7', '15', '30', ''])
ax.set_xticks(arange(1, 5, 1)*2)
width=0.35
ax.bar(arange(1, 4, 1)*2-0.35, Churn[:, 2]+[0.1], width, label='Churn', color='r')
ax.bar(arange(1, 4, 1)*2,  NoChurn[:, 2]+[0.1], width, label='Stay', color='g')

legend(prop={'size':'24'},  bbox_to_anchor=(0.2, 0.2), loc=2, borderaxespad=0.)

show()
