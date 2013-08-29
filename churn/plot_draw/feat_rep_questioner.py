from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab

fname = 'data/feat_avg_questioner_rep'

#title('K vs Reputation of the questioner for various ranges')


f=figure(figsize=(15, 10))
ax = f.add_subplot(111) 
# Turn off axis lines and ticks of the big subplot
ax.spines['top'].set_color('none')
ax.spines['bottom'].set_color('none')
ax.spines['left'].set_color('none')
ax.spines['right'].set_color('none')
#ax.set_xticks([0, 0])
#ax.set_yticks([0, 0])
ax.tick_params(labelcolor='none',  top='off', bottom='off', left='off', right='off')

ax.set_title('K vs Questioner Reputation', {'fontsize':'24'})
ax.set_xlabel('Number of observation posts(K)', {'fontsize':'15'})
ax.set_ylabel('Reputation of the questioner for various ranges' , {'fontsize':'15'})

def drawRep(repNum, rg):
    global fname
    global fig
    X = genfromtxt(fname + str(repNum) + ".csv", delimiter=',')
    ax = f.add_subplot(2,2,repNum, xmargin=0.05)
    ax.yaxis.grid(color='gray', linestyle='dashed')
    ax.xaxis.grid(color='gray', linestyle='dashed')

    ax.set_title(str(rg[0]) + ' <= reputation  <= ' + str(rg[1]), {'fontsize':'12'})
    #xlim(0, max(X[:, 1]))
    '''ylim(0.2, 0.7)
    yticks(arange(0.2, 0.7, 0.1))
    xticks(arange(0, 21, 1))
    '''
    Churn = X[X[:, 0] == 1]
    NoChurn = X[X[:, 0] == 0]
    ax.plot(Churn[:, 1],  Churn[:, 2], 'd-', label='Dead')
    ax.plot(NoChurn[:, 1], NoChurn[:, 2], 'o-', label='Alive')
    ax.legend(prop={'size':'12'}, loc='best')

ranges = [(1, 67), (68, 445), (446, 1640), (1640, 456000)]
for i in range(4):
    drawRep(i+1, ranges[i])
#f.tight_layout()
show()

