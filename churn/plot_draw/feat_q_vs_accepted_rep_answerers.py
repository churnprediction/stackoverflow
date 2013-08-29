from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab

matplotlib.rc('xtick', labelsize=20)
matplotlib.rc('ytick', labelsize=20)
matplotlib.rc('font', weight='bold')
matplotlib.rc('font', size='30')
matplotlib.rc('lines', linewidth=4)
matplotlib.rc('legend', fontsize=24)
matplotlib.rc('legend', loc='best')
matplotlib.rc('axes', labelsize=24) #      : medium  # fontsize of the x any y labels
matplotlib.rc('axes', grid=True) #      : medium  # fontsize of the x any y labels
matplotlib.rc('axes', labelweight='bold') #      : medium  # fontsize of the x any y labels
#axes.labelweight    : normal  # weight of the x and y labels
#grid.color       :   black   # grid color
matplotlib.rc('grid', linewidth=1.5) #      : medium  # fontsize of the x any y labels


YL = 'Reputation of the accepted answerer'
fname='data/feat_q_vs_accepted_rep_answerers.csv'

title('K vs ' + YL, {'fontsize':'24'})
xlabel('Number of questions', {'fontsize':'24'})
ylabel(YL, {'fontsize':'24'})
X = genfromtxt(fname, delimiter=',')
#xlim(0, max(X[:, 1]))
'''ylim(0.2, 0.7)
yticks(arange(0.2, 0.7, 0.1))
xticks(arange(0, 21, 1))
'''
Churn = X[X[:, 0] == 1]
NoChurn = X[X[:, 0] == 0]
pylab.plot(Churn[:, 1],  Churn[:, 2], 'd-', label='Churn', color='r')
pylab.plot(NoChurn[:, 1], NoChurn[:, 2], 'o-', label='Stay',color="g")
legend(prop={'size':'24'}, loc='best')

show()