from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab

fname = 'data/temporal_gap_'

#title('K vs Reputation of the questioner for various ranges')

def drawParent():
    f=figure(figsize=(15, 10))
    ax = f.add_subplot(111) 
# Turn off axis lines and ticks of the big subplot
    ax.spines['top'].set_color('none')
    ax.spines['bottom'].set_color('none')
    ax.spines['left'].set_color('none')
    ax.spines['right'].set_color('none')
#ax.set_xticks([0, 0])
    ax.set_yticks([100000, 100000])
    ax.tick_params(labelcolor='none',  top='off', bottom='off', left='off', right='off')

    ax.set_title('K vs Timegaps', {'fontsize':'24'})
    ax.set_xlabel('Number of observation posts(K)', {'fontsize':'15'})
    ax.set_ylabel('Mean timegap between posts (in minutes)' , {'fontsize':'15'})
    return f

def drawRep(fig, gridNum, gapNum):
    global fname
    X = genfromtxt(fname + str(gapNum) + ".csv", delimiter=',')
    ax = fig.add_subplot(2,2,gridNum, xmargin=0.05)
    ax.yaxis.grid(color='gray', linestyle='dashed')
    ax.xaxis.grid(color='gray', linestyle='dashed')

    ax.set_xlim([0, 21])
    ax.set_title('Post ' + str(gapNum-1) + ' - Post ' + str(gapNum), {'fontsize':'12'})
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
for i in range(20):
    if i%4 == 0:
        fig = drawParent()
    drawRep(fig, i%4+1, i+1)
    if i%4 == 3:
        show()
#f.tight_layout()

